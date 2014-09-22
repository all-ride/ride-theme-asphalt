<ul class="nav nav-tabs">
    <li{if $active == "system"} class="active"{/if}><a href="{url id="system"}">{translate key="title.details"}</a></li>
    <li{if $active == "cache"} class="active"{/if}><a href="{url id="system.cache"}">{translate key="title.cache"}</a></li>
    <li{if $active == "parameters"} class="active"{/if}><a href="{url id="system.parameters"}">{translate key="title.parameters"}</a></li>
    <li{if $active == "routes"} class="active"{/if}><a href="{url id="system.routes"}">{translate key="title.routes"}</a></li>
    <li{if $active == "dependencies"} class="active"{/if}><a href="{url id="system.dependencies"}">{translate key="title.dependencies"}</a></li>
</ul>
