{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.tasks"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>
        {translate key="title.tasks"}
        <small>{$name}</small>
    </h1>
</div>
{/block}

{block name="content_body" append}
    <pre>{$queueJobStatus->getDescription()}</pre>
{/block}
