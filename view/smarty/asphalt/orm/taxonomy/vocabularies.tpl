{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.vocabularies"} - {translate key="title.taxonomy"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.taxonomy"} <small>{translate key="title.vocabularies"}</small></h1>
</div>
{/block}

{block name="content_body" append}
    <div class="btn--group">
        <a class="btn btn--default" href="{url id="taxonomy.vocabulary.add"}?referer={$app.url.request|urlencode}">{translate key="button.vocabulary.add"}</a>
    </div>

    <p></p>

    {include file="base/table" table=$table tableForm=$form}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/form.js"></script>
    <script src="{$app.url.base}/js/table.js"></script>
{/block}
