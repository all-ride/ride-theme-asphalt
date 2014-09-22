$.fn.formCollection = function() {
    $(this).on('click', '.prototype-add:not(.disabled)', function() {
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

        return false;
    });

    $(this).on('click', '.prototype-remove:not(.disabled)', function() {
        if (confirm('Are you sure you want to remove this item?')) {
            $(this).parents('.collection-control').remove();
        }

        return false;
    });
};

$.fn.formFile = function() {
    $(this).on('click', '.btn-file-delete', function() {
        var anchor = $(this);
        if (confirm(anchor.data('message'))) {
            anchor.parents('.form-group').find('input[type=hidden]').val('');
            anchor.parent('div').remove();
        }

        return false;
    });
};

$(function() {
    $('form[role=form]').formCollection();
    $('form[role=form]').formFile();
});

$.fn.table = function() {
  $(this).on('change', '.check-all', function() {
    var form = $(this).parents('form.table');

    var checked = this.checked;
    $(':checkbox', form).each(function(i) {
      this.checked = checked;
    });
  });

  $(this).on('change', 'select', function() {
    var submit = true;

    if ($(this).attr('name') == 'action') {
      var form = $(this).parents('form.table');
      var messages = form.data('confirm-messages');
      var action = this.options[this.selectedIndex].text;

      if (messages[action]) {
        submit = confirm(messages[action]);
      } else {
      }
    }

    if (submit) {
      $(this).attr('readonly', true).parents('form').submit();
    } else {
      $(this).val('');
    }
  });

  $('td.action a').addClass('btn btn-default');
};

$(function() {
    $('form.table').table();
});
