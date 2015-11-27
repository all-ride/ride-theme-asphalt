window.app = window.app || {};

app.content = (function($, undefined) {

  var _initialize = function() {
    var $richContent = $('.js-rich-content');

    $richContent.each(function() {
        var $element = $(this);
        var options = $element.data('rich-content-properties');
        var redactorOptions = $element.data('redactor-properties');

        options = $.extend(options, {
          "blockTypes": ["Wysiwyg"],
          "el": $element
        });

        app.content.initWysiwyg(redactorOptions);
        new SirTrevor.Editor(options);
    })
  };

  var _initWysiwyg = function(options) {
    var options = htmlEscape(JSON.stringify(options));
    var textAreaTemplate = '<textarea class="wysiwyg form__text" data-redactor-properties="' + options + '"></textarea>';

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
        loadData: function(data){
          var $editor = $(this.$editor);
          $editor.html(data.body);
        },
        onBlockRender: function(data){
          var textarea = this.$editor;
          $(textarea).initRedactor();
        }
      });
    })();
  };

  function htmlEscape(str) {
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');
  }

  return {
    init: _initialize,
    initWysiwyg: _initWysiwyg
  }

})(jQuery);
