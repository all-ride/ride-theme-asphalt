window.app = window.app || {};

app.content = (function($, undefined) {

  var _initialize = function() {
    var $richContent = $('.js-rich-content');

    $richContent.each(function() {
        var $element = $(this);
        var options = $element.data('rich-content-properties');
        var redactorOptions = $element.data('redactor-properties');

        options = $.extend(options, {
          "blockTypes": ["Wysiwyg", "Text"],
          "el": $element
        });

        app.content.initWysiwyg(redactorOptions);
        new SirTrevor.Editor(options);
    })
  };

  var _initWysiwyg = function(options) {
    var options = htmlEscape(JSON.stringify(options));
    var textAreaTemplate = '<textarea class="st-text-block wysiwyg form__text" data-redactor-properties="' + options + '"></textarea>';
    // st-text-block class needed for save

    // Set options for new blocks
    SirTrevor.setBlockOptions("Wysiwyg", {
      editorHTML: function() {
        return textAreaTemplate;
      }
    });

    // Set options for existing blocks
    SirTrevor.Blocks.Wysiwyg = (function(){
      return SirTrevor.Block.extend({
        type: "Wysiwyg",
        title: function() { return 'Wysiwyg'; },
        editorHTML: textAreaTemplate,
        icon_name: 'text',
        // setTextBlockHTML: function(a) {
        //   return '<p>Test</p>';
        // },
        loadData: function(data){
          var $editor = $(this.$editor);
          $editor.html(data.text);

          // console.log(data.text);
        },
        // beforeBlockRender: function(data){
        // },
        // save: function(data){
        //   // console.log(data);
        //   // console.log(this);

        //   var data = this.$editor.val();
        //   console.log(data);

        //   // if (!_.isEmpty(data)) {
        //   //   this.setData(data);
        //   // }
        //   // var data = this._serializeData();
        //   // data = htmlEscape(data);
        //   // TODO: set content as HTML content of textarea in the DOM
        // },
        // validateAndSaveBlock: function(block, shouldValidate) {
        //   console.log(block);
        // },
        onBlockRender: function(data){
          var textarea = this.$editor;
          $(textarea).initRedactor();
        }
      });
    })();
  };

  function htmlEscape(str) {
    // http://stackoverflow.com/questions/1219860/html-encoding-in-javascript-jquery
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');
  }

  // function htmlUnescape(value){
  //   return String(value)
  //       .replace(/&quot;/g, '"')
  //       .replace(/&#39;/g, "'")
  //       .replace(/&lt;/g, '<')
  //       .replace(/&gt;/g, '>')
  //       .replace(/&amp;/g, '&');
  // }

  return {
    init: _initialize,
    initWysiwyg: _initWysiwyg
  }

})(jQuery);
