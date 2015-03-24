{extends file="base/index"}

{block name="head_title" prepend}{if $asset->getId()}{$asset->getName()}{else}{translate key="button.add.asset"}{/if} - {translate key="title.assets"} - {/block}

{block name="taskbar"}{if !$embed}{$smarty.block.parent}{/if}{/block}

{block name="taskbar_panels" append}
    {if $asset->getId()}
        {url id="assets.asset.edit" parameters=["locale" => "%locale%", "asset" => $asset->getId()] var="url"}
    {else}
        {url id="assets.asset.add" parameters=["locale" => "%locale%"] var="url"}
        {if $folder && $folder->getId()}
            {$folderId = $folder->getId()}
            {$url = "`$url`?folder=`$folderId`"}
        {/if}
    {/if}

    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        {if $asset->getId()}
            <h1>{translate key="title.assets"} <small>{$asset->getName()}</small></h1>
        {else}
            <h1>{translate key="title.assets"} <small>{translate key="button.add.asset"}</small></h1>
        {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}
    <div class="grid">
        <div class="grid__item grid--bp-med__{if $asset->getId()}6{else}12{/if}">
            <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
                <div class="form__group">
                    {call formRows form=$form}

                    <div class="form__actions">
                        <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
                        {if $referer}
                            <a href="{$referer}" class="btn btn--link">{translate key="button.cancel"}</a>
                        {/if}
                    </div>
                </div>
            </form>
        </div>
        {if $asset->getId()}
        <div class="grid__item grid--bp-med__6">
            <dl>
                <dt>{translate key="label.url"}</dt>
                <dd>
                    {url id="assets.value" parameters=["asset" => $asset->getId()] var="valueUrl"}
                    <a href="{$valueUrl}">{$valueUrl}</a>
                </dd>
                <dt>{translate key="label.type"}</dt>
                <dd>{$asset->getType()}</dd>
                {if $dimension}
                    <dt>{translate key="label.dimension"}</dt>
                    <dd>{$dimension->getWidth()} x {$dimension->getHeight()}</dd>
                {/if}
                <dt>{translate key="label.date.added"}<dt>
                <dd>{$asset->getDateAdded()|date_format : "%d-%m-%Y %T"}</dd>
                <dt>{translate key="label.date.modified"}</dt>
                <dd>{$asset->getDateModified()|date_format : "%d-%m-%Y %T"}</dd>
            </dl>

            {if $media}
                <iframe width="560" height="315" src="{$media->getEmbedUrl()}" frameborder="0" allowfullscreen></iframe>
            {else}
                <img class="img-responsive" src="{image src=$asset->getThumbnail() default="img/.png"}"/>
            {/if}
        </div>
        {/if}
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
{/block}
