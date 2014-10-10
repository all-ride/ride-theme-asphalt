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
    <div class="btn--group">
    {foreach $actions as $url => $dataAction}
        <a href="{$url}" class="btn btn--default">{$dataAction}</a>
    {/foreach}
    </div>

    <p></p>

    {include file="base/table" table=$table tableForm=$form}

    {if $exports}
        {translate key="orm.label.export"}

        {foreach $exports as $extension => $url}
            <a href="{$url}" title="{translate key="orm.label.export.to" format=$extension}">
                <img src="{image src="img/export/`$extension`.png"}" />
            </a>
        {/foreach}
    {/if}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/jquery-ui.js"></script>
    <script src="{$app.url.base}/js/form.js"></script>
    <script src="{$app.url.base}/js/table.js"></script>
{/block}
