{extends file="manual/index"}

{block name="title" prepend}{$title} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.manual"}{if !$isNew} <small>{$page->getTitle()}</small>{/if}</h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-vertical" action="{$app.url.request}?referer={$referer|urlencode}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn--default" value="{translate key="button.save"}" />
                    <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </div>
    </form>
{/block}
