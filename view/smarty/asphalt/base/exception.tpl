{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.exception"} | {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.exception"}</h1>
    </div>
{/block}

{block name="content" append}
    <p>{translate key="label.exception.report.description"}</p>

    {if $form}
        <p>{translate key="label.exception.report.form"}</p>
        {include file="base/form.prototype"}


        <form id="{$form->getId()}" class="form" action="{url id="system.exception" parameters=["id" => $id]}" method="POST" role="form">
            <div class="form__group">
                {call formRows form=$form}

                <div class="form__actions">
                    <button type="submit" class="btn btn--brand">{translate key="button.submit"}</button>
                    <a class="btn btn--link" href="{url id="system.parameters"}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </form>
    {/if}
{/block}
