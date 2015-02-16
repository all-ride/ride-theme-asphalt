var rideApp = rideApp || {};

rideApp.assets = (function($, undefined) {
  var $document = $(document),
      $window = $(window),
      $html = $('html'),
      $body = $('body');

  var _initialize = function() {
    parent.rideApp.form.assets.resizeIframe(parent, $document.height());
    $document.on('click', '.preview.is-addable', function(e) {
      e.preventDefault();
      var $photo = $(this).parent(),
          id = $photo.data('id'),
          name = $.trim($photo.find('.name').text()),
          thumb = $photo.find('.image').attr('src');

      parent.rideApp.form.assets.addAsset(id, name, thumb);
    });
  };

  return {
    initialize: _initialize
  };

})(jQuery);

// Run the initializer
rideApp.assets.initialize();
