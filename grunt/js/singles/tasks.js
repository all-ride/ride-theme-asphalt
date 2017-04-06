var rideApp = rideApp || {};

rideApp.tasks = (function($, undefined) {
  var $element;

  function initialize() {
    $element = $('.task-progress');

    var statusUrl = $element.data('url-status');
    var finishUrl = $element.data('url-finish');
    var sleepTime = $element.data('sleep');

    updateQueueStatus(statusUrl, finishUrl, sleepTime);
  }

  function updateQueueStatus(statusUrl, finishUrl, sleepTime) {
    // disable ajax overlay spinner
    window.overlaySelector = undefined;

    $.get(statusUrl, function(body) {
      if (body.data.attributes.status == 'error') {
        window.location = finishUrl;
      } else {
        setTimeout(function() { updateQueueStatus(statusUrl, finishUrl, sleepTime)}, sleepTime * 1000);
      }
    }).fail(function(data) {
      if (data.status == 404) {
        $element.html($element.data('finish'));
        $('.spinner').remove();

        window.location = finishUrl;
      }
    });
  }

  return {
    initialize: initialize
  };
})(jQuery);

// Run the initializer
$(function() {
  rideApp.tasks.initialize();
});
