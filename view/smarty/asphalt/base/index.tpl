<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="{$app.locale}"><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8" lang="{$app.locale}"><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9" lang="{$app.locale}"><![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="{$app.locale}"><!--<![endif]-->
    <head>
        {block name="head"}
                <meta charset="utf-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <title>{block name="head_title"}{if isset($app.taskbar)}{$app.taskbar->getTitle()}{/if}{/block}</title>
            {block name="styles"}
                <!--[if gt IE 8]><!--><link rel="stylesheet" href="{$app.url.base}/asphalt/css/main.min.css"> <!--<![endif]-->
                <!--[if lt IE 9]><link rel="stylesheet" href="{$app.url.base}/asphalt/css/main-legacy.min.css"><![endif]-->
                <!--[if gt IE 8]><!--><link rel="stylesheet" href="{$app.url.base}/asphalt/css/custom.min.css"> <!--<![endif]-->
                <!--[if lt IE 9]><link rel="stylesheet" href="{$app.url.base}/asphalt/buckleup/css/custom-legacy.min.css"><![endif]-->
            {/block}

            {block name="styles_app"}
                {if isset($app.styles)}
                    {foreach $app.styles as $style => $null}
                        {if substr($style, 0, 7) == 'http://' || substr(style, 0, 8) == 'https://' || substr($style, 0, 2) == '//'}
                            <link href="{$style}" rel="stylesheet" media="screen">
                        {else}
                            <link href="{$app.url.base}/asphalt/{$style}" rel="stylesheet" media="screen">
                        {/if}
                    {/foreach}
                {/if}
            {/block}

            {block name="head_scripts"}
                <script type="text/javascript" src="{$app.url.base}/asphalt/buckleup/js/modernizr.custom.min.js"></script>
                <!--[if lt IE 9]><script type="text/javascript" src="{$app.url.base}/asphalt/buckleup/js/polyfill.min.js"></script><![endif]-->
                {literal}
                <script type="text/javascript">
                    WebFontConfig = {
                        google: { families: [ 'Roboto:300,300italic,400,400italic,700,700italic:latin' ] }
                    };
                    (function() {
                        var wf = document.createElement('script');
                        wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
                            '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
                        wf.type = 'text/javascript';
                        wf.async = 'true';
                        var s = document.getElementsByTagName('script')[0];
                        s.parentNode.insertBefore(wf, s);
                    })();
                </script>
                {/literal}
            {/block}
        {/block}
    </head>
    <body>
{block name="body"}
    {block name="taskbar"}
        {if isset($app.taskbar)}
            {include file="base/taskbar" title=$app.taskbar->getTitle() applicationsMenu=$app.taskbar->getApplicationsMenu() settingsMenu=$app.taskbar->getSettingsMenu()}
        {/if}
    {/block}
    {block name="container"}
        <div class="container">
        {block name="content"}
            {block name="content_title"}{/block}
            {block name="messages"}
                {if isset($app.messages)}
                    {$_messageTypes = ["error" => "danger", "warning" => "warning", "success" => "success", "information" => "info"]}
                    {foreach $_messageTypes as $_messageType => $_messageClass}
                        {$_messages = $app.messages->getByType($_messageType)}
                        {if $_messages}
                            <div class="notice notice--{$_messageClass}" role="alert">
                                <button type="button" class="btn btn--close" data-dismiss="alert">
                                    <span aria-hidden="true">×</span><span class="visuallyhidden">Close</span>
                                </button>
                                {if $_messages|count == 1}
                                    {$_message = $_messages|array_pop}
                                    <p>{$_message->getMessage()}</p>
                                {else}
                                    <ul>
                                    {foreach $_messages as $_message}
                                        <li>{$_message->getMessage()}</li>
                                    {/foreach}
                                    </ul>
                                {/if}
                            </div>
                        {/if}
                    {/foreach}
                {/if}
            {/block}
            {block name="content_body"}{/block}
        {/block}
        </div>
        <div class="ajax-overlay">
            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="24px" height="30px" viewBox="0 0 24 30" style="enable-background:new 0 0 50 50;" xml:space="preserve">
                <rect x="0" y="5.39037" width="4" height="19.2193" fill="#333" opacity="0.2">
                  <animate attributeName="opacity" attributeType="XML" values="0.2; 1; .2" begin="0s" dur="0.6s" repeatCount="indefinite"></animate>
                  <animate attributeName="height" attributeType="XML" values="10; 20; 10" begin="0s" dur="0.6s" repeatCount="indefinite"></animate>
                  <animate attributeName="y" attributeType="XML" values="10; 5; 10" begin="0s" dur="0.6s" repeatCount="indefinite"></animate>
                </rect>
                <rect x="8" y="7.10963" width="4" height="15.7807" fill="#333" opacity="0.2">
                  <animate attributeName="opacity" attributeType="XML" values="0.2; 1; .2" begin="0.15s" dur="0.6s" repeatCount="indefinite"></animate>
                  <animate attributeName="height" attributeType="XML" values="10; 20; 10" begin="0.15s" dur="0.6s" repeatCount="indefinite"></animate>
                  <animate attributeName="y" attributeType="XML" values="10; 5; 10" begin="0.15s" dur="0.6s" repeatCount="indefinite"></animate>
                </rect>
                <rect x="16" y="9.60963" width="4" height="10.7807" fill="#333" opacity="0.2">
                  <animate attributeName="opacity" attributeType="XML" values="0.2; 1; .2" begin="0.3s" dur="0.6s" repeatCount="indefinite"></animate>
                  <animate attributeName="height" attributeType="XML" values="10; 20; 10" begin="0.3s" dur="0.6s" repeatCount="indefinite"></animate>
                  <animate attributeName="y" attributeType="XML" values="10; 5; 10" begin="0.3s" dur="0.6s" repeatCount="indefinite"></animate>
                </rect>
              </svg>
        </div>
    {/block}
    {block name="scripts"}
        <script src="{$app.url.base}/asphalt/js/jquery.min.js"></script>
        <script type="text/javascript">
          window.app = window.app || {};
          app.variables = {
            assetsPath: "/",
          };

          // Parsley config
          window.ParsleyConfig = window.ParsleyConfig || {};
          window.ParsleyConfig = {
            trigger: 'change, focusout',
            excluded: 'input:not(:visible)',
            classHandler: function (ParsleyField) {
              return ParsleyField.$element.closest('.form__item');
            },
            errorsContainer: function (ParsleyField) {
              return ParsleyField.$element.closest('.form__item');
            }
          };
        </script>
        <script type="text/javascript" src="{$app.url.base}/asphalt/buckleup/js/main.min.js"></script>
        <script type="text/javascript" src="{$app.url.base}/asphalt/js/singles/ajax.js"></script>
    {/block}
    {block name="scripts_app"}
    {if isset($app.javascripts)}
        {foreach $app.javascripts as $script => $null}
            {if substr($script, 0, 7) == 'http://' || substr(script, 0, 8) == 'https://' || substr($script, 0, 2) == '//'}
        <script src="{$script}"></script>
            {elseif substr($script, 0, 7) == '<script'}
        {$script}
            {elseif $script != 'js/jquery.min.js' && $script != 'js/bootstrap.min.js'}
        <script src="{$app.url.base}/asphalt/{$script}"></script>
            {/if}
        {/foreach}
    {/if}
    {if isset($app.inlineJavascripts)}
        <script type="text/javascript">
            $(function() {
            {foreach $app.inlineJavascripts as $inlineJavascript}
                {$inlineJavascript}
            {/foreach}
            });
        </script>
    {/if}
    {/block}
{/block}
    </body>
</html>
