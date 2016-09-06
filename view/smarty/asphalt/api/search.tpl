{extends file="api/index"}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.api"} <small>{translate key="title.search"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    <div id="api">
        <div class="detail">
        {if $searchQuery}
            <p>{translate key="label.api.search.query" query=$searchQuery}</p>

            {if $searchClasses || $searchNamespaces}
                {if $searchClasses}
                <h3>{translate key="title.classes"}</h3>
                <ul>
                    {foreach $searchClasses as $class => $name}
                    <li><a href="{$urlClass}/{$class}" title="{$class}">{$class}</a></li>
                    {/foreach}
                </ul>
                {/if}

                {if $searchNamespaces}
                <h3>{translate key="title.namespaces"}</h3>
                <ul>
                    {foreach $searchNamespaces as $namespace => $name}
                    <li><a href="{$urlNamespace}/{$namespace}" title="{$namespace}">{$namespace}</a></li>
                    {/foreach}
                </ul>
                {/if}
            {else}
                <p>{translate key="label.api.search.result" query=$searchQuery}</p>
            {/if}
        {else}
            <p>{translate key="label.api.search.empty"}</p>
        {/if}
        </div>
    </div>
{/block}
