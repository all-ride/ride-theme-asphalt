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
        <div class="grid">
            <div class="grid__12 grid--bp-med__8">
                {call formRows form=$form}
            </div>
            <div class="grid__12 grid--bp-med__4">
                <h3>{translate key="title.mail.variables.content"}</h3>
                <p>{translate key="label.mail.variables.content.description"}</p>
                <table>
                {foreach $contentVariables as $variableName => $variableDescription}
                    <tr>
                        <td>
                            <span class="label label-default js-content-variable-drag" data-variable="[[{$variableName}]]">{$variableName}</span>
                        </td>
                        <td>
                            {$variableDescription|translate}
                        </td>
                    </tr>
                {/foreach}
                </table>

                <h3>{translate key="title.mail.variables.recipient"}</h3>
                <p>{translate key="label.mail.variables.recipient.description"}</p>
                <table>
                {foreach $recipientVariables as $variableName => $variableDescription}
                    <tr>
                        <td>
                            <span class="label label-default js-recipient-variable-drag" data-variable="[[{$variableName}]]">{$variableName}</span>
                        </td>
                        <td>
                            {$variableDescription|translate}
                        </td>
                    </tr>
                {/foreach}
                </table>
            </div>
        </div>

        {call formActions referer=$referer submit="button.save"}
    </form>
{/block}

{block name="scripts" append}
    {$script = 'js/form.js'}
    {if !isset($app.javascripts[$script])}
        <script src="{$app.url.base}/asphalt/js/form.js"></script>
    {/if}
    <script src="{$app.url.base}/asphalt/js/mailer.js"></script>
{/block}
