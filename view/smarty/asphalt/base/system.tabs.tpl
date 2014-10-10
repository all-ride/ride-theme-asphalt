<ul class="tabs">
    <li class="tabs__tab {if $active == "system"} active{/if}"><a href="{url id="system"}">{translate key="title.details"}</a></li>
    <li class="tabs__tab {if $active == "cache"} active{/if}"><a href="{url id="system.cache"}">{translate key="title.cache"}</a></li>
    <li class="tabs__tab {if $active == "parameters"} active{/if}"><a href="{url id="system.parameters"}">{translate key="title.parameters"}</a></li>
    <li class="tabs__tab {if $active == "routes"} active{/if}"><a href="{url id="system.routes"}">{translate key="title.routes"}</a></li>
    <li class="tabs__tab {if $active == "dependencies"} active{/if}"><a href="{url id="system.dependencies"}">{translate key="title.dependencies"}</a></li>
</ul>
