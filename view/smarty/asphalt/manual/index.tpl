{extends file="base/index.sidebar"}

{block name="styles" append}
    <link href="{$app.url.base}/css/documentation.css" rel="stylesheet" media="screen">
{/block}

{block name="head_title" prepend}{translate key="title.manual"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.manual"}</h1>
</div>
{/block}

{block name="sidebar"}
    {foreach $pages as $path => $pathPages}
        {assign var="path" value=$path|trim:"/"}
        {if $path}
            <h3>{$path}</h3>
        {else}
            <h3>General</h3>
        {/if}

        <ul class="nav nav-pills nav-stacked">
        {foreach $pathPages as $page}
            <li><a href="{$page->getUrl()}">{$page->getTitle()}</a></li>
        {/foreach}
        </ul>
    {/foreach}
{/block}
