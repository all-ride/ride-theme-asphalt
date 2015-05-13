window.app = window.app || {};


app.dropper = (function($, undefined) {
  var $filequeue,
      $filelist,
      folderId=window.folderId;

  $(".dropper").dropper({
    action: "http://ronwec.local.statik.be/admin/assets/nl/items/add?folder=" +folderId+ "&referer=http%3A%2F%2Fronwec.local.statik.be%2Fadmin%2Fassets%2Fnl",
    maxSize: 1048576
  }).on("start.dropper", onStart)
    .on("complete.dropper", onComplete)
    .on("fileStart.dropper", onFileStart)
    .on("fileProgress.dropper", onFileProgress)
    .on("fileComplete.dropper", onFileComplete)
    .on("fileError.dropper", onFileError);


  function onStart(e, files) {
  }

  function onComplete(e) {
    location.reload();
    // All done!
  }

  function onFileStart(e, file) {
  }

  function onFileProgress(e, file, percent) {
  }

  function onFileComplete(e, file, response) {
  }

  function onFileError(e, file, error) {
  }

})(jQuery);
