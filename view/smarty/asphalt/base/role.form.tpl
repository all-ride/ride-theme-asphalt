{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.roles"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.roles"}{if $role->getId()} <small>{$role->getName()}</small>{/if}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
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
