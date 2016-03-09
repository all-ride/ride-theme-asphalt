window.rideApp = window.rideApp || {};
rideApp.variables = rideApp.variables || {};

rideApp.main = (function($, undefined) {

  var _fire = function(func, funcname, args){
    funcname = (funcname === undefined) ? 'init' : funcname;

    if (func !== '' && rideApp[func] && typeof rideApp[func][funcname] == 'function') {
      rideApp[func][funcname](args);
    }
  };

  var _initialize = function() {
    var dataComponents = $('body').data('components');

    // hit up common first.
    this.fire('common');
    this.fire('dropzone');
    this.fire('form');

    // Hit up the page component
    if(dataComponents) {
      var components = dataComponents.split(' ');
      for(var comp in components) {
        this.fire(components[comp]);
      }
    }

    // Fire the finalize function for common
    this.fire('common','finalize');
  };

  return {
    init: _initialize,
    fire : _fire
  };
})(jQuery);


$(document).ready(function() {
  rideApp.main.init();
});

//! DONT ADD ANYTHING IN THIS FILE, USE COMMON.JS PLEASE.
