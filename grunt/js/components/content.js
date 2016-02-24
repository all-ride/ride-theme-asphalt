window.rideApp = window.rideApp || {};

rideApp.content = (function($, undefined) {
  var locale = document.documentElement.lang;
  var apiClient = new JsonApiClient('/api/v1');

  var _initialize = function() {
    var $richContent = $('.js-rich-content');

    $richContent.each(function() {
        var $element = $(this);
        var options = $element.data('rich-content-properties');
        var redactorOptions = $element.data('redactor-properties');

        options = $.extend(options, {
          "el": $element
        });

        SirTrevor.Blocks.Heading = heading_block;
        SirTrevor.Blocks.Asset = asset_block;
        SirTrevor.Blocks.Tweet = tweet_block;
        SirTrevor.Blocks.Quote = quote_block;

        rideApp.content.initWysiwyg(redactorOptions);
        new SirTrevor.Editor(options);
    });
  };

  var _initWysiwyg = function(options) {
    options = htmlEscape(JSON.stringify(options));
    var textAreaTemplate = '<textarea class="st-text-block wysiwyg form__text" data-redactor-properties="' + options + '"></textarea>';
    // st-text-block class needed for save

    // Set options for new blocks
    SirTrevor.setBlockOptions("Wysiwyg", {
      editorHTML: function() {
        return textAreaTemplate;
      }
    });

    // Set options for existing blocks
    SirTrevor.Blocks.Wysiwyg = (function(){
      return SirTrevor.Block.extend({
        type: "Wysiwyg",

        title: function() { return 'Wysiwyg'; },

        editorHTML: textAreaTemplate,

        icon_name: 'text',

        loadData: function(data){
          var $editor = $(this.$editor);
          $editor.html(data.text);
        },

        save: function() {
          var dataObj = {};
          dataObj.text = this.$editor.val();

          if (!_.isEmpty(dataObj)) {
            this.setData(dataObj);
          }
        },

        onBlockRender: function(data){
          var textarea = this.$editor;
          $(textarea).initRedactor();
        }
      });
    })();
  };

  var heading_block = (function() {
    var _template = _.template('<<%- tagName %> class="st-required st-text-block st-text-block--heading" contenteditable="true"><%= text %></<%- tagName %>>');
    var _setHeading = function(tag) {
      return function() {
        this.$('.st-block-control-ui-btn--active').removeClass('st-block-control-ui-btn--active');

        var textBlock = this.$('.st-text-block');

        textBlock.replaceWith(_template({
          tagName: tag,
          text: textBlock.html()
        }));

        this.$('.st-block-control-ui-btn--setHeading' + tag[1]).addClass('st-block-control-ui-btn--active');
      };
    };

    return SirTrevor.Blocks.Heading.extend({
      editorHTML: function() {
        return _template({
          tagName: 'h2',
          text: ''
        });
      },

      controllable: true,

      controls: {
        setHeading2: _setHeading('h2'),
        setHeading3: _setHeading('h3'),
        setHeading4: _setHeading('h4')
      },

      loadData: function(data) {
        _setHeading(data.tagName);
        this.$('.st-text-block').html(data.text);
      },

      toData: function() {
        var dataObj = {};

        dataObj.text = SirTrevor.toHTML(this.getTextBlock().html(), this.type);
        dataObj.tagName = this.getTextBlock().prop('tagName');

        this.setData(dataObj);
      }

    });
  })();

  var asset_block = (function() {
    var assetCounter = 0;
    var origin = window.location.origin;

    var asset_template = [
      '<div class="grid">',
        '<div class="grid__6">',
          '<label for="<%- assetID %>" class="form__label">Asset</label>',
          '<div class="form__item form__assets st-assets-block" data-field="<%- assetID %>" data-max="1">',
            '<a href="#<%- assetName %>" class="form__add-assets btn btn--default"><i class="icon icon--plus"></i> Toevoegen</a>',
          '</div>',
          '<input type="hidden" name="<%- assetID %>" id="<%- assetID %>" data-name="<%- assetName %>" class="st-id-input" />',
        '</div>',
        '<div class="grid__6">',
          '<label for="assetClass" class="form__label">Position</label>',
          '<select name="className" id="assetClass" class="st-className-input form__select selectized">',
          '<option value="left">Left</option>',
          '<option value="center">Center</option>',
          '<option value="right">Right</option>',
          '<option value="stretch" selected>Stretch</option>',
          '</select>',
        '</div>',
      '</div>',
      '<div class="modal modal--large fade" id="<%- assetName %>" tabindex="-1" role="dialog" aria-labelledby="myModalAssetsAdd" aria-hidden="true">',
          '<div class="modal-dialog">',
              '<div class="modal-content">',
                  '<div class="modal-body">',
                      '<iframe data-url="' + origin + '/admin/assets/' + locale + '?embed=1&amp;selected=" frameborder="0" width="100%" height="500"></iframe>',
                  '</div>',
                  '<div class="modal-footer">',
                      '<div class="grid">',
                          '<div class="grid--bp-xsm__9">',
                              '<div class="form__assets form__assets--sml" data-field="<%- assetID %>" data-max="1"></div>',
                          '</div>',
                          '<div class="grid--bp-xsm__3 text--right">',
                              '<button type="button" class="btn btn--default" data-dismiss="modal">Klaar</button>',
                          '</div>',
                      '</div>',
                  '</div>',
              '</div>',
          '</div>',
      '</div>'
    ].join('\n');
    asset_template = _.template(asset_template);

    return SirTrevor.Block.extend({
      type: 'asset',
      icon_name: 'image',
      editorHTML: function() {
        var assetID = 'rich-content-asset-' + assetCounter;
        var assetName = 'modalAssetsAdd-assets-' + assetCounter;
        assetCounter ++;

        return asset_template({
          assetID: assetID,
          assetName: assetName
        });
      },
      getIdInput: function() {
        return this.$('.st-id-input');
      },
      getClassNameInput: function() {
        return this.$('.st-className-input');
      },
      getAssetBlock: function() {
        return this.$('.st-assets-block');
      },
      onBlockRender: function() {
        rideApp.form.assets.init();
        this.getClassNameInput().selectize();
      },
      loadData: function(data) {
        if (data.id) {
          this.getIdInput().val(data.id);
        }

        if (data.assetThumbURL) {
          var $assetBlock = this.getAssetBlock();
          var $thumbWrapper = $('<div>').attr({
            'class': 'form__asset',
            'data-id': data.id
          });

          $thumbWrapper.append('<img src="' + data.assetThumbURL + '" width="100" height="100">');
          $thumbWrapper.append('<a href="#" class="form__remove-asset">×</a>');

          $assetBlock.append($thumbWrapper);
        }

        if (data.className) {
          this.getClassNameInput().find('option[value=' + data.className + ']').prop('selected', 'selected');
        }
      },
      save: function() {
        var self = this;
        var dataObj = {};
        var $assetThumb = self.getAssetBlock().find('img');

        dataObj.id = self.getIdInput().val();
        dataObj.assetThumbURL = $assetThumb.attr('src');
        dataObj.className = self.getClassNameInput().val();

        // if (dataObj.id !== '' && dataObj.assetEntry === undefined) {
        //   var url = apiClient.url + '/assets/' + dataObj.id + '?fields[assets]=id,name,alt,copyright,embedUrl,mime&url=true&images=true';
        //   apiClient.sendRequest('GET', url, null, function(data) {
        //     dataObj.assetEntry = data;
        //     self.toData(dataObj);
        //   });
        // } else {
          self.toData(dataObj);
        // }
      },
      toData: function(data) {
        this.setData(data);
      }
    });
  })();

  var tweet_block = (function () {
    return SirTrevor.Block.extend({
      type: 'tweet',

      icon_name: 'twitter',

      title: function () {
        return i18n.t('blocks:tweet:title');
      },

      editorHTML: [
        '<div>',
          '<div class="form__item">',
            '<div>',
              '<label for="st-tweet-embed" class="form__label">Twitter Embed Code</label>',
            '</div>',
            '<textarea name="st-tweet-embed" cols="90" rows="4"></textarea>',
          '</div>',
          '<div class="st-tweet-preview"></div>',
        '</div>'
      ].join('\n'),

      getEmbedInput: function () {
        return this.$('textarea');
      },

      getPreviewElement: function () {
        return this.$('.st-tweet-preview');
      },

      loadData: function (data) {
        this.getPreviewElement().html(data.embedCode);
        this.getEmbedInput().text(data.embedCode);
      },

      onBlockRender: function () {
        var self = this;
        this.getEmbedInput().on('keyup', function (e) {
          self.setAndLoadData({
            embedCode: e.target.value
          });
        });
      }

    });

  })();

  var quote_block = (function () {
    return SirTrevor.Block.extend({
      type: 'quote',

      title: function () {
        return 'highlight';
      },

      icon_name: 'quote',

      editorHTML: [
        '<div><label class="form__label">Highlight</label></div>',
        '<textarea name="text" class="st-required st-quote-text" cols="90" rows="4"></textarea>',
        '<hr/>',
        '<div><label class="form__label">Credit</label></div>',
        '<input type="text" name="cite" class="st-cite-input"/>',
      ].join('\n'),

      loadData: function (data) {
        this.$('.st-quote-text').html(data.text);

        if (data.cite) {
          this.$('.st-cite-input').val(data.cite);
        }
      }
    });
  })();

  return {
    init: _initialize,
    initWysiwyg: _initWysiwyg
  };
})(jQuery);

function htmlEscape(str) {
  // http://stackoverflow.com/questions/1219860/html-encoding-in-javascript-jquery
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}
