{extends file="base/index"}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.taxonomy"} <small>{translate key="title.terms"}</small></h1>
</div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__group">
                <div class="grid--bp-med__offset-2 grid--bp-med__10">
                    <input type="submit" class="btn btn--default" value="{translate key="button.save"}" />
                    {if $referer}
                        <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
                    {/if}
                </div>
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/form.js"></script>
{/block}
