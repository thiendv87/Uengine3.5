﻿/*
Created by yookjy 2010.12.30
*/
/**
 * @file Uengine Plugin
 */
CKEDITOR.plugins.add( 'uengine',
{
	init : function( editor )
	{
		var addCss = function( buttonName, imgPath )
		{
			editor.addCss(
					'img.uengine_' + buttonName +
					'{' +
						'background-image: url(' + CKEDITOR.getUrl( imgPath ) + ');' +
						'background-position: center right;' +
						'background-repeat: no-repeat;' +
						'border: 1px solid #a9a9a9;' +
						'width: 100px !important;' +
						'height: 20px !important;' +
					'}' );
		};
		var notSupportFunction = ['AddRow'];
		//var notSupportFunction = [''];
		// All buttons use the same code to register. So, to avoid
		// duplications, let's use this tool function.
		var addButtonCommand = function( buttonName, commandName, dialogFile, buttonImg )
		{
			editor.ui.addButton( buttonName,
					{
				label : buttonName,
				command : commandName,
				icon : buttonImg
					});
			
			var isNotSupport = false;
			for (var i=0; i<notSupportFunction.length; i++) {
				if (notSupportFunction[i] == buttonName) {
					isNotSupport = true;
					break;
				}
			}
			
			if (isNotSupport) {
				editor.addCommand( commandName, {
					exec : function(editor) {
						alert("This function does not supported by uEngine community edition.");
					}
				});
			} else {
				editor.addCommand( commandName, new CKEDITOR.dialogCommand( commandName ) );
				CKEDITOR.dialog.add( commandName, dialogFile );
			}
		};

		var dialogPath = this.path + 'dialogs/';
		var imagePath = this.path + 'images/';
		
		addCss('calendar', imagePath + 'calendar.gif');
		addCss('finduser', imagePath + 'finduser.gif');
		addCss('fileupload', imagePath + 'fileupload.gif');
		addCss('richtextarea', imagePath + 'richtextarea.gif');
		addCss('databaseref', imagePath + 'databaseref.gif');
		addCss('addrow', imagePath + 'addrow.gif');
		
		addButtonCommand( 'Calendar', 'calendar', dialogPath + 'calendar.js', imagePath + 'calendar.gif');
		addButtonCommand( 'FindUser', 'finduser', dialogPath + 'finduser.js', imagePath + 'finduser.gif');
		addButtonCommand( 'FileUpload', 'fileupload', dialogPath + 'fileupload.js', imagePath + 'fileupload.gif');
		addButtonCommand( 'RichTextArea', 'richtextarea', dialogPath + 'richtextarea.js', imagePath + 'richtextarea.gif');
		addButtonCommand( 'DatabaseRef', 'databaseref', dialogPath + 'databaseref.js', imagePath + 'databaseref.gif');
		addButtonCommand( 'AddRow', 'addrow', dialogPath + 'addrow.js', imagePath + 'addrow.gif');
	
		/* FormTemplate */
		CKEDITOR.dialog.addIframe('formtemplate', 'FormTemplate Properties', dialogPath + 'formtemplate/template.jsp', 790, 450, function(){/*oniframeload*/});
		var cmd = editor.addCommand('formtemplate', {exec:formtemplate_onclick});
        cmd.modes = {wysiwyg:1,source:1};
        cmd.canUndo = false;
        editor.ui.addButton( 'FormTemplate', {
        	label : 'FormTemplate',
        	command : 'formtemplate',
        	icon : imagePath + 'formtemplate.gif'
        });
        
		// If the "menu" plugin is loaded, register the menu items.
		if ( editor.addMenuItems )
		{
			editor.addMenuItems(
				{
					calendar :
					{
						label : 'Calendar Properties',
						command : 'calendar',
						group : 'calendar',
						icon : imagePath + 'calendar.gif'
					},
					finduser :
					{
						label : 'FindUser Properties',
						command : 'finduser',
						group : 'finduser',
						icon : imagePath + 'finduser.gif'
					},
					fileupload :
					{
						label : 'FileUpload Properties',
						command : 'fileupload',
						group : 'fileupload',
						icon : imagePath + 'fileupload.gif'
					},
					richtextarea :
					{
						label : 'RichTextArea Properties',
						command : 'richtextarea',
						group : 'richtextarea',
						icon : imagePath + 'richtextarea.gif'
					},
					databaseref :
					{
						label : 'DatabaseRef Properties',
						command : 'databaseref',
						group : 'databaseref',
						icon : imagePath + 'databaseref.gif'
					},
					addrow :
					{
						label : 'AddRow Properties',
						command : 'addrow',
						group : 'addrow',
						icon : imagePath + 'addrow.gif'
					}
				});
		}

		// If the "contextmenu" plugin is loaded, register the listeners.
		if ( editor.contextMenu )
		{
			editor.contextMenu.addListener( function( element )
				{
					if ( element && !element.isReadOnly() )
					{
						var name = element.getName();
						if ( name == 'img' ) {
							if ( element.getAttribute('_cke_real_element_type') == 'calendar' )
								return { calendar : CKEDITOR.TRISTATE_OFF };
								
							if ( element.getAttribute('_cke_real_element_type') == 'finduser' )
								return { finduser : CKEDITOR.TRISTATE_OFF };
								
							if ( element.getAttribute('_cke_real_element_type') == 'fileupload' )
								return { fileupload : CKEDITOR.TRISTATE_OFF };
							
							if ( element.getAttribute('_cke_real_element_type') == 'richtextarea' )
								return { richtextarea : CKEDITOR.TRISTATE_OFF };
							
							if ( element.getAttribute('_cke_real_element_type') == 'databaseref' )
								return { databaseref : CKEDITOR.TRISTATE_OFF };
								
							if ( element.getAttribute('_cke_real_element_type') == 'addrow' )
								return { addrow : CKEDITOR.TRISTATE_OFF };
						}
					}
				});
		}
		
		editor.on( 'doubleclick', function( evt )
			{
				var element = evt.data.element;

				if ( element.is( 'img' ) ) 
				{
					if ( element.getAttribute('_cke_real_element_type') == 'calendar' ) {
						evt.data.dialog = 'calendar';
					}
					
					if ( element.getAttribute('_cke_real_element_type') == 'finduser' ) {
						evt.data.dialog = 'finduser';
					}
					
					if ( element.getAttribute('_cke_real_element_type') == 'fileupload' ) {
						evt.data.dialog = 'fileupload';
					}
					
					if ( element.getAttribute('_cke_real_element_type') == 'richtextarea' ) {
						evt.data.dialog = 'richtextarea';
					}
					
					if ( element.getAttribute('_cke_real_element_type') == 'databaseref' ) {
						evt.data.dialog = 'databaseref';
					}
					
					if ( element.getAttribute('_cke_real_element_type') == 'addrow' ) {
						evt.data.dialog = 'addrow';
					}
				}
			});
	},
	afterInit : function( editor )
	{
		var dataProcessor = editor.dataProcessor,
			htmlFilter = dataProcessor && dataProcessor.htmlFilter,
			dataFilter = dataProcessor && dataProcessor.dataFilter;

		// Cleanup certain IE form elements default values.
		if ( CKEDITOR.env.ie )
		{
			htmlFilter && htmlFilter.addRules(
			{
				elements :
				{
					input : function( input )
					{
						var attrs = input.attributes,
							type = attrs.type;
						if ( type == 'checkbox' || type == 'radio' )
							attrs.value == 'on' && delete attrs.value;
					}
				}
			} );
		}

		if ( dataFilter )
		{
			dataFilter.addRules(
			{
				elements :
				{
					'input:calendartag' : function( element )
					{
						return editor.createFakeParserElement( element, 'uengine_calendar', 'calendar' );
					},
					'input:finduser' : function( element )
					{
						return editor.createFakeParserElement( element, 'uengine_finduser', 'finduser' );
					},
					'input:fileupload' : function( element )
					{
						return editor.createFakeParserElement( element, 'uengine_fileupload', 'fileupload' );
					},
					'input:richtextarea' : function( element )
					{
						return editor.createFakeParserElement( element, 'uengine_richtextarea', 'richtextarea' );
					},
					'input:databaseref' : function( element )
					{
						return editor.createFakeParserElement( element, 'uengine_databaseref', 'databaseref' );
					},
					'input:addrow' : function( element )
					{
						return editor.createFakeParserElement( element, 'uengine_addrow', 'addrow' );
					}
				}
			} );
		}
	},
	requires : [ 'image', 'fakeobjects', 'iframedialog' ]
} );

function formtemplate_onclick(e) {
	CKEDITOR.instances.CKeditor1.openDialog('formtemplate');
}
