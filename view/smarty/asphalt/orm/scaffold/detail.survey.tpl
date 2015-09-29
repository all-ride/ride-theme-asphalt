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

    <h2>{translate key="title.questions"}</h2>
    <div class="btn--group">
        <a href="{$addQuestionUrl}" class="btn btn--default">{translate key="button.add"}</a>
    </div>

    {include file="base/table" table=$table tableForm=$form}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
