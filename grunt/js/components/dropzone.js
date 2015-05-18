window.app = window.app || {};

app.dropzone = (function($, undefined) {

  Dropzone.options.assetDropzone = {
    init: function() {
      self = this;

      $("#dropzone-upload").click(function() {
        location.reload();
      });
    },
    dictDefaultMessage : "Upload"
  };

})(jQuery);
