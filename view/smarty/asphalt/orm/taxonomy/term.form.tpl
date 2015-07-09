{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $term->getId()}
        {url id="taxonomy.term.edit" parameters=["vocabulary" => $vocabulary->getId(), "locale" => "%locale%", "term" => $term->getId()] var="localizeUrl"}
    {else}
        {url id="taxonomy.term.add" parameters=["vocabulary" => $vocabulary->getId(), "locale" => "%locale%"] var="localizeUrl"}
    {/if}
    {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
{/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.taxonomy"} <small>{translate key="title.terms"}</small></h1>
</div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal form--selectize" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__actions">
                <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
                <button name="submit" value="new" type="submit" class="btn btn--link" action="{$app.url.request}"><span>{translate key="label.term.next"}</span></button>
                {if $referer}
                    <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
{/block}
