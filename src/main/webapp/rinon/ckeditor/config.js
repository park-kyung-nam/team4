/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
  config.extraPlugins = 'wordcount';
  config.wordcount = {

      // Whether or not you want to show the Word Count
      showWordCount: true,

      // Whether or not you want to show the Char Count
      showCharCount: true,
      
      // Maximum allowed Word Count
      //maxWordCount: 4,

      // Maximum allowed Char Count
      //maxCharCount: 10
  };
};
