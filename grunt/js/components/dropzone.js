window.rideApp = window.rideApp || {};

rideApp.dropzone = (function($, undefined) {
  var $dropzone = $("#asset-dropzone");
  var maxFilesize = $dropzone.data('maxFilesize') || 16;
  var errorFilesize = $dropzone.data('errorFilesize') || "This file is too big.";
  var successUploadMsg = $dropzone.data('upload-success') || "File added.";
  var defaultMessage = $dropzone.data('placeholder') || "Upload";

  errorFilesize = errorFilesize.replace("%size%", "" + maxFilesize);

  Dropzone.options.assetDropzone = {
    maxFilesize: maxFilesize,
    parallelUploads : 1,
    dictDefaultMessage : defaultMessage,
    dictFileTooBig : errorFilesize,

    init: function() {
      $("#dropzone-upload").click(function() {
        location.reload();
      });
      this.on("sending", function(file, xhr, formData) {
        formData.append("resource", "file");
      });
    },

    success : function(file, html) {
      var thisSuccessUploadMsg = successUploadMsg.replace("%file%", "" + file.name);
      alertify.logPosition("bottom right");
      alertify.success(thisSuccessUploadMsg);

      var elem = $(html);
      $('.gridOverview').append(elem);
      this.removeFile(file);
    },
  };

})(jQuery);
