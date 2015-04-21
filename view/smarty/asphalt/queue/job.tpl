{extends file="base/index"}

{block name="head_title" prepend}{$queue} - {translate key="title.queue"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.queue"} <small>{$queue}</small></h1>
</div>
{/block}

{block name="content_body" append}
    {$statusString = $status->getStatus()}
    <dl>
        <dt>{translate key="label.id"}</dt>
        <dd id="job-className">{$status->getId()}</dd>
        <dt>{translate key="label.class"}</dt>
        <dd id="job-className">{$status->getClassName()}</dd>
        <dt>{translate key="label.queue"}</dt>
        <dd id="job-queue"><a href="{url id="queue.status" parameters=["queue" => $status->getQueue()]}">{$status->getQueue()}</a></dd>
        <dt>{translate key="label.date"}</dt>
        <dd id="job-date">{$status->getDateAdded()|date_format:"Y-m-d H:i:s"}</dd>
        <dt>{translate key="label.status"}</dt>
        <dd id="job-status"><span class="label label-{if $statusString == 'error'}danger{elseif $statusString == 'progress'}warning{else}info{/if}">{$statusString}</span></dd>
        <dt>{translate key="label.slot"}</dt>
        <dd id="job-slot">{if $statusString == 'progress'}{$status->getSlot()}/{$status->getSlots()}{else}---{/if}</dd>
    </dl>
    <pre id="job-description">{$status->getDescription()}</pre>
{/block}

{block name="scripts_app" append}
    <script type="text/javascript">
        function updateQueueStatus(url, sleepTime) {
            $.get(url, function(data) {
                $('#job-description').html(data.description);

                var status = '<span class="label label-';
                if (data.status == 'error') {
                    status += 'danger'
                } else if (data.status == 'progress') {
                    status += 'warning'
                } else {
                    status += 'info'
                }
                status += '">' + data.status + '</span>';

                $('#job-status').html(status);
                if (data.status == 'waiting') {
                    $('#job-slot').html(data.slot + '/' + data.slots);
                } else {
                    $('#job-slot').html('---');
                }

                setTimeout(function() { updateQueueStatus(url, sleepTime)}, sleepTime * 1000);
            }).fail(function(data) {
                if (data.status == 404) {
                    data = JSON.parse(data.responseText);

                    $('#job-status').html('<span class="label label-success">' + data.status + '</span>');
                }
            });
        }

        $(function() {
            updateQueueStatus("{url id="api.queue.status.job" parameters=["queue" => $queue, "id" => $status->getId()]}", 3);
        });
    </script>
{/block}
