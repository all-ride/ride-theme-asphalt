{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.users"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.users"}</h1>
    </div>
{/block}

{block name="content" append}
    {$tableActions = []}
    {$referer = $app.url.request|escape}

    {url id="system.security.role" var="urlRoles"}
    {url id="system.security.user.add" var="urlUserAdd"}

    {isGranted url=$urlUserAdd}
        {$urlUserAdd = "`$urlUserAdd`?referer=`$referer`"}
        {$tableActions.$urlUserAdd = "button.user.add"|translate}
    {/isGranted}
    {isGranted url=$urlRoles}
        {$tableActions.$urlRoles = "button.roles.manage"|translate}
    {/isGranted}

    {include file="base/table" table=$table tableForm=$form tableActions=$tableActions}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
    <script>
        $('tr.disabled td.lock').each(function() {
            var $cell = $(this);

            $cell.html('<i class="glyphicon glyphicon-lock" title="' + $cell.html() + '"></i>');
        });
    </script>
{/block}
