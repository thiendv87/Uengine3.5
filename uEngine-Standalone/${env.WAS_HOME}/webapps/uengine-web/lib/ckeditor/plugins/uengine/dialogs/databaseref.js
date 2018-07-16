﻿/*
Created by yookjy 2010.12.30
*/
CKEDITOR.dialog.add( 'databaseref', function( editor )
{
	return {
		title : 'DatabaseRef Properties',
		databaseref : null,
		minWidth : 300,
		minHeight : 370,
		onShow : function()
		{
			delete this.databaseref;

			var editor = this.getParentEditor(),
				selection = editor.getSelection(),
				element = selection.getSelectedElement();

			if ( element && element.getAttribute( '_cke_real_element_type' ) && element.getAttribute( '_cke_real_element_type' ) == 'databaseref' )
			{
				this.databaseref = element;
				element = editor.restoreRealElement( this.databaseref );
				
				if (element.getAttribute('tablename' ) != '') {
					this.getContentElement('info', 'set_btn').click();
				}
				
				var sqlTemp = this.getValueOf( 'info', 'sql' );
				sqlTemp = sqlTemp.replace(eval("/$/gi"), "'"); 
				sqlTemp = sqlTemp.replace(eval("/@/gi"), "%"); 
				this.setValueOf( 'info', 'sql' );
				
				this.setupContent( element );
				selection.selectElement( this.databaseref );
			}
		},
		onOk : function()
		{
			var name = this.getValueOf( 'info', 'ref_name' ),
				editor = this.getParentEditor(),
				element = CKEDITOR.env.ie ? editor.document.createElement( '<input:databaseref name="' + CKEDITOR.tools.htmlEncode( name ) + '">' ) : editor.document.createElement( 'input:databaseref' );
			
			this.commitContent( element );
			var fakeElement = editor.createFakeElement( element, 'uengine_databaseref', 'databaseref' );
			if ( !this.databaseref )
				editor.insertElement( fakeElement );
			else
			{
				fakeElement.replace( this.databaseref );
				editor.getSelection().selectElement( fakeElement );
			}
			
			var sqlTemp = this.getValueOf( 'info', 'sql' );
			sqlTemp = sqlTemp.replace(eval("/'/gi"), "$"); 
			sqlTemp = sqlTemp.replace(eval("/%/gi"), "@"); 
			this.setValueOf( 'info', 'sql' );
			
			return true;
		},
		contents : [
			{
				id : 'info',
				label : 'DatabaseRef',
				title : 'DatabaseRef',
				elements : [
					{
						id : 'ref_name',
						type : 'text',
						label : 'DatabaseRef Name',
						'default' : '',
						accessKey : 'N',
						setup : function( element )
						{
							this.setValue(element.getAttribute( 'name' ) ||'' );
						},
						commit : function( element )
						{
							if ( this.getValue() )
								element.setAttribute( 'name', this.getValue() );
							else
							{
								element.removeAttribute( 'name' ) ;
							}
						}
					},
					{
						type : 'hbox',
						widths : [ '250px', '50px'],
						align : 'top',
						children :
						[
							{
								id : 'dsn_name',
								type : 'text',
								label : 'Data Source Name',
								'default' : 'java:/uEngineDS',
								accessKey : 'D',
								setup : function( element )
								{
									this.setValue(element.getAttribute( 'dsn' ) ||'' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
										element.setAttribute( 'dsn', this.getValue() );
									else
									{
										element.removeAttribute( 'dsn' ) ;
									}
								}
							},
							{
								id : 'set_btn',
								type : 'button',
								label : 'Set',
								'default' : '',
								accessKey : 'S',
								onClick : function( ev )
								{
									$.ajax({
										async : false,
										url: CKEDITOR.plugins.getPath('uengine') + 'dialogs/databaseref/getTableInfoJson.jsp',
										data : {dataSourceName:this.getDialog().getValueOf('info', 'dsn_name')},
										type: "POST",
									    dataType: "json",
										success: function(data, textStatus, XMLHttpRequest) {
											var dialog = CKEDITOR.dialog.getCurrent();
											var tableNames = data.name;
											var element = dialog.getContentElement('info', 'table_name');
											initSelectBoxAll(element, 
													dialog.getContentElement('info', 'dsp_field'), 
													dialog.getContentElement('info', 'val_field'),
													dialog.getContentElement('info', 'sql'));
											for (var i=0; i<tableNames.length; i++) {
												element.add(tableNames[i], tableNames[i], i + 1);
											}
										},
										error : function (XMLHttpRequest, textStatus, errorThrown) {
											alert('Can not load table data');
										}
									});
								}
							}
						]
					},
					{
						id : 'table_name',
						type : 'select',
						label : 'Table Name',
						'default' : '',
						accessKey : 'T',
						items :
						[
							[ '-- Select --', '' ]
						],
						setup : function( element )
						{
							this.setValue( element.getAttribute( 'tablename' ) || '' );
						},
						commit : function( element )
						{
							if ( this.getValue() )
							{
								element.setAttribute( 'tablename', this.getValue() );
							}
							else 
							{
								element.removeAttribute( 'tablename');
							}
						},
						onChange : function ( ev ) 
						{
							initSelectBox(this.getDialog().getContentElement('info', 'dsp_field')); 
							initSelectBox(this.getDialog().getContentElement('info', 'val_field'));
							this.getDialog().getContentElement('info', 'sql').setValue('');
							$.ajax({
								async : false,
								url: CKEDITOR.plugins.getPath('uengine') + 'dialogs/databaseref/getColumnInfoJson.jsp',
								data : {dataSourceName:this.getDialog().getValueOf('info', 'dsn_name'), tableName:this.getDialog().getValueOf('info', 'table_name')},
								type: "POST",
							    dataType: "json",
								success: function(data, textStatus, XMLHttpRequest) {
									var columnNames = data.name;
									var selectBoxes = ['dsp_field', 'val_field'];
									for (var s=0; s<selectBoxes.length; s++) {
										var element = CKEDITOR.dialog.getCurrent().getContentElement('info', selectBoxes[s]);
										for (var i=0; i<columnNames.length; i++) {
											element.add(columnNames[i], columnNames[i], i + 1);
										}
									}
								},
								error : function (XMLHttpRequest, textStatus, errorThrown) {
									alert('Can not load table data');
								}
							});
						}
					},
					{
						id : 'dsp_field',
						type : 'select',
						label : 'Display Name Field',
						'default' : '',
						accessKey : 'D',
						items :
						[
							 [ '-- Select --', '' ]
						],
						setup : function( element )
						{
							this.setValue( element.getAttribute( 'displayfield' ) || '' );
						},
						commit : function( element )
						{
							if ( this.getValue() )
							{
								element.setAttribute( 'displayfield', this.getValue() );
							}
							else 
							{
								element.removeAttribute( 'displayfield');
							}
						},
						onChange : function ( ev ) 
						{
							var tabelElement = this.getDialog().getContentElement('info', 'table_name');
							var dpElement = this.getDialog().getContentElement('info', 'dsp_field');
							var valElement = this.getDialog().getContentElement('info', 'val_field');
							var sqlElement = this.getDialog().getContentElement('info', 'sql');
							setSql(tabelElement, valElement, dpElement, sqlElement);
						}
					},
					{
						id : 'val_field',
						type : 'select',
						label : 'Value Field',
						'default' : '',
						accessKey : 'V',
						items :
						[
							 [ '-- Select --', '' ]
						],
						setup : function( element )
						{
							this.setValue( element.getAttribute( 'codefield' ) || '' );
						},
						commit : function( element )
						{
							if ( this.getValue() )
							{
								element.setAttribute( 'codefield', this.getValue() );
							}
							else 
							{
								element.removeAttribute( 'codefield');
							}
						},
						onChange : function ( ev ) 
						{
							var tabelElement = this.getDialog().getContentElement('info', 'table_name');
							var dpElement = this.getDialog().getContentElement('info', 'dsp_field');
							var valElement = this.getDialog().getContentElement('info', 'val_field');
							var sqlElement = this.getDialog().getContentElement('info', 'sql');
							setSql(tabelElement, valElement, dpElement, sqlElement);
						}
					},
					{
						id : 'sql',
						type : 'textarea',
						label : 'SQL',
						rows : 5,
						'default' : '',
						accessKey : 'N',
						setup : function( element )
						{
							this.setValue(element.getAttribute( 'sql' ) ||'' );
						},
						commit : function( element )
						{
							if ( this.getValue() )
								element.setAttribute( 'sql', this.getValue() );
							else
							{
								element.removeAttribute( 'sql' ) ;
							}
						}
					},
					{
						id : 'view_mode',
						type : 'checkbox',
						label : 'View Mode',
						'default' : '',
						accessKey : 'V',
						value : "checked",
						setup : function( element )
						{
							this.setValue( element.getAttribute( 'viewmode' ) == 1 ? 'checked' : '' );
						},
						commit : function( element )
						{
							element.setAttribute( 'viewmode', this.getValue() ? 1 : 0 );
						}
					}
				]
			}
		]
	};
});

function setSql(tableElement, valElement, dpElement, sqlElement) {
	if (tableElement.getValue() == "" || valElement.getValue() == "" || dpElement.getValue() == "") return;
	
	var sql = 'select \n' 
		    + '       ' + valElement.getValue() + ' as value,\n' 
		    + '       ' + dpElement.getValue() + ' as displayValue\n' 
		    + '  from ' + tableElement.getValue();
	sqlElement.setValue(sql);
}

function initSelectBox(element) {
	element.clear();
	element.add('-- Select --', '', 0);
}

function initSelectBoxAll(tableElement, valElement, dpElement, sqlElement) {
	initSelectBox(tableElement);
	initSelectBox(valElement);
	initSelectBox(dpElement);
	sqlElement.setValue("");
}