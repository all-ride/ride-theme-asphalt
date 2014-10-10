{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.password.reset"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.password.reset"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRow form=$form row="user"}

            {call formActions referer=$referer}
        </div>
    </form>
{/block}
