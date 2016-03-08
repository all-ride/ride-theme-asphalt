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
            {block "favicon"}
                <link rel="icon" type="image/png" href="{$app.url.base}/img/favicon.png" />
            {/block}
            {block name="styles"}
                <!--[if gt IE 8]><!--><link rel="stylesheet" href="{$app.url.base}/asphalt/css/main.min.css"> <!--<![endif]-->
                <!--[if lt IE 9]><link rel="stylesheet" href="{$app.url.base}/asphalt/css/main-legacy.min.css"><![endif]-->
                <!--[if gt IE 8]><!--><link rel="stylesheet" href="{$app.url.base}/asphalt/css/custom.min.css"> <!--<![endif]-->
                <!--[if lt IE 9]><link rel="stylesheet" href="{$app.url.base}/asphalt/css/custom-legacy.min.css"><![endif]-->
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
                <script type="text/javascript" src="{$app.url.base}/asphalt/js/modernizr.min.js"></script>
                <!--[if lt IE 9]><script type="text/javascript" src="{$app.url.base}/asphalt/js/polyfill.min.js"></script><![endif]-->
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
    <body data-translation-url="{url id="api.locales.translations.exposed" parameters=["locale" => $app.locale]}" {block name="body_attributes"}{/block}>
    {literal}
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-70680296-1', 'auto');
      ga('send', 'pageview');

    </script>
    {/literal}
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
            <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                 width="25px" height="25px" viewBox="0 0 50 50" style="enable-background:new 0 0 50 50;" xml:space="preserve" class="anim--spin">
                <g>
                    <path opacity="0.5" fill="#010101" d="M27.6,9.9c0,1.4-1.1,2.5-2.5,2.5l0,0c-1.4,0-2.5-1.1-2.5-2.5V2.5c0-1.4,1.1-2.5,2.5-2.5l0,0
                        c1.4,0,2.5,1.1,2.5,2.5V9.9z"/>
                    <path fill="#010101" d="M27.6,47c0,1.4-1.1,2.5-2.5,2.5l0,0c-1.4,0-2.5-1.1-2.5-2.5v-7.4c0-1.4,1.1-2.5,2.5-2.5l0,0
                        c1.4,0,2.5,1.1,2.5,2.5V47z"/>
                    <path opacity="0.25" fill="#010101" d="M10.3,22.3c1.4,0,2.5,1.1,2.5,2.5l0,0c0,1.4-1.1,2.5-2.5,2.5H2.8c-1.4,0-2.5-1.1-2.5-2.5
                        l0,0c0-1.4,1.1-2.5,2.5-2.5H10.3z"/>
                    <path opacity="0.65" fill="#010101" d="M47.4,22.3c1.4,0,2.5,1.1,2.5,2.5l0,0c0,1.4-1.1,2.5-2.5,2.5H40c-1.4,0-2.5-1.1-2.5-2.5l0,0
                        c0-1.4,1.1-2.5,2.5-2.5H47.4z"/>
                    <path opacity="0.2" fill="#010101" d="M11,30c1.2-0.7,2.7-0.3,3.4,0.9l0,0c0.7,1.2,0.3,2.7-0.9,3.4l-6.4,3.7
                        c-1.2,0.7-2.7,0.3-3.4-0.9l0,0C3,36,3.4,34.4,4.6,33.8L11,30z"/>
                    <path opacity="0.6" fill="#010101" d="M43.2,11.5c1.2-0.7,2.7-0.3,3.4,0.9l0,0c0.7,1.2,0.3,2.7-0.9,3.4l-6.4,3.7
                        c-1.2,0.7-2.7,0.3-3.4-0.9l0,0c-0.7-1.2-0.3-2.7,0.9-3.4L43.2,11.5z"/>
                    <path opacity="0.8" fill="#010101" d="M30.4,38.9c-0.7-1.2-0.3-2.7,0.9-3.4l0,0c1.2-0.7,2.7-0.3,3.4,0.9l3.7,6.4
                        c0.7,1.2,0.3,2.7-0.9,3.4l0,0c-1.2,0.7-2.7,0.3-3.4-0.9L30.4,38.9z"/>
                    <path opacity="0.45" fill="#010101" d="M11.8,6.7c-0.7-1.2-0.3-2.7,0.9-3.4l0,0c1.2-0.7,2.7-0.3,3.4,0.9l3.7,6.4
                        c0.7,1.2,0.3,2.7-0.9,3.4l0,0c-1.2,0.7-2.7,0.3-3.4-0.9L11.8,6.7z"/>
                    <path opacity="0.15" fill="#010101" d="M15.6,36.4c0.7-1.2,2.2-1.6,3.4-0.9l0,0c1.2,0.7,1.6,2.2,0.9,3.4l-3.7,6.4
                        c-0.7,1.2-2.2,1.6-3.4,0.9l0,0c-1.2-0.7-1.6-2.2-0.9-3.4L15.6,36.4z"/>
                    <path opacity="0.55" fill="#010101" d="M34.1,4.2c0.7-1.2,2.2-1.6,3.4-0.9l0,0c1.2,0.7,1.6,2.2,0.9,3.4l-3.7,6.4
                        c-0.7,1.2-2.2,1.6-3.4,0.9l0,0c-1.2-0.7-1.6-2.2-0.9-3.4L34.1,4.2z"/>
                    <path opacity="0.7" fill="#010101" d="M36.7,34.3c-1.2-0.7-1.6-2.2-0.9-3.4l0,0c0.7-1.2,2.2-1.6,3.4-0.9l6.4,3.7
                        c1.2,0.7,1.6,2.2,0.9,3.4l0,0c-0.7,1.2-2.2,1.6-3.4,0.9L36.7,34.3z"/>
                    <path opacity="0.35" fill="#010101" d="M4.6,15.8c-1.2-0.7-1.6-2.2-0.9-3.4l0,0c0.7-1.2,2.2-1.6,3.4-0.9l6.4,3.7
                        c1.2,0.7,1.6,2.2,0.9,3.4l0,0c-0.7,1.2-2.2,1.6-3.4,0.9L4.6,15.8z"/>
                </g>
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
        </script>
        <script type="text/javascript" src="{$app.url.base}/asphalt/js/main.min.js"></script>
        <script type="text/javascript" src="{$app.url.base}/asphalt/js/ajax.js"></script>
    {/block}
    {block name="scripts_app"}
    {if isset($app.javascripts)}
        {$translatorUrl = "`$app.url.base`/js/translator.js"}
        {if in_array($translatorUrl, $app.javascripts)}
            <script src="{$translatorUrl}"></script>
        {/if}
        {foreach $app.javascripts as $script => $null}
            {if $script != $translatorUrl}
                {if substr($script, 0, 7) == 'http://' || substr($script, 0, 8) == 'https://' || substr($script, 0, 2) == '//'}
            <script src="{$script}"></script>
                {elseif substr($script, 0, 7) == '<script'}
            {$script}
                {elseif $script != 'js/jquery.min.js' && $script != 'js/bootstrap.min.js'}
            <script src="{$app.url.base}/asphalt/{$script}"></script>
                {/if}
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
