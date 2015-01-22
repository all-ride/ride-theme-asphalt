{extends file="base/index"}

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

{block name="content" append}
    <div class="btn--group">
        <a href="{$editUrl}" class="btn btn--default">{translate key="button.edit"}</a>
        <a href="{$backUrl}" class="btn btn--default">{translate key="button.back"}</a>
    </div>

    <h2>{translate key="title.details"}</h2>
    {if $entry->image}
        <div class="grid">
            <div class="col-lg-3">
                <img src="{image src=$entry->image transformation="crop" width=400 height=400}" class="img-responsive" />
            </div>
            <div class="col-lg-9">
                {$entry->description}
            </div>
        </div>
    {else}
        {$entry->description}
    {/if}

    <h2>{translate key="title.performances"}</h2>
    <div class="btn--group">
        <a href="{$addPerformanceUrl}" class="btn btn--default">{translate key="button.add"}</a>
    </div>

    {include file="base/table" table=$table tableForm=$form}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
