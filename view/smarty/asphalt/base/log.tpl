{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.log"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.log"}</h1>
    </div>
{/block}

{block name="content" append}
    <table class="table table--striped table--log">
    {foreach $logSessions as $logSession}
    <tr>
        <td><a href="{url id="system.log.detail" parameters=["id" => $logSession->getId()]}">{$logSession->getId()}</a></td>
        <td>{$logSession->getClient()}</td>
        <td>{$logSession->getDate()|date_format:"%Y-%m-%d %H:%M:%S"}</td>
        <td>{$logSession->getMicroTime()}</td>
        <td>{$logSession->getTitle()}</td>
    </tr>
    {/foreach}
    </table>

    {if $pagination->getPages() > 1}
    <div class="text--center">
        {pagination page=$pagination->getPage() pages=$pagination->getPages() href=$pagination->getHref()}
    </div>
    {/if}
{/block}
