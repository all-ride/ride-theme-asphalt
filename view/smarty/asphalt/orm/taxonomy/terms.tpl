{extends file="base/index"}

{block name="head_title" prepend}{$vocabulary->name} - {translate key="title.terms"} - {translate key="title.taxonomy"} - {/block}

{block name="taskbar_panels" append}
    {url id="taxonomy.term.list.locale" parameters=["vocabulary" => $vocabulary->getId(), "locale" => "%locale%"] var="localizeUrl"}
    {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
{/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.taxonomy"} <small>{translate key="title.terms.vocabulary" vocabulary=$vocabulary->getName()}</small></h1>
</div>
{/block}

{block name="content_body" append}
    {url id="taxonomy.term.add" parameters=["vocabulary" => $vocabulary->getId(), "locale" => $locale] var="urlTermAdd"}
    {url id="taxonomy.vocabulary.list" var="urlVocabularies"}

    {$tableActions = []}
    {$tableActions[(string) $urlTermAdd] = "button.term.add"|translate}
    {$tableActions[(string) $urlVocabularies] = "button.vocabulary.manage"|translate}

    {include file="base/table" table=$table tableForm=$form tableActions=$tableActions}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
