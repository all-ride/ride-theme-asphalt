{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.password.reset"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.password.reset"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            <div class="grid">
                <div class="grid__12 grid--bp-sml__8">
                    {call formRows form=$form}
                </div>
            </div>

            {call formActions referer=$referer}
        </div>
    </form>
{/block}
