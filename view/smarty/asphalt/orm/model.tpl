{extends file="base/index"}

{block name="head_title" prepend}{$model->getName()} - {translate key="title.orm"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.orm"} <small>{$model->getName()}</small></h1>
</div>
{/block}

{block name="content_body" append}
    <dl>
        <dt>{translate key="label.class.model"}</dt>
        <dd>{if $hasApi}<a href="{url id="api.class"}/{$modelClass|replace:'\\':'/'}">{$modelClass}</a>{else}{$modelClass}{/if}</dd>
        <dt>{translate key="label.class.entry"}</dt>
        <dd>{if $hasApi}<a href="{url id="api.class"}/{$entryClass|replace:'\\':'/'}">{$entryClass}</a>{else}{$entryClass}{/if}</dd>
        <dt>{translate key="label.class.proxy"}</dt>
        <dd>{if $hasApi}<a href="{url id="api.class"}/{$proxyClass|replace:'\\':'/'}">{$proxyClass}</a>{else}{$proxyClass}{/if}</dd>
        <dt>{translate key="label.model.delete.block"}</dt>
        <dd>{if $modelTable->willBlockDeleteWhenUsed()}{"label.yes"|translate}{else}{"label.no"|translate}{/if}</dd>
    </dl>

    <h2>{"label.fields"|translate}</h4>
    {include file="base/table" table=$tableFields tableForm=$tableFieldsForm}

    <h2>{"label.formats"|translate}</h4>
    <table class="table table-condensed">
        <thead>
            <tr>
                <th>{translate key="label.name"}</th>
                <th>{translate key="label.format"}</th>
            </tr>
        </thead>
        <tbody>
            {$formats = $modelTable->getFormats()}
            {foreach $formats as $name => $format}
                <tr>
                    <td>{$name}</td>
                    <td>{$format}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>

    <h2>{"label.indexes"|translate}</h4>
    {if $modelTable->getIndexes()}
        {$tableIndexes->getHtml()}
    {else}
        <p>{"label.index.none"|translate}</p>
    {/if}

    <h2>{"label.options"|translate}</h4>
    <table class="table table-condensed">
        <thead>
            <tr>
                <th>{translate key="label.name"}</th>
                <th>{translate key="label.value"}</th>
            </tr>
        </thead>
        <tbody>
            {$options = $modelTable->getOptions()}
            {foreach $options as $name => $value}
                <tr>
                    <td>{$name}</td>
                    <td>{$value|escape}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{/block}
