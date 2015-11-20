{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.security"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.security"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}
    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        <div class="tabbable">
            <ul class="tabs">
                <li class="tabs__tab active">
                    <a href="#tabpaths" data-toggle="tab">{translate key="label.paths"}</a>
                </li>
                {if $permissions && $roles}
                <li class="tabs__tab">
                    <a href="#tabpermissions" data-toggle="tab">{translate key="label.permissions"}</a>
                </li>
                {/if}
            </ul>
            <div class="tabs__content">
                <div id="tabpaths" class="tabs__pane active">
                    <p>{$form->getRow('secured-paths')->getDescription()}</p>
                    {call formWidget form=$form row="secured-paths"}
                    <div class="form__help">{translate key="label.path.security.description"}</div>
                    
                    {if $form->hasRow('allowed-paths')}
                        <h3>{$form->getRow('allowed-paths')->getLabel()}</h3>
                        <p>{$form->getRow('allowed-paths')->getDescription()}</p>
                        
                        <ul>
                        {foreach $roles as $role}
                            <li class="role role-{$role->getId()}">
                                <a href="#">{$role->getName()}</a>
                                {call formWidget form=$form row="allowed-paths" part=$role->getId()}
                            </li>
                        {/foreach}
                        </ul>
                    {/if}
                </div>
                {if $permissions && $roles}
                <div id="tabpermissions" class="tabs__pane">
                    <p>{translate key="label.permissions.description"}</p>
                    <table class="table">
                        <tr>
                            <th></th>
                    {foreach $roles as $role}
                            <th>{$role->getName()}</th>
                    {/foreach}
                        </tr>
                    {foreach $permissions as $permission}
                        <tr>
                            <th>{translate key="`$permission`"}<br/><small>{$permission}</small></th>
                            {foreach $roles as $role}
                                <td>{call formWidget form=$form row="role_`$role->getId()`" part=$permission->getCode()}</td>
                            {/foreach}
                        </tr>
                    {/foreach}
                    </table>
                </div>
                {/if}
            </div>
        </div>

        <div class="form__group">
            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
                <a href="{url id="system.security.user"}">{translate key="button.users.manage"}</a>
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/security.js"></script>
{/block}
