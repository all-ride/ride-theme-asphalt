{extends file="base/index"}

{block name="head_title" prepend}{$vocabulary->name} - {translate key="title.terms"} - {translate key="title.taxonomy"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.taxonomy"} <small>{translate key="title.terms.vocabulary" vocabulary=$vocabulary->name}</small></h1>
</div>
{/block}

{block name="content_body" append}
    <div class="btn--group">
        <a class="btn btn--default" href="{url id="taxonomy.term.add" parameters=["vocabulary" => $vocabulary->id]}">{translate key="button.term.add"}</a>
        <a class="btn btn--default" href="{url id="taxonomy.vocabulary.list"}">{translate key="button.vocabulary.manage"}</a>
    </div>

    <p></p>

    {include file="base/table" table=$table tableForm=$form}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
