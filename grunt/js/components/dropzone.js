window.app = window.app || {};

app.dropzone = (function($, undefined) {
  var maxFilesize = 2,
      errorFilesize = $("#asset-dropzone").data('errorFilesize') || "This file is too big.";
  errorFilesize = errorFilesize.replace("%size%", ""+maxFilesize);

  Dropzone.options.assetDropzone = {
    maxFilesize: maxFilesize,
    parallelUploads : 1,
    dictDefaultMessage : "Upload",
    dictFileTooBig : errorFilesize,

    init: function() {
      $("#dropzone-upload").click(function() {
        location.reload();
      });
    },

    success : function(file, html) {
        var elem = $(html);
        $('.gridOverview').append(elem);
        this.removeFile(file);
    },
  };

})(jQuery);
