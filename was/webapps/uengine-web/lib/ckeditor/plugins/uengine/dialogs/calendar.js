﻿/*
Created by yookjy 2010.12.30
*/
CKEDITOR.dialog.add( 'calendar', function( editor )
{
	return {
		title : 'Calendar Properties',
		calendar : null,
		minWidth : 350,
		minHeight : 110,
		onShow : function()
		{
			delete this.calendar;

			var editor = this.getParentEditor(),
				selection = editor.getSelection(),
				element = selection.getSelectedElement();

			if ( element && element.getAttribute( '_cke_real_element_type' ) && element.getAttribute( '_cke_real_element_type' ) == 'calendar' )
			{
				this.calendar = element;
				element = editor.restoreRealElement( this.calendar );
				this.setupContent( element );
				selection.selectElement( this.calendar );
			}
		},
		onOk : function()
		{
			var name = this.getValueOf( 'info', 'cal_name' ),
				editor = this.getParentEditor(),
				element = CKEDITOR.env.ie ? editor.document.createElement( '<input:calendartag name="' + CKEDITOR.tools.htmlEncode( name ) + '">' ) : editor.document.createElement( 'input:calendartag' );
			
			this.commitContent( element );
			var fakeElement = editor.createFakeElement( element, 'uengine_calendar', 'calendar' );
			if ( !this.calendar )
				editor.insertElement( fakeElement );
			else
			{
				fakeElement.replace( this.calendar );
				editor.getSelection().selectElement( fakeElement );
			}
			return true;
		},
		contents : [
			{
				id : 'info',
				label : 'Calendar',
				title : 'Calendar',
				elements : [
					{
						id : 'cal_name',
						type : 'text',
						label : 'Calendar Name',
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
								id : 'cal_type',
								type : 'radio',
								label : 'Calendar Value Type',
								'default' : 'calendar',
								accessKey : 'T',
								items :
								[
								 	[ 'Calendar', 'calendar' ],
									[ 'String', 'string' ]
								],
								setup : function( element )
								{
									this.setValue( element.getAttribute( 'objecttype' ) || '' );
								},
								commit : function( element )
								{
									if ( this.getValue() )
									{
										element.setAttribute( 'objecttype', this.getValue() );
									}
									else 
									{
										element.removeAttribute( 'objecttype');
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
