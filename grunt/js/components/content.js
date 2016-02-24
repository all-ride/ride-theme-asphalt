window.rideApp = window.rideApp || {};

rideApp.content = (function($, undefined) {
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
    var options = htmlEscape(JSON.stringify(options));
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

  function htmlEscape(str) {
    // http://stackoverflow.com/questions/1219860/html-encoding-in-javascript-jquery
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;');
  }

  // function htmlUnescape(value){
  //   return String(value)
  //       .replace(/&quot;/g, '"')
  //       .replace(/&#39;/g, "'")
  //       .replace(/&lt;/g, '<')
  //       .replace(/&gt;/g, '>')
  //       .replace(/&amp;/g, '&');
  // }

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
    return SirTrevor.Block.extend({
      type: 'asset',
      icon_name: 'image',
      editorHTML: [
        '<div class="grid">',
          '<div class="grid__4 grid--bp-xsm__3 grid--bp-sml__2">',
            '<div class="form__item form__assets">',
              '<label for="assetId" class="form__label">Asset ID</label>',
              '<input id="assetId" type="text" name="id" class="st-id-input form__text"/>',
              '<a href="#modalAssetsAdd" class="form__add-assets btn btn--default"><i class="icon icon--plus"></i></a>',
            '</div>',
          '</div>',
          '<div class="grid__8 grid--bp-xsm__7 grid--bp-sml__6">',
            '<label for="assetClass" class="form__label">Position</label>',
            '<select name="className" id="assetClass" class="st-className-input form__select">',
            '<option value="left">Left</option>',
            '<option value="center">Center</option>',
            '<option value="right">Right</option>',
            '<option value="stretch">Stretch</option>',
            '</select>',
          '</div>',
        '</div>',
        '<hr>',
        '<div class="st-asset-block">',
          '<img src alt="">',
        '</div>'
      ].join('\n'),

      getIdInput: function() {
        return this.$('.st-id-input');
      },

      getClassNameInput: function() {
        return this.$('.st-className-input');
      },

      getAssetBlock: function() {
        return this.$('.st-asset-block').find('img');
      },

      onBlockRender: function() {
        this.getIdInput().on('change', this.loadAsset.bind(this));

        this.getClassNameInput().on('change', this.loadClass.bind(this));

        this.getAssetBlock().on('load', (function() {
          this.ready();
        }).bind(this));

        this.getAssetBlock().on('error', (function() {
          this.ready();
          if(this.getAssetBlock().attr('src')) {
            this.setError(this.getIdInput(), 'Could not find asset with ID ' + this.getData().data.id);
          }
        }).bind(this));

        rideApp.form.assets.init();
      },

      loadAsset: function() {
        this.save();
        this.resetErrors();
        this.loading();
        var id = this.getData().data.id;
        this.getAssetBlock().attr('src', window.location.origin + '/assets/' + id);
      },

      loadClass: function() {
        this.save();
        var className = this.getData().data.className;
        this.getAssetBlock().attr('class', className);
      },

      save: function() {
        var data = this._serializeData();

        apiClient.load('assets', data.id, function(data) {
          console.log(data);
        });

        if (!_.isEmpty(data)) {
          this.setData(data);
        }
      },

      loadData: function(data) {
        this.loading();

        this.getClassNameInput().children().filter(function() {
          return $(this).val() == data.className;
        }).prop('selected', true);

        this.getIdInput().val(data.id);

        this.loadAsset();
        this.loadClass();
      }

      // toData: function() {
      //   var dataObj = {};
      //   var assetId = this.getIdInput().val();

      //   dataObj.this.getIdInput().val();
      //   dataObj.this.getClassNameInput().val();

      //   this.setData(dataObj);
      // }

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
        return i18n.t('blocks:quote:title');
      },

      icon_name: 'quote',

      editorHTML: [
        '<div><label class="form__label">Quote</label></div>',
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
  }
})(jQuery);
