<!doctype html>
<!--[if IE 8]> <html class="no-js lt-ie9 lt-ie10" lang="{$app.locale}"> <![endif]-->
<!--[if IE 9]> <html class="no-js lt-ie10" lang="{$app.locale}"> <![endif]-->
<!--[if gt IE 9]><!--> <html class="no-js" lang="{$app.locale}"> <!--<![endif]-->
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
                {$customCSS = $app.system->getConfig()->get('theme.custom.css')}

                {if isset($app.styles)}
                    {foreach $app.styles as $style => $null}
                        {if substr($style, 0, 7) == 'http://' || substr(style, 0, 8) == 'https://' || substr($style, 0, 2) == '//'}
                            <link href="{$style}" rel="stylesheet" media="screen">
                        {else}
                            <link href="{$app.url.base}/asphalt/{$style}" rel="stylesheet" media="screen">
                        {/if}
                    {/foreach}
                {/if}
                {if $customCSS}
                    <link href="{$app.url.base}/{$customCSS}" rel="stylesheet" media="screen">
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
    <body class="body body--with-header" data-translation-url="{url id="api.locales.translations.exposed" parameters=["locale" => $app.locale]}" {block name="body_attributes"}{/block}>
    {literal}
    <!-- Google Tag Manager -->
    <noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-TGMGRX"
    height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-TGMGRX');</script>
    <!-- End Google Tag Manager -->
    {/literal}
{block name="body"}
    {block name="taskbar"}
        {if isset($app.taskbar)}
            {include file="base/taskbar" title=$app.taskbar->getTitle() applicationsMenu=$app.taskbar->getApplicationsMenu() settingsMenu=$app.taskbar->getSettingsMenu()}
        {/if}
    {/block}
    {block name="container"}
    <div class="page-container">
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
    </div>
    <div class="ajax-overlay">
        <div class="spinner spinner--overlay spinner--light"></div>
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
    {$customJS = $app.system->getConfig()->get('theme.custom.js')}

    {if isset($app.javascripts)}
        {foreach $app.javascripts as $script => $null}
            {if substr($script, 0, 7) == 'http://' || substr($script, 0, 8) == 'https://' || substr($script, 0, 2) == '//'}
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
    {if $customJS}
        <script src="{$app.url.base}/{$customJS}"></script>
    {/if}
    {/block}
{/block}
    </body>
</html>
