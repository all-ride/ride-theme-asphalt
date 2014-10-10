{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.system"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.system"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/system.tabs" active="cache"}

    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST">
        <div class="form__group">
            <div class="form__group">
                <div class="col-lg-12">
                    {foreach $controls as $name => $control}
                        {call formWidget form=$form row=$name}
                    {/foreach}
                </div>
            </div>

            <div class="form-actions">
                <input type="submit" name="submit" class="btn btn--default" value="{"label.`$action`"|translate}" />
                {if $action == "enable"}
                    <a href="{url id="system.cache.clear"}" class="btn">{translate key="button.cache.clear"}</a>
                {else}
                    <a href="{url id="system.cache"}" class="btn">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </div>
    </form>
{/block}
