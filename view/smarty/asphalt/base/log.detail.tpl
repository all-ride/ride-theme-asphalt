{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.log"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.log"}</h1>
    </div>
{/block}

{block name="content" append}
    {function name="logTable" id=null messages=null active=false}
        {if $messages}
        <div id="tab{$id}" class="tabs__pane{if $active} active{/if}">
            <table class="table table--striped">
            {foreach $messages as $message}
                {call logTableRow message=$message}
            {/foreach}
            </table>
        </div>
        {/if}
    {/function}

    {function name="logTableRow" message=null}
        <tr{if $message->isError()} class="danger"{/if}>
            <td>{$message->getMicroTime()}</td>
            <td>{$message->getSource()}</td>
            <td>{$message->getTitle()}
                <br>
                <span class="text-muted">{$message->getDescription()|nl2br}</span>
            </td>
        </tr>
    {/function}

    <dl class="dl--horizontal">
        <dt>{translate key="label.id"}</dt>
        <dd>{$logSession->getId()}</dd>
        <dt>{translate key="label.date"}</dt>
        <dd>{$logSession->getDate()}</dd>
        <dt>{translate key="label.duration"}</dt>
        <dd>{$logSession->getMicroTime()}</dd>
        <dt>{translate key="label.client"}</dt>
        <dd>{$logSession->getClient()}</dd>
    </dl>

    <div class="tabbable">
        <ul class="tabs">
            <li class="tabs__tab {if !$response && !$request && !$session} active{/if}"><a href="#tabAll" data-toggle="tab">{translate key="title.all"}</a></li>
        {if $application}
            <li class="tabs__tab"><a href="#tabApplication" data-toggle="tab">{translate key="title.application"}</a></li>
        {/if}
        {if $database}
            <li class="tabs__tab"><a href="#tabDatabase" data-toggle="tab">{translate key="title.database"}</a></li>
        {/if}
        {if $mail}
            <li class="tabs__tab"><a href="#tabMail" data-toggle="tab">{translate key="title.mail"}</a></li>
        {/if}
        {if $response || $request || $session}
            <li class="tabs__tab active"><a href="#tabHttp" data-toggle="tab">{translate key="title.http"}</a></li>
        {/if}
        {if $i18n}
            <li class="tabs__tab"><a href="#tabI18n" data-toggle="tab">I18n</a></li>
        {/if}
        {if $security}
            <li class="tabs__tab"><a href="#tabSecurity" data-toggle="tab">{translate key="title.security"}</a></li>
        {/if}
        </ul>
    </div>

    <div class="tabs__content">
        {call logTable id="All" messages=$logSession->getLogMessages() active=(!$response && !$request && !$session)}

        {call logTable id="Mail" messages=$mail}

        {call logTable id="Application" messages=$application}

        {call logTable id="Database" messages=$database}

        {call logTable id="Security" messages=$security}

        {call logTable id="I18n" messages=$i18n}

        {if $response || $request || $session}
            <div id="tabHttp" class="tabs__pane active">
            {if $response}
                <h4>{translate key="title.response"} <small><span class="label label-{if $response.status < 300}success{elseif $response.status < 400}warning{else}danger{/if}">{$response.status} {$response.statusPhrase}</span></small></h4>
                <table class="table table-striped table-condensed">
                {foreach $response.headers as $header}
                <tr>
                    <td>{$header.name}</td>
                    <td>{$header.value}</td>
                </tr>
                {/foreach}
                </table>
            {/if}

            {if $request}
                <h4>{translate key="title.request"} <small>{$request.method} {$request.path}</small></h4>
                <table class="table table-striped table-condensed">
                {foreach $request.headers as $header}
                <tr>
                    <td>{$header.name}</td>
                    <td>{$header.value}</td>
                </tr>
                {/foreach}
                </table>
            {/if}

            {if $response}
                <h4>{translate key="title.session"} <small>{$session.id}</small></h4>
                <table class="table table-striped table-condensed">
                    {foreach $session.variables as $variable => $value}
                    <tr>
                        <td>{$variable}</td>
                        <td>{$value|nl2br}</td>
                    </tr>
                    {/foreach}
                </table>
            {/if}
            </div>
        {/if}
    </div>

{/block}
