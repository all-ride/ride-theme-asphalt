var rideApp = rideApp || {};

rideApp.mailTemplates = (function($, undefined) {
  var $document = $(document);

  var _initialize = function() {
    $(".js-content-variable-drag").draggable({helper: 'clone'}).css('cursor', 'move');
    $(".js-content-variable-drop,.redactor-in").droppable({
      accept: ".js-content-variable-drag",
      drop: function(ev, ui) {
        $(this).insertAtCaret(ui.draggable.data('variable'));
      }
    });

    $(".js-recipient-variable-drag").draggable({helper: 'clone'}).css('cursor', 'move');
    $(".js-recipient-variable-drop").droppable({
      accept: ".js-recipient-variable-drag",
      drop: function(ev, ui) {
        $(this).insertAtCaret(ui.draggable.data('variable'));
      }
    });
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
$(document).ready(function() {
  rideApp.mailTemplates.initialize();
});

$.fn.insertAtCaret = function (string) {
  return this.each(function() {
    var $e = $(this);

    if ($e.hasClass('redactor-in')) {
      $e = $e.next('textarea');
      $e.redactor('insert.text', string);
    } else {
      var range1 = this.selectionStart;
      var range2 = this.selectionEnd;
      var value = this.value;
      var prefix = value.substring(0, range1);
      var suffix = value.substring(range1, value.length);
      this.value = prefix + string + suffix;
    }
  });
};
