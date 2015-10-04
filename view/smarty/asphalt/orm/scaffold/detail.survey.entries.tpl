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

    <div class="tabbable">
        <ul class="tabs">
            <li class="tabs__tab">
                <a href="{url id="survey.detail" parameters=["id" => $entry->getId(), "locale" => $locale]}">{translate key="title.questions"}</a>
            </li>
            <li class="tabs__tab active">
                <a href="#tabentries" data-toggle="tab">{translate key="title.entries"}</a>
            </li>
        </ul>
        <div class="tabs__content">
            <div id="tabentries" class="tabs__pane active">
                {include file="base/table" table=$table tableForm=$form}
            </div>
        </div>
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
