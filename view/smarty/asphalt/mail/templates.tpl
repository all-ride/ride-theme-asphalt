{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.mail.templates"} | {/block}

{block name="taskbar_panels" append}
    {url id="system.mail.templates.locale" parameters=["locale" => "%locale%"] var="url"}
    {if $query}
        {$url = "`$url`?query=`$query|escape`"}
    {/if}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title"}
    <div>
        <h1>
            {translate key="title.mail.templates"}
        </h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/table" table=$table tableForm=$form tableActions=$actions}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
