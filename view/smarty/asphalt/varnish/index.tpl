{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.varnish"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.varnish"}</h1>
</div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formWidget form=$form row="url"}
            <div class="form__item">
                <button type="submit" class="btn btn--default">{translate key="button.ban"}</button>
                <span class="checkbox">
                    <label title="{translate key="label.force.varnish"}">{call formWidget form=$form row="force"} {translate key="label.force"}</label>
                </span>
            </div>
            {call formRows form=$form}
        </div>
    </form>

    <hr />

    <h2>{translate key="title.servers"}</h2>

    {if $servers}
    <table class="table">
        <thead>
            <tr>
                <th>{translate key="label.server"}</th>
                <th>{translate key="label.status"}</th>
            </thead>
        <tbody>
    {foreach $servers as $server}
            <tr>
                <td><a href="{url id="varnish.server.edit" parameters=["server" => (string) $server]}">{$server}</a></td>
                <td>
                    {if $server->isRunning()}
                        <span class="label label-success">{translate key="label.running"}</span>
                    {elseif $server->isConnected()}
                        <span class="label label-warning">{translate key="label.running.not"}</span>
                    {else}
                        <span class="label label-danger">{translate key="label.connect.unable"}</span>
                    {/if}
                </td>
            </tr>
    {/foreach}
        </tbody>
    </table>
    {/if}

    <p><a href="{url id="varnish.server.add"}" class="btn btn--brand"><i class="icon icon--plus"></i> {translate key="button.add"}</a></p>
{/block}
