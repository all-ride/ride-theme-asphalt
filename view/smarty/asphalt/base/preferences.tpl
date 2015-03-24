{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.preferences"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.preferences"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
            </div>
        </div>
    </form>
{/block}
