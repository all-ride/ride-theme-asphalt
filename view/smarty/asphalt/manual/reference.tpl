{extends file="manual/index"}

{block name="head_title" prepend}{translate key="title.reference"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.manual"} <small>{translate key="title.reference"}</small></h1>
</div>
{/block}

{block name="content_body" append}
    {foreach $references as $type => $reference}
        {if $reference}
            <h2>{$type}</h2>
            <dl>
            {foreach $reference as $key => $description}
                <dt>{$key}</dt>
                <dd>{$description}</dd>
            {/foreach}
            </dl>
        {/if}
    {/foreach}
{/block}
