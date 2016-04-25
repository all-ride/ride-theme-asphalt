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
    {function renderExportButton}
        {if $exports}
            <div class="spacer clearfix">
                <div class="pull--right">
                    {foreach $exports as $extension => $url}
                        {strip}
                        <a href="{$url}" title="{translate key="label.export.to" format=$extension}">
                            <i class="icon icon--share-square-o icon--before icon--center"></i>
                            {translate key="label.export"} ({$extension})
                        </a>
                        {/strip}
                    {/foreach}
                </div>
            </div>
        {/if}
    {/function}

    {call renderExportButton}

    {include file="base/table" table=$table tableForm=$form tableActions=$actions}

    {call renderExportButton spacerClass="spacer--last"}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
