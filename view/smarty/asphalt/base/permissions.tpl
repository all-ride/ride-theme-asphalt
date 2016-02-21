{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.permissions"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.permissions"}</h1>
    </div>
{/block}

{block name="content" append}
    {$tableActions = []}
    {$referer = $app.url.request|escape}

    {url id="system.security.user" var="urlUsers"}
    {url id="system.security.role" var="urlRoles"}
    {url id="system.security.permission.add" var="urlPermissionAdd"}

    {isGranted url=$urlPermissionAdd}
        {$urlPermissionAdd = "`$urlPermissionAdd`?referer=`$referer`"}
        {$tableActions[(string) $urlPermissionAdd] = "button.permission.add"|translate}
    {/isGranted}
    {isGranted url=$urlUsers}
        {$tableActions[(string) $urlUsers] = "button.users.manage"|translate}
    {/isGranted}
    {isGranted url=$urlRoles}
        {$tableActions[(string) $urlRoles] = "button.roles.manage"|translate}
    {/isGranted}

    {include file="base/table" table=$table tableForm=$form tableActions=$tableActions}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
