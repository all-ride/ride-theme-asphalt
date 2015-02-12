{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.log"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.log"}</h1>
    </div>
{/block}

{block name="content" append}
    <table class="table table-responsive table-striped table-log">
    {foreach $logRequests as $logRequest}
    <tr>
        <td>{$logRequest->getId()}</td>
        <td>{$logRequest->getClient()}</td>
        <td>{$logRequest->getDate()|date_format:"%Y-%m-%d %H:%M:%S"}</td>
        <td>{$logRequest->getMicroTime()}</td>
        <td>{$logRequest->getTitle()}</td>
        <td><a class="btn btn-default" href="#">Toggle details</a></td>
    </tr>
    <tr class="superhidden">
        <td colspan="6">
            <ul>
            {foreach $logRequest->getLogMessages() as $logMessage}
                <li>
                    <strong>{$logMessage->getTitle()}</strong><br>
                    {$logMessage->getDescription()}
                </li>
            {/foreach}
            </ul>
        </td>
    </tr>
    {/foreach}
    </table>
{/block}

{block name="scripts_app" append}
    <script type="text/javascript">
        $(function() {
            $('.table-log .btn').on('click', function(e) {
                e.preventDefault();

                $(this).parents('tr').next().toggleClass('superhidden');
            });
        });
    </script>
{/block}
