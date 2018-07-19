﻿/*
Created by yookjy 2010.12.30
*/
CKEDITOR.dialog.add( 'finduser', function( editor )
{
	return {
		title : 'FindUser Properties',
		findUser : null,
		minWidth : 350,
		minHeight : 110,
		onShow : function()
		{
			delete this.findUser;

			var editor = this.getParentEditor(),
				selection = editor.getSelection(),
				element = selection.getSelectedElement();

			if ( element && element.getAttribute( '_cke_real_element_type' ) && element.getAttribute( '_cke_real_element_type' ) == 'finduser' )
			{
				this.findUser = element;
				element = editor.restoreRealElement( this.findUser );
				this.setupContent( element );
				selection.selectElement( this.findUser );
			}
		},
		onOk : function()
		{
			var name = this.getValueOf( 'info', 'fu_name' ),
				editor = this.getParentEditor(),
				element = CKEDITOR.env.ie ? editor.document.createElement( '<input:finduser name="' + CKEDITOR.tools.htmlEncode( name ) + '">' ) : editor.document.createElement( 'input:finduser' );
			
			this.commitContent( element );
			var fakeElement = editor.createFakeElement( element, 'uengine_finduser', 'finduser' );
			if ( !this.findUser)
				editor.insertElement( fakeElement );
			else
			{
				fakeElement.replace( this.findUser );
				editor.getSelection().selectElement( fakeElement );
			}
			return true;
		},
		contents : [
			{
				id : 'info',
				label : 'FindUser',
				title : 'FindUser',
				elements : [
					{
						id : 'fu_name',
						type : 'text',
						label : 'FindUser Name',
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
								id : 'multiple',
								type : 'checkbox',
								label : 'Use Multiple',
								'default' : '',
								accessKey : 'M',
								value : "checked",
								setup : function( element )
								{
									this.setValue( element.getAttribute( 'multiple' ) == 'true' ? 'checked' : '' );
								},
								commit : function( element )
								{
									element.setAttribute( 'multiple', this.getValue() != "" ? 'true' : 'false' );
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
