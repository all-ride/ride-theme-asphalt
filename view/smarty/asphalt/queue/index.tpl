{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.queue"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.queue"}</h1>
</div>
{/block}

{block name="content_body" append}
    {if $status}
    <table class="table">
        <tbody>
    {foreach $status as $queue => $numJobs}
            <tr>
                <td>
                    <a href="{url id="queue.status" parameters=["queue" => $queue]}">{$queue}</a>
                    <div class="info">
                        {$numJobs} {if $numJobs == 1}{translate key="label.job"}{else}{translate key="label.jobs"}{/if}
                    </div>
                </td>
            </tr>
    {/foreach}
        </tbody>
    </table>
    {/if}
{/block}
