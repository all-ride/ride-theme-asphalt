{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.users"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.users"}{if $user->getId()} <small>{$user->getDisplayName()}</small>{/if}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <div class="form__group">
            <h3>{translate key="title.details"}</h3>
            {call formRow form=$form row="name"}
            {call formRow form=$form row="email"}
            {call formRow form=$form row="email-confirmed"}
            {call formRow form=$form row="image"}

            <h3>{translate key="title.credentials"}</h3>
            {call formRow form=$form row="username"}
            {call formRow form=$form row="password"}

            <h3>{translate key="title.security"}</h3>
            {call formRow form=$form row="active"}
            {call formRow form=$form row="roles"}

            {call formRows form=$form}

            <div class="form__group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn--default" value="{translate key="button.save"}" />
                    {if $referer}
                        <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
                    {/if}
                </div>
            </div>
        </div>
    </form>
{/block}
