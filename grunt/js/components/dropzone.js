window.app = window.app || {};

app.dropzone = (function($, undefined) {

  Dropzone.options.assetDropzone = {
    init: function() {
      self = this;

      $("#dropzone-upload").click(function() {
        location.reload();
      });
    },
    dictDefaultMessage : "Upload",

    success : function(file, html) {
        var elem = $(html);
        $('.gridOverview').append(elem);
        this.removeFile(file);
    }
  };

})(jQuery);
