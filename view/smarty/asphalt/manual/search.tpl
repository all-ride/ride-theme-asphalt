{extends file="manual/index"}

{block name="manual_content" append}
    {if $query}
        <h2>{translate key="search.title.query" query=$searchQuery}</h2>

        {if $searchResult}
            <ul>
                {foreach $searchResult as $name => $page}
                <li><a href="{$page->getUrl()}">{$page->getTitle()}</a></li>
                {/foreach}
            </ul>
        {else}
            <p>{translate key="manual.label.search.result" query=$searchQuery}</p>
        {/if}
    {else}
        <h2>{translate key="search.title"}</h2>
        <p>{translate key="manual.label.search.empty"}</p>
    {/if}
{/block}
