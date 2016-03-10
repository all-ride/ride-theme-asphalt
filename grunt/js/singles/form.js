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

// Escape ID's (needed for underscore templates)
function escapeID(myid) {
  return "#" + myid.replace(/(:|\.|\[|\]|\%|\<|\>|,)/g, "\\$1" );
}

rideApp.form = (function($, undefined) {
  var $document = $(document);
  var client = new JsonApiClient('/api/v1');

  var _initialize = function() {
    formFile();
    formCollection();

    if (jQuery.fn.sortable) {
      sortables();
    }

    _selectize();
    _autocomplete();
    this.assets.init();

    ready('[maxlength]', function() {
      rideApp.form.checkLength.init($(this), false);
    });
    ready('[data-recommended-maxlength]', function() {
      rideApp.form.checkLength.init($(this), true);
    });

    $('[data-toggle-dependant]').on('change', function() {
        toggleDependantRows($(this));
    }).each(function() {
        toggleDependantRows($(this));
    });

    _assetImageStyleHandler();
    rideApp.translator.submitTranslationKeys();
  };

  var _assetImageStyleHandler = function() {
    var asset = null;
    var style = null;
    var imageStyleAdded = rideApp.translator.translate('label.image.style.added');
    var imageStyleRemoved = rideApp.translator.translate('label.image.style.removed');
    var formImagePreviewTemplate = _.template($('#form-image-preview-template').html());
    $('.asset__crop').each(function() {
      var cropper;
      var $crop = $(this);
      var assetId = $crop.data('asset');
      var styleId = $crop.data('style');
      var ratio = $crop.data('ratio');

      $crop.find('.js-crop-toggle').on('click', function(e) {
        e.preventDefault();

        $crop.find('.js-crop-preview').addClass('superhidden');
        var $cropperRegion = $(this).addClass('superhidden').next('.js-crop-image').removeClass('superhidden');
        var image = $cropperRegion[0].querySelector('.js-enable-cropper');
        cropper = new Cropper($cropperRegion.find('.js-enable-cropper')[0], {
          aspectRatio: ratio,
          zoomOnWheel: false,
          movable: false
        });
      });

      $crop.find('.js-crop-save').on('click', function(e) {
        e.preventDefault();
        $crop.addClass('is-loading');

        if (!asset) {
          client.load('assets', assetId, function(data) {
            asset = data;
            loadImageStyle(styleId, cropper, $crop);
          });
        } else {
          loadImageStyle(styleId, cropper, $crop);
        }
      });
    });

    function loadImageStyle(id, cropper, $container) {
      client.load('image-styles', id, function(data) {
        saveImageForImageStyle(asset, data, cropper, $container);
      });
    }

    function saveImageForImageStyle(asset, imageStyle, cropper, $container) {
      var url = client.url + '/asset-image-styles?filter[exact][asset]=' + asset.id + '&filter[exact][style]=' + imageStyle.id + '&fields[asset-image-styles]=id';
      var dataUrl = cropper.getCroppedCanvas().toDataURL();

      client.sendRequest('GET', url, null, function(data) {
        if (data.length) {
          data[0].setAttribute('image', dataUrl);
          client.save(data[0], function(data) {
            finishUpdate($container, cropper, dataUrl, data.id);
          });
        } else {
          var assetImageStyle = new JsonApiDataStoreModel('asset-image-styles');

          assetImageStyle.setRelationship('asset', asset);
          assetImageStyle.setRelationship('style', imageStyle);
          assetImageStyle.setAttribute('image', dataUrl);

          client.save(assetImageStyle, function(data) {
            finishUpdate($container, cropper, dataUrl, data.id);
          });
        }

      });
    }

    function finishUpdate($container, cropper, dataUrl, id) {
      var $preview = $container.find('.js-crop-preview');

      $container.removeClass('is-loading');
      $container.find('.js-crop-toggle').removeClass('superhidden').next('.js-crop-image').addClass('superhidden');

      $preview.html(formImagePreviewTemplate({dataUrl: dataUrl, id: id})).removeClass('superhidden');

      cropper.destroy();
      $container.prev('.form__group').find('.form__image-preview').addClass('superhidden');

      alertify
        .logPosition("bottom right")
        .success(imageStyleAdded);
    }

    $document.on('click', '.assets__image-styles .js-file-delete', function(e) {
      e.preventDefault();

      var $link = $(this);
      if (confirm($link.data('message'))) {
        var id = $link.data('id');
        var $cropPreview = $link.closest('.js-crop-preview');
        var $formImagePreview = $link.closest('.form__image-preview');

        var url = client.url + '/asset-image-styles/' + id;

        client.sendRequest('DELETE', url, null, function() {
          $formImagePreview.remove();
          $cropPreview.addClass('superhidden');

          alertify
            .logPosition("bottom right")
            .success(imageStyleRemoved);
        });
      }
    });
  };

  var formFile = function() {
    $document.on('click', '.btn-file-delete:not(.assets__image-styles .btn-file-delete)', function(e) {
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
      var collection = $(this).closest('.collection-controls');
      var prototype = collection.attr('data-prototype');
      var index = collection.attr('data-index');
      if (!index) {
        index = $('.collection-control', collection).length;
      }

      prototype = prototype.replace(/%prototype%/g, 'prototype-' + index);

      // add prototype to the container
      $('.collection-control-group', collection).first().append(prototype);

      // increase the index for the next addition
      index++;

      collection.attr('data-index', index);
      collection.trigger('collectionAdded');
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
      ready('[data-autocomplete-url]', function(element) {
        makeFieldAutocomplete($(element));
      });
    }

    function makeFieldAutocomplete($field) {
      var url = $field.data('autocomplete-url');
      var multiple = $field.is('[data-autocomplete-multiple]');
      var type = $field.data('autocomplete-type');
      var locale = $field.data('autocomplete-locale');
      var headers = {};
      var plugins = [];

      if (locale) {
          headers['Accept-Language'] = locale;
      }

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

            $.ajax({
                url: fetchUrl,
                headers: headers,
                success: function(data) {
                  if (type === 'jsonapi') {
                    res = data.meta.list;
                  } else {
                    res = data;
                  }
                  var map = $.map(res, function(value) {
                    return {name: value};
                  });
                  callback(map);
                }
            });
        }
      };
      $field.selectize(autocompleteSettings);
    }
  };

  var _assets = {
    // check if needed..
    allAssets: function(){
      return $document.find('.form__assets');
    },
    modalTriggers: function(){
      return $document.find('.form__add-assets');
    },
    removeTriggers: function(){
      return $document.find('.js-remove-asset');
    },
    iframes: [],
    init: function() {
      // var $assets = rideApp.form.assets.allAssets;
      var $modalTriggers = rideApp.form.assets.modalTriggers();
      var $removeTriggers = rideApp.form.assets.removeTriggers();

      ready('.form__assets', function() {
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

        // $document.on('click', '.form__add-assets', function(e) {
        $modalTriggers.on('click', function(e) {
          e.preventDefault();
          var attr = $(this).attr('disabled');
          if (attr === 'disabled') {
            return;
          }
          var $button = $(this);
          var assetsModal = $(this).attr('href');
          var $modal = $(assetsModal);
          var $iframe = $modal.find('iframe');
          var $formAsset = $button.closest('.form__assets');

          var selected = rideApp.form.assets.getSelected($formAsset);

          var iframeUrl = $iframe.data('url');
          var searchIndex = iframeUrl.indexOf('?');
          var iframeQuery = {};
          if (searchIndex >= 0) {
            iframeQuery = queryString.parse(iframeUrl.slice(searchIndex));
            iframeUrl = iframeUrl.slice(0, (searchIndex + 1));
          }
          iframeQuery.selected = selected;

          $iframe.attr('src', iframeUrl + queryString.stringify(iframeQuery));

          $modal.modal('show').on('hidden.bs.modal', function () {
            $iframe.attr('src','');
          });
        });

        // Moved to ready function..
        // $document.on('click', '.js-remove-asset', function(e) {
        // // $removeTriggers.on('click', function(e) {
        //   e.preventDefault();
        //   rideApp.form.assets.removeAsset(this);
        // });
      });

      ready('.js-remove-asset', function() {
        this.addEventListener('click', function(e) {
          e.preventDefault();
          rideApp.form.assets.removeAsset(this);
        });
      });
    },
    getSelected: function($formAsset) {
      var field = $formAsset.data('field');
      var $field = $('#' + field);

      return $field.val();
    },
    setAssetsOrder: function($item) {
        var order = $item.sortable('toArray', {attribute: 'data-id'}),
            field = $item.data('field'),
            $field = $('#' + field);
        $field[0].value = order.join(',');

        // Find iframe url and update query parameter
        // var $iframe = $field.next().find('iframe');
        // var parsed = queryString.parse($iframe.data('src'));

        // parsed.selected = order.join(',');
        // console.log(queryString.stringify(parsed));

        // find grouped assets and reorder them...
        var $linked = rideApp.form.assets.allAssets().filter('[data-field="' + field + '"] ').not($item);
        $linked.find('.form__asset').detach();
        $linked.prepend($item.find('.form__asset').clone());
    },
    checkAssetsLimit: function() {
      var $assets = $('.form__assets');

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

      // check if the image is already added or the limit is exceded
      var $currentAsset = $assets.find('[data-id="' + id + '"]');
      if($currentAsset.length || $items.length >= max) {
        $currentAsset.find('.js-remove-asset').each(function() {
          rideApp.form.assets.removeAsset(this);
        });
        return false;
      }

      var $newItem = $('<div class="form__asset" data-id="' + id + '"><img src="' + thumb + '" alt="' + name + '"><div class="form__asset-actions"><a href="#" class="form__remove-asset js-remove-asset"><span class="icon icon--remove"></span></a></div>');
      if($items.last().length) {
        $newItem.insertAfter($items.last());
      } else {
        $newItem.prependTo($assets);
      }
      // $assets.sortable('refresh');
      rideApp.form.assets.checkAssetsLimit();
      rideApp.form.assets.setAssetsOrder($assetsField);

      // Reinit to 'scan' for new elements
      rideApp.form.assets.init();

      return true;
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
