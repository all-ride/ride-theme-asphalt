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

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">

        <div class="grid">
            <div class="grid__item grid--bp-med__{if $asset->getId()}6{else}12{/if}">
                <div class="form__group">
                    {call formRow form=$form row="asset"}

                    <div class="form__actions">
                        <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
                        {if $referer}
                            <a href="{$referer}" class="btn btn--link">{translate key="button.cancel"}</a>
                        {/if}
                    </div>
                </div>
            </div>
            {if $asset->getId()}
                <div class="grid__item grid--bp-med__6">
                   {* <dl>
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
                        <dt>{translate key="label.date.added"}</dt>
                        <dd>{$asset->getDateAdded()|date_format : "%d-%m-%Y %T"}</dd>
                        <dt>{translate key="label.date.modified"}</dt>
                        <dd>{$asset->getDateModified()|date_format : "%d-%m-%Y %T"}</dd>
                    </dl>*}

                  {*  {if $media}
                        <iframe width="560" height="315" src="{$media->getEmbedUrl()}" frameborder="0" allowfullscreen></iframe>
                    {elseif $asset->isImage()}
                        <img class="img-responsive" src="{image src=$asset->getValue()}" />
                    {else}
                        <img class="img-responsive" src="{image src=$asset->getThumbnail()}"/>
                    {/if}*}

                    <div class="tabbable">
                        <ul class="tabs">
                            <li class="tabs__tab active"><a href="#tab-original" data-toggle="tab">{translate key="label.original"}</a></li>
                            {foreach $styles as $style}
                                <li class="tabs__tab"><a href="#tab-{$style->getSlug()}" data-toggle="tab">{$style->getName()}</a></li>
                            {/foreach}
                        </ul>

                        <div class="tabs__content">
                            <div id="tab-original" class="tabs__pane active">
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
                                </dl>

                                {if $media}
                                    <iframe width="560" height="315" src="{$media->getEmbedUrl()}" frameborder="0" allowfullscreen></iframe>
                                {else}
                                    <img class="img-responsive" src="{image src=$asset->getImage()}" />
                                {/if}
                            </div>

                            {foreach $styles as $style}
                            {$cropRatio = null}
                            <div id="tab-{$style->getSlug()}" class="tabs__pane assets__image-styles">
                                <ul>
                                {foreach $style->getTransformations() as $transformation}
                                    <li>{$transformation->getName()}</li>
                                    {if $transformation->getTransformation() == 'crop'}
                                        {foreach $transformation->getOptions() as $option}
                                            {if $option->getKey() == 'width'}
                                                {$cropRatio['width'] = $option->getValue()}
                                            {/if}
                                            {if $option->getKey() == 'height'}
                                                {$cropRatio['height'] = $option->getValue()}
                                            {/if}
                                        {/foreach}
                                    {/if}
                                {/foreach}
                                </ul>

                                <div class="form__group">
                                    {call formWidget form=$form row="style-`$style->slug`"}
                                    {call formWidgetErrors form=$form row="style-`$style->slug`"}
                                </div>


                                <div class="form__group asset__crop" data-asset="{$asset->getId()}" data-style="{$style->getId()}"{if $cropRatio} data-ratio="{$cropRatio['width'] / $cropRatio['height']}"{/if}>
                                    <div class="superhidden js-crop-preview spacer"></div>
                                    <a href="#" class="js-crop-toggle spacer">{translate key="button.crop.image"}</a>
                                    <div class="js-crop-image superhidden">
                                        <div class="spacer">
                                            <img class="img-responsive js-enable-cropper" src="{image src=$asset->getImage()}" />
                                        </div>
                                        <div class="spacer">
                                            <a href="#" class="btn js-crop-save">{translate key="button.crop.save"}</a> <span class="form__help">{translate key="label.crop.save.warning"}</span>
                                        </div>
                                    </div>
                                    <div class="loading tree-spinner"></div>
                                </div>
                            </div>
                            {/foreach}
                        </div>
                    </div>


                </div>
            {/if}
        </div>
    </form>
    <script type="text/template" id="form-image-preview-template">
        <div class="form__image-preview">
            <img src="<%- dataUrl %>" width="100"><br>
            <a href="#" class="js-file-delete" data-id="<%- id %>" data-message="{translate key="label.confirm.file.delete"}">
                <i class="glyphicon glyphicon-remove"></i>
                {translate key="button.detele"}
            </a>
        </div>
    </script>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
{/block}
