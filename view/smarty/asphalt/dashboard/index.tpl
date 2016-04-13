{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.dashboard"} - {/block}

{block name="content_body"}
<div class="dashboard">
    <div class="grid grid--bp-med-3-col">
        {foreach $layout as $region => $regionWidgets}
            <div class="column grid__item" data-region="{$region}">
            {foreach $regionWidgets as $widgetId => $widget}
                <div class="widget widget-{$widgetId}" data-widget="{$widgetId}">
                    {$widget}
                </div>
            {/foreach}
            </div>
        {/foreach}
    </div>
</div>
{/block}

{block name="styles" append}
    <link href="{$app.url.base}/asphalt/css/dashboard.css" rel="stylesheet" media="screen">
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/dashboard.js"></script>
{/block}
