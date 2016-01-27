window.app = window.app || {};

app.content = (function($, undefined) {

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

        app.content.initWysiwyg(redactorOptions);
        new SirTrevor.Editor(options);
    })
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

    return SirTrevor.Block.extend({
      type: 'asset',
      icon_name: 'image',
      editorHTML: function() {
        // console.log('html');

        var assetTemplate = $('.js-asset-template').html();
        var assetID = 'rich-content-asset-' + assetCounter;
        // var assetName = 'modalAssetsAdd-assets-' + assetID + assetCounter;
        assetCounter ++;

        assetTemplate = _.template(assetTemplate);

        return assetTemplate({
          assetID: assetID
        });
      },
      getIdInput: function() {
        return this.$('.js-rc-assets-input');
      },
      getClassNameInput: function() {
        return this.$('.js-rc-assets-options');
      },
      getAssetBlock: function() {
        // return this.$('.st-assets-block');
        return this.$('.js-rc-assets-block');
      },
      beforeBlockRender: function() {
        // console.log(this);
        // var $instance = $document.find(this.instanceID);
        // console.log($instance);
      },
      onBlockRender: function() {
        // console.log('block rendered');
        // console.log(this.getAssetBlock());

        rideApp.form.assets.init();
      },
      loadData: function(data) {
        // console.log('data loaded');

        if (data.thumbnailURL) {
          var $assetBlock = this.getAssetBlock();
          var $input = this.getIdInput();
          var $thumbWrapper = $('<div>').attr({
            'class': 'form__asset',
            'data-id': data.id
          });

          $thumbWrapper.append('<img src="' + data.thumbnailURL + '" width="100" height="100">');
          $thumbWrapper.append('<a href="#" class="form__remove-asset">×</a>');

          $assetBlock.append($thumbWrapper);
          $input.val(data.id);
        }
      },
      save: function() {
        var dataObj = {};
        var $assetThumb = this.getAssetBlock().find('img');

        dataObj.id = this.getIdInput().val();
        dataObj.thumbnailURL = $assetThumb.attr('src');
        dataObj.className = this.getClassNameInput().val();

        // console.log(this.getClassNameInput());
        // console.log(this.getClassNameInput().val());
        // console.log(this.getIdInput());
        // return false;

        this.toData(dataObj);
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
        return i18n.t('blocks:quote:title');
      },
      icon_name: 'quote',
      editorHTML:   [
        '<div class="st-block__section">',
          '<div><label class="form__label">Quote</label></div>',
          '<textarea name="text" class="st-required st-quote-text" cols="90" rows="4"></textarea>',
        '</div>',
        '<div class="st-block__section">',
          '<div><label class="form__label">Credit</label></div>',
          '<input type="text" name="cite" class="st-cite-input"/>',
        '</div>',
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
