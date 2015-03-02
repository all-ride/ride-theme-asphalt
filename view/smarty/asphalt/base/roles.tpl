{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.roles"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.roles"}</h1>
    </div>
{/block}

{block name="content" append}
    {$tableActions = []}
    {$referer = $app.url.request|escape}

    {url id="system.security.role.add" var="urlRoleAdd"}
    {url id="system.security.user" var="urlUsers"}

    {isGranted url=$urlRoleAdd}
        {$urlRoleAdd = "`$urlRoleAdd`?referer=`$referer`"}
        {$tableActions.$urlRoleAdd = "button.role.add"|translate}
    {/isGranted}
    {isGranted url=$urlUsers}
        {$tableActions.$urlUsers = "button.users.manage"|translate}
    {/isGranted}

    {include file="base/table" table=$table tableForm=$form tableActions=$tableActions}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
