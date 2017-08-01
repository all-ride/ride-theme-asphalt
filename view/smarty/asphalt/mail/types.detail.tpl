{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.mail.types"} | {/block}

{block name="content_title"}
    <div class="page-header mb-3">
        <h1>
            {translate key="title.mail.types"}
            <small class="text-muted">{$mailType->getName()}</small>
        </h1>
    </div>
{/block}

{block name="content_body" append}
    <h2>{translate key="title.variables.available"}</h2>
    <table>
    {foreach $mailType->getContentVariables() as $key => $translation}
        <tr>
            <td>{$key}</td>
            <td>{$translation|translate}</td>
        </tr>
    {/foreach}
    </table>

    <h2>{translate key="title.recipients.available"}</h2>
    <table>
    {foreach $mailType->getRecipientVariables() as $key => $translation}
        <tr>
            <td>{$key}</td>
            <td>{$translation|translate}</td>
        </tr>
    {/foreach}
    </table>
{/block}
