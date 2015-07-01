{extends file="base/index"}

{block name="head_title" prepend}{$title} - {/block}

{block name="taskbar_panels" append}
    {if $localizeUrl}
        {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
    {/if}
{/block}

{block name="content_title"}
<div class="page-header">
    <h1>{$title}</h1>
</div>
{/block}

{block name="content_body" append}
    {include file="base/table" table=$table tableForm=$form tableActions=$actions}

    {if $exports}
        {translate key="label.export"}

        {foreach $exports as $extension => $url}
            <a href="{$url}" title="{translate key="label.export.to" format=$extension}">
                <img src="{image src="asphalt/img/export/`$extension`.png"}" />
            </a>
        {/foreach}
    {/if}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
