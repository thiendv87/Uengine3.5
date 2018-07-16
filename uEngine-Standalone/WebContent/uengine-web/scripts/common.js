var isIE = (navigator.userAgent.indexOf('MSIE') > 0);

Array.prototype.add = function(element) {
	var len = this.length;
	this[len] = element;
}
Array.prototype.remove = function (idx) {
	var temp = new Array();
	var j = 0;

	for(i=0; i<idx; i++) {
		temp[j++] = this[i];
	}

	for(i=idx+1; i<this.length; i++) {
		temp[j++] = this[i];
	}
	this.length=0;
	for(i=0; i<temp.length; i++) {
		this[i] = temp[i];
	}
}

String.prototype.replaceAll = function(str1, str2) {
	var temp_str = this.trim();
	temp_str = temp_str.replace(new RegExp(str1, "gi"), str2);

	return temp_str;
}

String.prototype.trim = function() {
	 return this.replace(/(^\s*)|(\s*$)/gi, "");
}

/********************************************************************
 * Description : is null check
 *
 * @param str
 * @return 
 * @author sungyeol-jung
 ********************************************************************/
function isEmpty(str) {
   if (str == undefined || str == null || str.trim() == "") return true;

   return false;
}

/********************************************************************
 * Description : email type check
 *
 * @param str
 * @return 
 * @author sungyeol-jung
 ********************************************************************/
function isEmail(str) {   
    if(str == null) return false;
            
    str = str.trim();
    
    if(str.search(/^\s*[\w\~\-\.\|]+\@[\w\~\-]+(\.[\w\~\-]+)+\s*$/g) >= 0) {
        return true;
    } else { 
        return false;
    }
}