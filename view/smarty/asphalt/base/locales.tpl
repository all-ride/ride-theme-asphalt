{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.locales"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.locales"}</h1>
    </div>
{/block}

{block name="content" append}
    <p>{translate key="label.locales.information"}</p>

    <div class="locales" data-url-order="{url id="system.locales.order"}">
    {foreach $locales as $locale}
        {$code = $locale->getCode()}
        {$properties = $locale->getProperties()}

        <div class="locale locale-{$code}" id="locales-{$code}">
            <h3>{translate key="language.`$code`"}</h3>
            <dl>
                <dt>{translate key="label.name.native"}</dt>
                <dd>{$locale->getName()}</dd>
                <dt>{translate key="label.code"}</dt>
                <dd>{$code}</dd>
            </dl>
            <div class="btn-group">
                <a class="btn btn--default" href="{url id="system.translations.locale" parameters=["locale" => $code]}?referer={$app.url.request}">{translate key="button.translations.manage"}</a>
            {if $properties}
                <a class="btn btn--default btn-toggle-properties" href="#" class="btn-toggle-properties" data-target=".locale-{$code} .properties">{translate key="button.properties.toggle"}</a>
            {/if}
            </div>

            {if $properties}
            <div class="properties">
                <h4>{translate key="title.properties"}</h4>
                <table class="table">
                    {foreach $properties as $key => $value}
                    <tr>
                        <th>{$key}</th>
                        <td>{$value}</td>
                    </tr>
                    {/foreach}
                </table>
            </div>
            {/if}
        </div>
        {if !$locale@last}
            <hr />
        {/if}
    {/foreach}
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/locales.js"></script>
{/block}
