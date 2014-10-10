{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.preferences"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.preferences"}</h1>
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
                </div>
            </div>
        </div>
    </form>
{/block}
