{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.tasks"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>
        {translate key="title.tasks"}
        <small>{$name}</small>
    </h1>
</div>
{/block}

{block name="content_body" append}
    <p
        class="task-progress"
        data-url-status="{url id="api.queue-jobs.detail" parameters=['id' => $queueJobStatus->getId()] query=['fields' => ['queue-jobs' => 'status']]}"
        data-url-finish="{url id="admin.task.finish" parameters=['task' => $taskId, 'job' => $queueJobStatus->getId()]}"
        data-sleep="3"
        data-finish="{"label.task.finish.description"|translate}"
    >
        {translate key="label.task.progress.description"}
    </p>
    <div class="spinner spinner-sml"></div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/tasks.js"></script>
{/block}
