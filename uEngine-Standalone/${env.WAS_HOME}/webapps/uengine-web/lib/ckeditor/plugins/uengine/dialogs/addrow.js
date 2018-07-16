﻿/*
Created by yookjy 2010.12.30
*/
CKEDITOR.dialog.add( 'addrow', function( editor )
{
	return {
		title : 'AddRow Properties',
		addrow : null,
		minWidth : 350,
		minHeight : 110,
		onShow : function()
		{
			delete this.addrow;

			var editor = this.getParentEditor(),
				selection = editor.getSelection(),
				element = selection.getSelectedElement();

			if ( element && element.getAttribute( '_cke_real_element_type' ) && element.getAttribute( '_cke_real_element_type' ) == 'addrow' )
			{
				this.addrow = element;
				element = editor.restoreRealElement( this.addrow );
				this.setupContent( element );
				selection.selectElement( this.addrow );
			}
		},
		onOk : function()
		{
			var name = this.getValueOf( 'info', 'add_btn_name' ),
				editor = this.getParentEditor(),
				element = CKEDITOR.env.ie ? editor.document.createElement( '<input:addrow name="' + CKEDITOR.tools.htmlEncode( name ) + '">' ) : editor.document.createElement( 'input:addrow' );
			
			this.commitContent( element );
			var fakeElement = editor.createFakeElement( element, 'uengine_addrow', 'addrow' );
			if ( !this.addrow )
				editor.insertElement( fakeElement );
			else
			{
				fakeElement.replace( this.addrow );
				editor.getSelection().selectElement( fakeElement );
			}
			return true;
		},
		contents : [
			{
				id : 'info',
				label : 'AddRow',
				title : 'AddRow',
				elements : [
					{
						type : 'hbox',
						widths : [ '175px', '175px'],
						align : 'top',
						children :
						[
							{
								id : 'add_btn_name',
								type : 'text',
								label : 'Add Button Name',
								'default' : 'btnAdd',
								accessKey : 'AN',
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
								id : 'add_btn_value',
								type : 'text',
								label : 'Add Button Text',
								'default' : 'Add',
								accessKey : 'AT',
								setup : function( element )
								{
									this.setValue(element.getAttribute( 'value' ) ||'' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
										element.setAttribute( 'value', this.getValue() );
									else
									{
										element.removeAttribute( 'value' ) ;
									}
								}
							}
						]
					},
					{
						type : 'hbox',
						widths : [ '175px', '175px'],
						align : 'top',
						children :
						[
							{
								id : 'del_btn_name',
								type : 'text',
								label : 'Remove Button Name',
								'default' : 'btnRemove',
								accessKey : 'RN',
								setup : function( element )
								{
									this.setValue(element.getAttribute( 'removename' ) ||'' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
										element.setAttribute( 'removename', this.getValue() );
									else
									{
										element.removeAttribute( 'removename' ) ;
									}
								}
							},
							{
								id : 'del_btn_value',
								type : 'text',
								label : 'Remove Button Text',
								'default' : 'Remove',
								accessKey : 'RT',
								setup : function( element )
								{
									this.setValue(element.getAttribute( 'removevalue' ) ||'' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
										element.setAttribute( 'removevalue', this.getValue() );
									else
									{
										element.removeAttribute( 'removevalue' ) ;
									}
								}
							}
						]
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
