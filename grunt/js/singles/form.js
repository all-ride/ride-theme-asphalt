var rideApp = rideApp || {};

rideApp.form = (function($, undefined) {
  var _initialize = function() {
    formFile();
    formCollection();
    sortables();

    _selectize();
    _assets();

    $('[data-toggle-dependant]').on('change', function() {
        toggleDependantRows($(this));
    }).each(function() {
        toggleDependantRows($(this));
    });
  };

  var formFile = function() {
    $(document).on('click', '.btn-file-delete', function(e) {
      e.preventDefault();
      var $anchor = $(this);
      if (confirm($anchor.data('message'))) {
        $anchor.parents('.form__item').find('input[type=hidden]').val('');
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

  var _selectize = function() {
    var $form = $('.form--selectize');
    $('.form--selectize select:visible').selectize();
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        $('.form--selectize select:visible').selectize();
    });
  };

  var _assets = function() {
    var $assets = $('.form__assets');

    $assets.each(function() {
      var $this = $(this),
          $field = $this.next('.form__assets-input'),
          $edit = $this.find('.form__edit-assets'),
          editText = $edit.text(),
          $add = $this.find('.form__add-assets'),
          isRemovable = false;

      $this.sortable({
          items: '.form__asset'
        })
        .on('sortstop', function(event, ui) {
          setOrder($this);
        }).disableSelection();

      function setOrder($item) {
        var order = $item.sortable('toArray', {attribute: 'data-id'});
        $field[0].value = order.join(',');
      }

      $add.on('click', function(e) {
        e.preventDefault();
        if(isRemovable) return;
        var asset = prompt("Enter an asset ID");
        if (asset !== null) {
          var assets = asset.split(','),
              i = 0;
          while(assets[i]) {
            if(!isNaN(assets[i])) {
              $('<div class="form__asset" data-id="' + assets[i] + '"><img src="http://lorempixel.com/100/100/"></div>').insertBefore($add);
            }
            i++;
          }
          setOrder($this);
        }
      });

      $edit.on('click', function(e) {
        e.preventDefault();
        if(isRemovable) {
          $edit.text(editText);
          $this.sortable('enable');
          $this.removeClass('is-removable');
          $add.attr('disabled', false);
          isRemovable = false;
        } else {
          $edit.text($edit.data('alt'));
          $this.sortable('disable');
          $this.addClass('is-removable');
          $add.attr('disabled', true);
          isRemovable = true;
        }
      });

      $($this).on('click', '.form__asset', function(e) {
        e.preventDefault();
        if(!isRemovable) return;
        var $elem = $(this);
        $elem
          .addClass('is-removed')
          .on('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function() {
            $elem.remove();
            setOrder($this);
          });
      });
    });


  };

  var toggleDependantRows = function($input) {
    var $parent = $input.parents('form'),
        $styleClass = $input.data('toggle-dependant'),
        $group = $parent.find('[name^=' + $input.attr('name') + ']'),
        $checked = $group.filter(':checked'),
        value = $checked.length ? $checked.val() : null;

    $('.' + $styleClass, $parent).parents('.form__item').hide();
    $('.' + $styleClass + '-' + value, $parent).parents('.form__item').show();
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
rideApp.form.initialize();



$.fn.formDependantRows = function() {
    var toggleDependantRows = function($input) {
        var $parent = $input.parents('form');
        var $styleClass = $input.data('toggle-dependant');
        var value = $input.filter(':checked').length ? $input.val() : null;

        $('.' + $styleClass, $parent).parents('.form-group').hide();
        $('.' + $styleClass + '-' + value, $parent).parents('.form-group').show();
    };

    $('[data-toggle-dependant]', $(this)).on('change', function() {
        toggleDependantRows($(this));
    }).each(function() {
        toggleDependantRows($(this));
    });
};

