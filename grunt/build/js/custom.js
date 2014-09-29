var rideApp = rideApp || {};

rideApp.form = (function($, undefined) {
  var _initialize = function() {
    formFile();
    formCollection();
    sortables();
  };

  var formFile = function() {
    $(document).on('click', '.btn-file-delete', function(e) {
      e.preventDefault();
      var $anchor = $(this);
      if (confirm($anchor.data('message'))) {
        $anchor.parents('.form-group').find('input[type=hidden]').val('');
        $anchor.parent('div').remove();
      }
    });
  };

  var formCollection = function() {
    $(document).on('click', '.prototype-add:not(.disabled)', function(e) {
      e.preventDefault();
      var parent = $(this).parent('.collection-controls');
      var prototype = parent.attr('data-prototype');
      var index = parent.attr('data-index');
      if (!index) {
        index = $('.collection-control', parent).length;
      }

      prototype = prototype.replace(/%prototype%/g, 'prototype-' + index);

      // add prototype to the container
      $('.collection-control-group', parent).first().append(prototype);

      // increase the index for the next addition
      index++;

      parent.attr('data-index', index);
    });

    $(document).on('click', '.prototype-remove:not(.disabled)', function(e) {
      e.preventDefault();
      if (confirm('Are you sure you want to remove this item?')) {
        $(this).parents('.collection-control').remove();
      }
    });
  };

  var sortables = function() {
    $('[data-order=true] .collection-control-group').sortable({
        axis: "y",
        cursor: "move",
        handle: ".order-handle",
        items: "> .collection-control",
        select: false,
        scroll: true
    });
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
rideApp.form.initialize();

$.fn.honeyPot = function(options) {
    var $this = $(this);

    $(options.fields).each(function(index, value) {
        var $input = $('input[name=' + value + ']', $this);
        if ($input.length === 0) {
            return;
        }

        var defaultValue = $input.data('value');
        if (defaultValue) {
            // $input.val(defaultValue);
        }

        $input.parents('.form-group').hide();
    });

    $this.on('submit', function() {
        var submitValue = '';

        $(options.fields).each(function(index, value) {
            var $input = $('input[name=' + value + ']', $this);

            submitValue += (submitValue === '' ? '' : ',') + $input.val();
        });

        $('input[name=honeypot-submit]', $this).val(submitValue);
    });
};

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
