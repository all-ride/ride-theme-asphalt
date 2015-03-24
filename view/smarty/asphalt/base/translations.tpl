{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.translations"} - {/block}

{block name="taskbar_panels" append}
    {url id="system.translations.locale" parameters=["locale" => "%locale%"] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
    {call taskbarPanelSearch url=$app.url.request method="GET" query=$query}
{/block}

{block name="content_title"}
    <div class="page-header">
        {if $query}
        <h1>
            {translate key="title.translations.query" query=$query|escape}
            <small>{translate key="language.`$locale`"}</small>
        </h1>
        {else}
        <h1>
            {translate key="title.translations"}
            <small>{translate key="language.`$locale`"}</small>
        </h1>
        {/if}
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.submit"}</button>
                {if $referer}
                    <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </div>
    </form>

    <table class="table table-responsive table-striped">
        <thead>
            <tr>
                <th>{translate key="label.key"}</th>
                <th>{translate key="label.translation"}</th>
            </tr>
        </thead>
        <tbody>
    {foreach $translations as $key => $value}
            <tr>
                <td><a href="{url id="system.translations.edit" parameters=["locale" => $locale, "key" => $key]}{if $referer}?referer={$referer|escape}{/if}">{$key}</a></td>
                <td>{$value|escape}</td>
            </tr>
    {/foreach}
        </tbody>
    </table>
{/block}
