﻿/*
Created by yookjy 2010.12.30
*/
CKEDITOR.dialog.add( 'fileupload', function( editor )
{
	return {
		title : 'FileUpload Properties',
		fileupload : null,
		minWidth : 350,
		minHeight : 110,
		onShow : function()
		{
			delete this.fileupload;

			var editor = this.getParentEditor(),
				selection = editor.getSelection(),
				element = selection.getSelectedElement();

			if ( element && element.getAttribute( '_cke_real_element_type' ) && element.getAttribute( '_cke_real_element_type' ) == 'fileupload' )
			{
				this.fileupload = element;
				element = editor.restoreRealElement( this.fileupload );
				this.setupContent( element );
				selection.selectElement( this.fileupload );
			}
		},
		onOk : function()
		{
			var name = this.getValueOf( 'info', 'fo_name' ),
				editor = this.getParentEditor(),
				element = CKEDITOR.env.ie ? editor.document.createElement( '<input:fileupload name="' + CKEDITOR.tools.htmlEncode( name ) + '">' ) : editor.document.createElement( 'input:fileupload' );
			
			this.commitContent( element );
			var fakeElement = editor.createFakeElement( element, 'uengine_fileupload', 'fileupload' );
			if ( !this.fileupload )
				editor.insertElement( fakeElement );
			else
			{
				fakeElement.replace( this.fileupload );
				editor.getSelection().selectElement( fakeElement );
			}
			return true;
		},
		contents : [
			{
				id : 'info',
				label : 'FileUpload',
				title : 'FileUpload',
				elements : [
					{
						id : 'fo_name',
						type : 'text',
						label : 'FileUpload Name',
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
						widths : [ '175px', '175px'],
						align : 'top',
						children :
						[
							{
								id : 'file_class',
								type : 'radio',
								label : 'File Type',
								'default' : 'general',
								accessKey : 'T',
								items :
								[
								 	[ 'General', 'general' ],
									[ 'Image', 'image' ]
								],
								setup : function( element )
								{
									this.setValue( element.getAttribute( 'fileclass' ) || '' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
									{
										element.setAttribute( 'fileclass', this.getValue() );
									}
									else 
									{
										element.removeAttribute( 'fileclass');
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
			}
		]
	};
});
