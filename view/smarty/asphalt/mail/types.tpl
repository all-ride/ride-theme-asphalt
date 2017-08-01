{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.mail.types"} | {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.mail.types"}</h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/table" table=$table tableForm=$form tableActions=$actions}
{/block}
