{extends file="manual/index"}

{block name="title" prepend}{$title} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.manual"}{if !$isNew} <small>{$page->getTitle()}</small>{/if}</h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}?referer={$referer|urlencode}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
                <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
            </div>
        </div>
    </form>
{/block}
