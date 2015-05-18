window.app = window.app || {};


app.dropper = (function($, undefined) {
  var $filequeue,
      $filelist,
      folderId=window.folderId;

  $(".dropper").dropper({
    action: "http://ronwec.local.statik.be/admin/assets/nl/items/add?folder=" +folderId+ "&referer=http%3A%2F%2Fronwec.local.statik.be%2Fadmin%2Fassets%2Fnl",
    maxSize: 20971520
  })
    .on("fileComplete.dropper", onFileComplete)
    // .on("start.dropper", onStart)
    // .on("complete.dropper", onComplete)
    // .on("fileStart.dropper", onFileStart)
    // .on("fileProgress.dropper", onFileProgress)
    // .on("fileError.dropper", onFileError);

  function onFileComplete(e, file, response) {
    location.reload();
  }
})(jQuery);
