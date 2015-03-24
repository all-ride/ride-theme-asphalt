{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.security"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.security"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <p>{translate key="label.path.security.description"}</p>

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            <h3>{$form->getRow('secured-paths')->getLabel()}</h3>

            {call formWidget form=$form row="secured-paths"}

            {if $form->hasRow('allowed-paths')}
                <h3>{$form->getRow('allowed-paths')->getLabel()}</h3>
                <ul>
                {foreach $roles as $role}
                    <li class="role role-{$role->getId()}">
                        <a href="#">{$role->getName()}</a>
                        {call formWidget form=$form row="allowed-paths" part=$role->getId()}
                    </li>
                {/foreach}
                </ul>
            {/if}

            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/security.js"></script>
{/block}
