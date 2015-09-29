{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.permissions"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.permissions"}{if $permission} <small>{$permission}</small>{/if}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            {call formActions referer=$referer}
        </div>
    </form>
{/block}
