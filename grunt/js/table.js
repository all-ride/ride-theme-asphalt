var rideApp = rideApp || {};

rideApp.table = (function($, undefined) {
  var _initialize = function() {
    var $element = $('form.table'),
        $form = $element.parents('form.table');

    $element.on('change', '.check-all', function() {
      checkAll($(this));
    });

    $element.on('change', 'select', function() {
      triggerAction($(this));
    });
  };

  /**
   * Check or uncheck all the row checkboxes based on the master checkbox state.
   * @param  {jQuery Object} $elem    The master checkbox
   */
  var checkAll = function($elem) {
    var $form = $elem.parents('form.table');

    $form.find(':checkbox').prop('checked', $elem.prop('checked'));
  };

  /**
   * Trigger a custom action for all the checked items in the tabel
   * @param  {jQuery Object} $elem    The selectbox
   */
  var triggerAction = function($elem) {
    var submit = true;

    if($elem.attr('name') == 'action') {
      var $form = $elem.parents('form.table'),
          messages = $form.data('confirm-messages'),
          action = $elem.val();

      if (messages[action]) {
        submit = confirm(messages[action]);
      }

      if (submit) {
        $elem.attr('readonly', true);
        $form.submit();
      } else {
        $elem.val('');
      }
    }
  };


  return {
    initialize: _initialize
  };
})(jQuery);


// Run the initializer
rideApp.table.initialize();
