{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.login"} - {/block}

{block name="content"}
    <div class="grid--bp-med__offset-4 grid--bp-med__4 block login">
        <div class="page-header">
            <h1 class="heading--alt">{translate key="title.login"}</h1>
        </div>

        {$smarty.block.parent}

        {include file="base/form.prototype"}

        <form id="{$form->getId()}" class="form" action="{url id="login"}{if $referer}?referer={$referer|urlencode}{/if}" method="POST" role="form">
            <div class="form__group">
                {$errors = $form->getValidationErrors('username')}


                <div class="form__item">
                    {call formRow form=$form row="username"}
                </div>
                <div class="form__item {if $errors} has-error{/if}">
                    <div class="col-lg-12">
                        {$row = $form->getRow('password')}
                        <label class="form__label" for="form-login-password">{$row->getLabel()}</label>
                        {call formWidget form=$form row="password"}
                        <div class="form__help">
                            <a href="{url id="profile.password.request"}">{translate key="button.password.reset"}</a>
                        </div>
                    </div>
                </div>
                {call formRows form=$form}
                <div class="form__actions">
                    <button type="submit" class="btn btn--brand btn--large">{translate key="button.login"}</button>
                    {if $urls}
                        <div class="login__or"><span>{translate key="label.or"}</span></div>
                        <ul class="list--unstyled">
                            {foreach $urls as $service => $url}
                                <li><a href="{$url}" class="btn">{translate key="button.login.`$service`"}</a></li>
                            {/foreach}
                        </ul>
                    {/if}
                </div>
            </div>
        </form>

    </div>
{/block}

{block name="scripts" append}
    <script type="application/javascript">$(function() { $('#form-username').focus(); });</script>
{/block}
