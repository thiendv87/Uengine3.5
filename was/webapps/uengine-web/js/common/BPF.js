/**
 *------------------------------------------------------------------------------
 * PROJ : wooribank
 * NAME : BPF.js
 * DESC : JSON Data를 Control에 Binding하여 render
 * Depend : prototype.js
 * Author : iblackpet_admin
 * VER  : v1.0  * 
 *------------------------------------------------------------------------------
 *                  변         경         사         항                       
 *------------------------------------------------------------------------------
 *    DATE     AUTHOR                      DESCRIPTION                        
 * ----------  ------  --------------------------------------------------------- 
 * 2007. 12. 05  	iblackpet_admin  최초 프로그램 작성                                     
 *----------------------------------------------------------------------------
 */
 
var BPF = {};

BPF.ResultProcess = {
	REDIRECT_TYPE_HREF: 1,
	REDIRECT_TYPE_REPLACE: 2,
	
	TARGET_SELF: 1, 
	TARGET_TOP: 2,
	TARGET_OPENER: 3,
	TARGET_PARENT: 4,
	Type: {
			ALERT: "BPF.ResultProcess.Alert",
			RELOAD: "BPF.ResultProcess.Reload",
			REDIRECT: "BPF.ResultProcess.Redirect",
			CLOSE: "BPF.ResultProcess.Close",
			CALLBACK: "BPF.ResultProcess.Callback"
	}
};


/**
 * BPF.ResultProcessJob Constructor
 * 
 * @param jobs [ job1, job2, job3, ... ]
 */
BPF.ResultProcessJob = function( jobs ) {
		this.jobs = jobs;
};

BPF.ResultProcessJob.prototype = {
	
	/**
	 * execute job in jobs
	 */
	execute: function() {
		for( var i = 0; i < this.jobs.length; i++ ) {
			// 분기 execute!]
			eval( BPF.ResultProcess.Type[ this.jobs[i].type ] ).execute( this.jobs[i] );
		}
	}
}; // BPF.ResultProcessJob.prototype


/**
 * Alert Process
 * 
 * @data { type: "ALERT", message: "arise error!!" }
 */
BPF.ResultProcess.Alert = {
	execute: function( obj ) {
		alert( obj.message );
	}
};
Object.extend( BPF.ResultProcess.Alert, BPF.ResultProcess );

/**
 * Reload Process
 * 
 * reload opener window
 * @data { type: "RELOAD", target: 3 }
 * @config target TARGET_OPENER
 */
BPF.ResultProcess.Reload = {
	execute: function( obj ) {
		// self, top의 경우 RELOAD에서는 지원할 수 없다! (무한 호출되므로)
		if( obj.target == this.TARGET_SELF || obj.target == this.TARGET_TOP || obj.target == this.TARGET_PARENT) return;
		
		if( opener ) opener.location.reload();
	}
};
Object.extend( BPF.ResultProcess.Reload, BPF.ResultProcess );

/**
 * Redirect Process
 * 
 * redirect self/top/opener
 * @data { type: "REDIRECT", uri: "/wooribank/main", redirectType: 2, target: 1 }
 * @config redirectType REDIRECT_TYPE_HREF, REDIRECT_TYPE_REPLACE
 * @config target TARGET_SELF, TARGET_TOP, TARGET_OPENER
 */
BPF.ResultProcess.Redirect = {
	execute: function( obj ) {
		// TARGET에 따른 분기처리! (default: self)
		var target = "self.";
		switch( obj.target ) {
			case this.TARGET_SELF :
				target = "self.";
				break;
			case this.TARGET_TOP :
				target = "top.";
				break;
			case this.TARGET_OPENER :
				target = "opener.";
				break;
			case this.TARGET_PARENT : 
				target = "parent.";
				break;
		}
		// REDIRECT_TYPE에 따른 분기처리! (default: replace)
		if( obj.redirectType == this.REDIRECT_TYPE_HREF ) {
			eval( target + "location.href = '" + obj.uri + "';" );
		} else {
			eval( target + "location.replace('" + obj.uri + "');" );
		}
	}
};
Object.extend( BPF.ResultProcess.Redirect, BPF.ResultProcess );

/**
 * Close Process
 * 
 * close top/opener
 * @data { type: "CLOSE", target: 2 }
 * @config target TARGET_TOP, TARGET_OPENER
 */
BPF.ResultProcess.Close = {
	execute: function( obj ) {
		// TARGET에 따른 분기처리! (default: top)
		if( obj.target == this.TARGET_OPENER ) {
			if( opener ) opener.close();
		} else {
			// BPF.Popup 여부에 따른 처리!
			if( opener ) {
				opener.focus();
				self.close();
			}
		}
	}
};
Object.extend( BPF.ResultProcess.Close, BPF.ResultProcess );

/**
 * convert json data to form control as hidden elements for submit
 */
BPF.Json = Class.create();
Object.extend( BPF.Json, {
	/**
	 * convert json data to form control as hidden elements
	 * 
	 * @param json : (Object) json data
	 * @param frmId : (String) FORM id
	 * @param (Optional) mehtod : (String) FORM method type [post/get]
	 * 
	 * @return (String) FORM id
	 */
	jsonToForm: function( json, frmId, method ) {
		// create FORM if not exists
		var frm = this.createForm( frmId, method );
		
		// json object type에 따른 분기! (Array / Hash)
		if( Object.isArray( json ) ) {
			var item = null;
			for( var i = 0, size = json.size(); i < size; i++ ) {
				this.appendHashToForm( $H( json[i] ), frm );
			}
		} else {
			this.appendHashToForm( $H( json ), frm );
		}
		return frmId;
	},
	
	/**
	 * create FORM if not exists
	 * 
	 * @param frmId : (String) FORM id
	 * @param (Optional) method : (String) FORM method type [post/get]
	 * 
	 * @return (Object) FORM
	 */
	createForm: function( frmId, method ) {
		var frm = $( frmId );
		method = method ? method : "post";
		// not exists FORM, create FORM
		if( !frm ) {
			$( document.body ).insert( '<form id="#{frmId}" name="#{frmId}" method="#{method}">'.interpolate( {
					frmId: frmId,
					method: method
				} ) // end of interpolate()
			);
			frm = $( frmId );
		}
		return frm;
	},
	
	/**
	 * append Hash pairs to FORM control as hidden elements
	 * 
	 * @param h : (Hash)
	 * @param frm : (Object) FORM
	 */
	appendHashToForm: function( h, frm ) {
		h.each( function( pair ) {
			frm.insert( '<input type="hidden" name="#{key}" value="#{value}" class="fromJson">'.interpolate( {
					key: pair.key,
					value: pair.value
				} ) // end of interpolate()
			);
		} );
	},
	
	/**
	 * remove added FORM elements (hidden control)
	 */
	removeFormElements: function( frmId ) {
		$$( "#" + frmId + " INPUT.fromJson" ).invoke( "remove" );
	}

} );

