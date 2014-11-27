{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $localizeUrl}
        {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
    {/if}
{/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{$title}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <div class="form__group grid">

            <div class="grid--bp-med__8">
                {call formRows form=$form}

                <div class="form__actions">
                    <input type="submit" class="btn btn--default" value="{translate key="button.save"}" />
                    <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/jquery-ui.js"></script>
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
{/block}
