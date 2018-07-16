/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';

	config.toolbar = 'Full';
	config.toolbar_Full =
	[
	    ['Source','-','Save','NewPage','Preview','-','Templates'],
	    ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
	    ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
	    ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
	    ['Calendar', 'FindUser', 'FileUpload', 'RichTextArea', 'FormTemplate', 'DatabaseRef', 'AddRow'],
	    '/',
	    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
	    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	    ['BidiLtr', 'BidiRtl' ],
	    ['Link','Unlink','Anchor'],
	    ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe'],
	    '/',
	    ['Styles','Format','Font','FontSize'],
	    ['TextColor','BGColor'],
	    ['Maximize', 'ShowBlocks','-','About']
	];
	config.toolbar_General =
	[
		 ['Source','-','NewPage','Preview','-','Templates'],
		 ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
		 ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
		 '/',
		 ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
		 ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
		 ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
		 ['BidiLtr', 'BidiRtl' ],
		 ['Link','Unlink','Anchor'],
		 '/',
		 ['Styles','Format','Font','FontSize'],
		 ['TextColor','BGColor'],
		 ['Maximize', 'ShowBlocks']
	];
	config.toolbar_Basic =
	['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink','-','About'];
	
	config.extraPlugins = 'uengine';
	config.menu_groups = config.menu_groups + ',calendar,finduser,fileupload,richtextarea,databaseref,addrow';
	config.contentsCss = ['../lib/ckeditor/contents.css', 
	                      '../lib/jquery/css/cupertino/jquery-ui-1.8.7.custom.css', 
	                      '../style/formdefault.css',
	                      '../style/default.css',
	                      '../style/uengine.css'];
	
	//editor font size => skins/kama/editor.css -> find keyword : 'small' -> replace 'small' -> '12px'
};
