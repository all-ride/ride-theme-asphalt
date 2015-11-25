window.app = window.app || {};

app.content = (function($, undefined) {

  var _initialize = function() {

    new SirTrevor.Editor({ el: $('.js-rich-content') });
    
  };

  return {
    init: _initialize
  }

})(jQuery);