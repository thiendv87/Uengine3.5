﻿/*
Created by yookjy 2010.12.30
*/
CKEDITOR.dialog.add( 'richtextarea', function( editor )
{
	return {
		title : 'RichTextArea Properties',
		richtextarea : null,
		minWidth : 350,
		minHeight : 110,
		path : this.path,
		onShow : function()
		{
			delete this.richtextarea;

			var editor = this.getParentEditor(),
				selection = editor.getSelection(),
				element = selection.getSelectedElement();

			if ( element && element.getAttribute( '_cke_real_element_type' ) && element.getAttribute( '_cke_real_element_type' ) == 'richtextarea' )
			{
				this.richtextarea = element;
				element = editor.restoreRealElement( this.richtextarea );
				this.setupContent( element );
				selection.selectElement( this.richtextarea );
			}
		},
		onOk : function()
		{
			var name = this.getValueOf( 'info', 'rt_name' ),
				width = this.getValueOf( 'info', 'rt_width' ),
				height = this.getValueOf( 'info', 'rt_height' ),
				editor = this.getParentEditor(),
				element = CKEDITOR.env.ie ? editor.document.createElement( '<input:richtextarea name="' + CKEDITOR.tools.htmlEncode( name ) + '">' ) : editor.document.createElement( 'input:richtextarea' );
				
//			editor.addCss(
//					'img.uengine_richtextarea' +
//					'{' +
//					'background-image: url(' + CKEDITOR.plugins.getPath( 'uengine' ) + 'images/richtextarea.gif' + ');' +
//					'background-position: center right;' +
//					'background-repeat: no-repeat;' +
//					'border: 1px solid #a9a9a9;' +
//					'width: ' + width + 'px !important;' +
//					'height: ' + height + 'px !important;' +
//			'}' );
			
			this.commitContent( element );
			var fakeElement = editor.createFakeElement( element, 'uengine_richtextarea', 'richtextarea' );
			if ( !this.richtextarea )
				editor.insertElement( fakeElement );
			else
			{
				fakeElement.replace( this.richtextarea );
				editor.getSelection().selectElement( fakeElement );
			}
			editor.setMode('wysiwyg');
			return true;
		},
		contents : [
			{
				id : 'info',
				label : 'RichTextArea',
				title : 'RichTextArea',
				elements : [
					{
						id : 'rt_name',
						type : 'text',
						label : 'RichTextArea Name',
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
						widths : [ '125px', '125px', '100px'],
						align : 'top',
						children :
						[
							{
								id : 'rt_width',
								type : 'text',
								label : 'Editor Width',
								'default' : '100%',
								accessKey : 'W',
								setup : function( element )
								{
									this.setValue(element.getAttribute( 'width' ) ||'' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
										element.setAttribute( 'width', this.getValue() );
									else
									{
										element.removeAttribute( 'width' ) ;
									}
								}
							},
							{
								id : 'rt_height',
								type : 'text',
								label : 'Editor Height',
								'default' : '300px',
								accessKey : 'H',
								setup : function( element )
								{
									this.setValue(element.getAttribute( 'height' ) ||'' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
										element.setAttribute( 'height', this.getValue() );
									else
									{
										element.removeAttribute( 'height' ) ;
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
