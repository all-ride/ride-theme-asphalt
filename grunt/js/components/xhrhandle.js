window.rideApp = window.rideApp || {};

rideApp.xhrhandle = (function($, undefined) {
  alertify.logPosition("bottom right");

  var request = function(url, method, data, onsuccess, onerror) {
    // shift arguments if data argument was omitted
    if (jQuery.isFunction(data)) {
      onerror = onerror || onsuccess;
      onsuccess = data;
      data = undefined;
    }

    var jqxhr = $.ajax(url, {
      'method': method,
      'data': data
    });

    jqxhr.done(function(data) {
      alertify
        .logPosition("bottom right")
        .success('success');

      if (onsuccess) {
        onsuccess();
      }
    });

    jqxhr.fail(function(data) {
      alertify
        .logPosition("bottom right")
        .error('error');

      if (onerror) {
        onerror();
      }
    });
  };

  return {
    request: request
  };
})(jQuery);
