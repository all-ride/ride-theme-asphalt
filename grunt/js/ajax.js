var $document = $(document),
    $overlay = $('.ajax-overlay');

$(document).ajaxStart(function() {
  $overlay.show();
});

$(document).ajaxStop(function() {
    $overlay.hide();
});
