{extends file="base/index"}

{block name="head_title" prepend}{if $server}{$server}{else}{translate key="title.server.add"}{/if} - {translate key="title.varnish"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.varnish"} <small>{if $server}{$server}{else}{translate key="title.server.add"}{/if}</small></h1>
</div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
                <a class="btn btn--link" href="{url id="varnish"}">{translate key="button.cancel"}</a>
            </div>
        </fieldset>
    </form>
    {if $server}
        <hr />
        <form class="form" action="{url id="varnish.server.delete" parameters=["server" => (string) $server]}" method="POST" role="form">
            <div class="form__groep">
                <div class="form__actions">
                    <button type="submit" class="btn btn--danger">{translate key="button.delete"}</button>
                </div>
            </fieldset>
        </form>
    {/if}
{/block}
