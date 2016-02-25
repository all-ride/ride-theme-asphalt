window.rideApp = window.rideApp || {};

rideApp.common = (function($, undefined) {
  var $document = $(document),
      $window = $(window),
      $html = $('html'),
      $body = $('body');

  var _initialize = function() {
    // First set window size
    this.windowResize();
    $window.on('resize', debounce(rideApp.common.windowResize, 250, false));

    this.svgFallback();

    _animations();
  };

  var _animations = function() {
    $('.roll-in--pre').each(function() {
      var el = this;
      setTimeout(function() {
        el.classList.remove('roll-in--pre');
      }, 500);
    });
  };

  var _windowResize = function() {
    $.extend(rideApp.variables, {
      windowWidth: $window.width(),
      windowHeight: $window.height()
    });
  };

  var _svgFallback = function() {
    if (!Modernizr.svg) {
      var $html = $('html'),
          $imgs = $('img[src$=".svg"]');

      $imgs.each(function(k,v){
        var $img = $(v),
            fallback = $img.attr('data-url'),
            width = $img.attr('width'),
            height = $img.attr('height');

        $img.attr('src', fallback);
        // IE8 fix
        if ($html.hasClass('lt-ie9')) {
          $img.parent('a').css({ 'width' : width , 'height' : height });
        }
      });
    }
  };

  var _toggleSubmenu = function() {
    var $link = $('.toggle-menu'),
        $submenu = $('[class*=pane-menu-sidebar]'),
        $mainitems = $('span', $submenu);

    $link.on('click', function(e) {
      e.preventDefault();
      $submenu.toggle();
    });

    $mainitems.on('click', function(e) {
      e.preventDefault();
      $(this).next('ul').toggle();
    });
  };

  var _finalize = function() {
    var doneClass = 'js-done';

    $window.on('load', function(){
      $html.addClass(doneClass);
    });
    function delayedJS() {
      if(!$html.hasClass(doneClass)) {
        $html.addClass(doneClass);
      }
    }
    window.setTimeout(delayedJS, 4000);
  };

  /**
   * handle the XHR callbacks
   */
  var _handleXHRCallback = function(jqxhr, successMsg, errorMsg) {
    if (alertify !== undefined) {
      jqxhr.done(function() {
        alertify
          .logPosition("bottom right")
          .success(successMsg);
      });
      jqxhr.fail(function() {
        alertify
          .logPosition("bottom right")
          .error(errorMsg);
      });
    }
  };

  return {
    init: _initialize,
    windowResize: _windowResize,
    toggleSubmenu: _toggleSubmenu,
    svgFallback: _svgFallback,
    handleXHRCallback: _handleXHRCallback,
    finalize: _finalize
  };

})(jQuery);

// Helper functions for common.js
window.debounce = function(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
};
