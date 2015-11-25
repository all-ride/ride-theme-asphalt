window.app = window.app || {};

app.content = (function($, undefined) {

  var _initialize = function() {
    var $content = $('.js-rich-content');

    $content.each(function() {
        var $element = $(this);
        var options = $element.data('rich-content-properties');

        $.extend(options, { el: $element });
        new SirTrevor.Editor(options);
    })
  };

  return {
    init: _initialize
  }

})(jQuery);
