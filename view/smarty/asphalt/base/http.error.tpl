{extends file="base/index"}

{block name="content_title"}
    <div class="page-header"><h1>{$title} <small>{$statusCode}</small></h1></div>
{/block}

{block name="content_body" append}
    {if $message}
        <p>{$message}</p>
    {/if}
{/block}