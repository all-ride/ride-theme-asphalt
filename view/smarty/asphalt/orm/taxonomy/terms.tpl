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
    {url id="taxonomy.vocabulary.edit" parameters=["vocabulary" => $vocabulary->getId()] var="urlEditVocabulary"}

    {$tableActions = []}
    {$tableActions[$urlTermAdd] = "button.term.add"|translate}
    {$tableActions["`$urlEditVocabulary`?referer={$app.url.request|urlencode}"] = "button.vocabulary.edit"|translate}
    {* Is this needed? *}
    {* {$tableActions[$urlVocabularies] = "button.vocabulary.manage"|translate} *}

    <p><i class="icon icon--angle-left"></i> <a href="{$urlVocabularies}">{translate key="button.vocabulary.manage"}</a></p>

    {include file="base/table" table=$table tableForm=$form tableActions=$tableActions}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
