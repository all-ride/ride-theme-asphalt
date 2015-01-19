{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.profile"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.profile"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" enctype="multipart/form-data" role="form">
        <div class="form__group">
            <div class="tabbable">
            <ul class="tabs">
            {foreach $hooks as $hookName => $hook}
                <li class="tabs__tab {if $activeHook == $hookName} active{/if}"><a href="#hook-{$hookName}" data-toggle="tab">{translate key="profile.hook.`$hookName`"}</a></li>
            {/foreach}
            {if $form->hasRow('submit-unregister')}
                <li class="tabs__tab"><a href="#hook-unregister" data-toggle="tab">{translate key="button.unregister"}</a></li>
            {/if}
            </ul>

            <div class="tabs__content">
            {foreach $hooks as $hookName => $hook}
                <div id="hook-{$hookName}" class="tabs__pane{if $activeHook == $hookName} active{/if}">
                    {$hookViews.$hookName}
                </div>
            {/foreach}
            {if $form->hasRow('submit-unregister')}
                <div id="hook-unregister" class="tabs__pane{if $activeHook == 'unregister'} active{/if}">
                    <p>{translate key="label.unregister"}</p>

                    {call formRow form=$form row="submit-unregister"}
                </div>
            {/if}
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/singles/form.js"></script>
{/block}
