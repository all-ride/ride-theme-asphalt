{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $localizeUrl}
        {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
    {/if}
{/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{$title}{if $subtitle} <small>{$subtitle}</small>{/if}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <div class="form__group grid">

            <div class="grid--bp-med__8">

                {if $tabs}
                <div class="tabbable">
                    <ul class="tabs">
                    {foreach $tabs as $tabName => $tab}
                        <li class="tabs__tab{if $tabName == $activeTab} active{/if}">
                            <a href="#tab{$tabName}" data-toggle="tab">{translate key=$tab.translation}</a>
                        </li>
                    {/foreach}
                    </ul>
                    <div class="tabs__content">
                    {foreach $tabs as $tabName => $tab}
                        <div id="tab{$tabName}" class="tabs__pane {if $tabName == $activeTab} active{/if}">
                        {foreach $tab.rows as $row}
                            {call formRow form=$form row=$row}
                        {/foreach}
                        </div>
                    {/foreach}
                    </div>
                </div>
                {/if}


                {call formRows form=$form}

                <div class="form__actions">
                    <input type="submit" class="btn btn--default" value="{translate key="button.save"}"{if !$isWritable} disabled="disabled"{/if} />
                    <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    {$script = 'js/form.js'}
    {if !isset($app.javascripts[$script])}
        <script src="{$app.url.base}/asphalt/js/form.js"></script>
    {/if}
{/block}
