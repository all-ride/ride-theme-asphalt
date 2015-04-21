{extends file="base/index"}

{block name="head_title" prepend}{$queue} - {translate key="title.queue"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.queue"} <small>{$queue}</small></h1>
</div>
{/block}

{block name="content_body" append}
    {if $statuses}
    <table class="table">
        <tbody>
    {foreach $statuses as $status}
            <tr>
                <td>
                    <a href="{url id="queue.status.job" parameters=["queue" => $queue, "job" => $status->getId()]}">{$status->getClassName()} #{$status->getId()}</a>
                    {$status = $status->getStatus()}
                    <div class="info">
                        <span class="label label-{if $status == 'waiting'}info{elseif $status == 'progress'}warning{else}danger{/if}">{$status}</span>
                    </div>
                </td>
            </tr>
    {/foreach}
        </tbody>
    </table>
    {/if}
{/block}
