{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.terminal"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.terminal"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
        <div class="result">
            <pre class="result"></pre>
        </div>
        <div class="bash">
            <pre class="bash"><span class="path">{$path}</span> $</pre> {call formWidget form=$form row="command"}
        </div>
    </form>
{/block}

{block name="styles" append}
    <link href="{$app.url.base}/css/terminal.css" rel="stylesheet" media="screen">
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/terminal.js"></script>
    <script type="text/javascript">
        $(function() {
            ride.terminal.init();
        });
    </script>
{/block}

