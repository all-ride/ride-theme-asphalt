{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.users"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.users"}</h1>
    </div>
{/block}

{block name="content" append}
    <div class="btn--group">
        {url id="system.security.role" var="urlRoles"}
        {url id="system.security.user.add" var="urlUserAdd"}

        {isGranted url=$urlUserAdd}
        <a class="btn btn--default" href="{$urlUserAdd}?referer={$app.url.request|escape}">{translate key="button.user.add"}</a>
        {/isGranted}
        {isGranted url=$urlRoles}
        <a class="btn btn--default" href="{$urlRoles}">{translate key="button.roles.manage"}</a>
        {/isGranted}
    </div>

    <p></p>

    {include file="base/table" table=$table tableForm=$form}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/table.js"></script>
    <script>
        $('tr.disabled td.lock').each(function() {
            var $cell = $(this);

            $cell.html('<i class="glyphicon glyphicon-lock" title="' + $cell.html() + '"></i>');
        });
    </script>
{/block}
