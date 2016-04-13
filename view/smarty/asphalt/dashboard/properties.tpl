{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.widget.properties" widget=$widgetName} - {translate key="title.dashboard"} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{translate key="title.widget.properties" widget=$widgetName}</h1>
    </div>
{/block}

{block name="content_body" append}
    {include file=$propertiesTemplate inline}
{/block}
