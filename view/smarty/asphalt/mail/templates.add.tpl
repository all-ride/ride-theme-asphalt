{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.mail.templates"} | {/block}

{block name="taskbar_panels" append}
    {url id="system.mail.templates.locale" parameters=["locale" => "%locale%"] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title"}
    <div>
        <h1>
            {translate key="title.mail.templates"}
            <small class="text-muted">{translate key="title.mail.templates.add"}</small>
        </h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form class="form-selectize" id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        {call formRows form=$form}
        {call formActions referer=$referer submit="button.next"}
    </form>
{/block}

{block name="scripts" append}
    {$script = 'js/form.js'}
    {if !isset($app.javascripts[$script])}
        <script src="{$app.url.base}/asphalt/js/form.js"></script>
    {/if}
{/block}
