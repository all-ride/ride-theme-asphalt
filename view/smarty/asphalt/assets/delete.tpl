{extends file="base/index"}

{block name="head_title" prepend}{$name} - {translate key="button.delete"} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{translate key="button.delete"} <small>{$name}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form action="{$app.url.request}" method="POST" role="form">
        <div class="form__item">
            <p>{translate key="label.confirm.asset.delete" name=$name}</p>
        </div>

        <div class="form__actions">
            <button type="submit" class="btn btn--danger">{translate key="button.delete"}</button>
            {if $referer}
                <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
            {/if}
        </div>
    </form>
{/block}
