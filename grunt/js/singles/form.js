var rideApp = rideApp || {};

function updateQueryStringParameter(uri, key, value) {
  var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
  var separator = uri.indexOf('?') !== -1 ? "&" : "?";
  if (uri.match(re)) {
    return uri.replace(re, '$1' + key + "=" + value + '$2');
  }
  else {
    return uri + separator + key + "=" + value;
  }
}

rideApp.form = (function($, undefined) {
  var $document = $(document);

  var _initialize = function() {
    formFile();
    formCollection();

    if (jQuery.fn.sortable) {
      sortables();
    }

    _selectize();
    _autocomplete();
    this.assets.init();

    $('[maxlength]').each(function() {
      rideApp.form.checkLength.init($(this), false);
    });

    $('[data-recommended-maxlength]').each(function() {
      rideApp.form.checkLength.init($(this), true);
    });

    $('[data-toggle-dependant]').on('change', function() {
        toggleDependantRows($(this));
    }).each(function() {
        toggleDependantRows($(this));
    });

    rideApp.translator.submitTranslationKeys();
  };

  var formFile = function() {
    $document.on('click', '.btn-file-delete', function(e) {
      e.preventDefault();
      var $anchor = $(this);
      if (confirm($anchor.data('message'))) {
        $anchor.closest('.form__item').find('input[type=hidden]').val('');
        $anchor.parent('div').remove();
      }
    });
  };

  var formCollection = function() {
    $document.on('click', '.prototype-add:not(.disabled)', function(e) {
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

      parent.trigger('collectionAdded');
    });

    $document.on('click', '.prototype-remove:not(.disabled)', function(e) {
      e.preventDefault();
      if (confirm('Are you sure you want to remove this item?')) {
        var parent = $(this).closest('.collection-control');
        parent.trigger('collectionRemoved');
        parent.remove();
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

  var _checkLength = {
    init: function($field,recommended) {
      if(!$field.length) return false;
      if(recommended) {
        var maxChars = $field.attr('data-recommended-maxlength');
      } else {
        var maxChars = $field.attr('maxlength');
      }
      if (!maxChars) {
        return false;
      }
      var $countDown = $('<div class="form__countdown" />').insertAfter($field);
      rideApp.form.checkLength.updateCount($field, $countDown, maxChars, recommended);

      $field.on('keyup', function() {
        rideApp.form.checkLength.updateCount($field, $countDown, maxChars, recommended);
      });
    },
    updateCount: function($field, $label, max, recommended) {
      var length = $field.val().length,
          maxChars = parseInt(max, 10);
      if(recommended){
        var count = (maxChars - length);
        $label.text(rideApp.translator.translate('label.length.recommended') + ': ' + count + '/' + max);
        if (count < 0) {
          $label.addClass('text--warning');
        } else {
          $label.removeClass('text--warning');
        }
      } else {
        var count = (maxChars - length) >= 0 ? (maxChars - length) : 0;
        $label.text(count + '/' + max);
      }

      if(count <= 0 && !recommended) return false;
    }
  };

  var _selectize = function() {
    if (jQuery.fn.selectize) {
      var $form = $('.form--selectize'),
          selectizeOption = {
            plugins: ['drag_drop', 'remove_button']
          };
      $('.form--selectize select:visible:not(.selectized)').selectize(selectizeOption).addClass('selectized');
      $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
          $('.form--selectize select:visible').selectize(selectizeOption);
      });
      $document.on('collectionAdded', function() {
        $('.form--selectize select:visible:not(.selectized)').selectize(selectizeOption).addClass('selectized');
      });
    }
  };

  var _autocomplete = function() {
    if (jQuery.fn.selectize) {
      var $fields = $('[data-autocomplete-url]');
      $fields.each(function() {
        makeFieldAutocomplete($(this));
      });

      function makeFieldAutocomplete($field) {
        var url = $field.data('autocomplete-url');
        var multiple = $field.data('autocomplete-multiple');
        var type = $field.data('autocomplete-type');
        var plugins = [];
        if (multiple) {
            plugins.push('drag_drop', 'remove_button');
        }
        var autocompleteSettings = {
          valueField: 'name',
          labelField: 'name',
          searchField: 'name',
          maxItems: multiple ? null : 1,
          plugins: plugins,
          create: $field.hasClass('js-tags') ? true : false,
          load: function(query, callback) {
              if (!query.length) return callback();
              var fetchUrl = url;
              fetchUrl = fetchUrl.replace(/%25term%25/g, query);
              fetchUrl = fetchUrl.replace(/%term%/g, query);
              $.get(
                  fetchUrl,
                  function(data) {
                    if (type === 'jsonapi') {
                      res = data.meta.list;
                    } else {
                      res = data;
                    }
                    var map = $.map(res, function(value) {
                      return {name: value};
                    })
                    callback(map);
                  }
              );
          }
        }
        $field.selectize(autocompleteSettings);
      }
    }
  };

  var _assets = {
    allAssets: function(){
      return $document.find('.form__assets');
    },
    modalTriggers: function(){
      return $document.find('.form__add-assets');
    },
    removeTriggers: function(){
      return $document.find('.form__remove-asset');
    },
    iframes: [],
    init: function() {
      var $assets = rideApp.form.assets.allAssets(),
          $modalTriggers = rideApp.form.assets.modalTriggers(),
          $removeTriggers = rideApp.form.assets.removeTriggers();

      $assets.each(function() {
        // Escape ID's (needed for underscore templates)
        function escapeID(myid) {
          return "#" + myid.replace( /(:|\.|\[|\]|\%|\<|\>|,)/g, "\\$1" );
        }

        var $this = $(this),
            fieldId = $this.data('field'),
            $field = $(escapeID(fieldId)),
            $edit = $this.find('.form__edit-assets'),
            editText = $edit.text(),
            $add = $this.find('.form__add-assets'),
            isRemovable = false;

        rideApp.form.assets.checkAssetsLimit();

        $this.sortable({
            items: '.form__asset'
          })
          .on('sortstop', function(event, ui) {
            rideApp.form.assets.setAssetsOrder($this);
          }).disableSelection();
      });

      $modalTriggers.on('click', function(e) {
        e.preventDefault();
        var attr = $(this).attr('disabled');
        if (attr === 'disabled') {
          return;
        }
        var assetsModal = $(this).attr('href'),
            $modal = $(assetsModal),
            $iframe = $modal.find('iframe');

        // check if there is an other iframe with this source on the page
        if($iframe.attr('src') === undefined) {
          $iframe.attr('src', $iframe.data('src'));
        }
        $modal.modal('show');
      });

      $removeTriggers.on('click', function(e) {
        e.preventDefault();
        rideApp.form.assets.removeAsset(this);
      });
    },
    setAssetsOrder: function($item) {
        var order = $item.sortable('toArray', {attribute: 'data-id'}),
            field = $item.data('field'),
            $field = $('#' + field);
        $field[0].value = order.join(',');

        // find grouped assets and reorder them...
        var $assets = rideApp.form.assets.allAssets();
        var $linked = $assets.filter('[data-field="' + field + '"] ').not($item);
        $linked.find('.form__asset').detach();
        $linked.prepend($item.find('.form__asset').clone());
    },
    checkAssetsLimit: function() {
      // var $assets = $('.form__assets');
      var $assets = rideApp.form.assets.allAssets();

      $assets.each(function() {
        var $this = $(this),
            max = $this.data('max'),
            $add = $this.find('.form__add-assets');

        if ($this.find('.form__asset').length >= max) {
          $add.attr('disabled', true);
        } else {
          $add.attr('disabled', false);
        }
      });
    },
    removeAsset: function(element) {
      var $elem = $(element).parent(),
          $group = $elem.parent(),
          assetId = $elem.data('id'),
          field = $group.data('field'),
          $field = $('#' + field),
          $asset = $('[data-field="' + field + '"] [data-id="' + assetId + '"]');

      $asset
        .addClass('is-removed')
        .on('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function() {
          $asset.remove();
          rideApp.form.assets.setAssetsOrder($group);
          rideApp.form.assets.checkAssetsLimit();
        });
    },
    addAsset: function(id, name, thumb) {
      // Get the open model
      var $openModal = $('.modal.in'),
          $assetsField = $openModal.find('.form__assets'),
          assetsFieldId = $assetsField.data('field'),
          $field = $('#' + assetsFieldId),
          $assets = $('[data-field="' + assetsFieldId + '"]'),
          $items = $assets.find('.form__asset'),
          max = $assetsField.data('max');
      // var $assets = rideApp.form.assets.allAssets();

      // check if the image is already added or the limit is exceded
      if($assets.find('[data-id="' + id + '"]').length || $items.length >= max) {
        var $item = $assets.find('[data-id="' + id + '"]').find('.form__remove-asset');

        rideApp.form.assets.removeAsset($item);
        return;
      }

      var $newItem = $('<div class="form__asset" data-id="' + id + '"><img src="' + thumb + '" alt="' + name + '"><a href="#" class="form__remove-asset">×</a></div>');
      if($items.last().length) {
        $newItem.insertAfter($items.last());
      } else {
        $newItem.prependTo($assets);
      }
      $assets.sortable('refresh');
      rideApp.form.assets.checkAssetsLimit();
      rideApp.form.assets.setAssetsOrder($assetsField);

      // Reinit to 'scan' for new elements
      rideApp.form.assets.init();
    },
    resizeIframe: function(doc, height) {
      $('iframe', doc.document).height(height);
    }
  };

  var toggleDependantRows = function($input) {
    var $parent = $input.parents('form'),
        $styleClass = $input.data('toggle-dependant'),
        $group = $parent.find('[name^="' + $input.attr('name') + '"]'),
        $checked = $group.filter(':checked'),
        value = $checked.length ? $checked.val() : null;

    $('.' + $styleClass, $parent).parents('.form__item').hide();
    $('.' + $styleClass + '-' + value, $parent).parents('.form__item').show();
  };

  return {
    initialize: _initialize,
    checkLength: _checkLength,
    assets: _assets
  };
})(jQuery);

// Run the initializer
$(document).ready(function() {
  rideApp.form.initialize();
});

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
