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
            <div class="grid__12 grid--bp-med__6">
                <div class="form__group">
                    {call formRow form=$form row='asset'}
                </div>
                <div class="form__actions">
                    <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
                    {if $referer}
                        <a href="{$referer}" class="btn btn--link">{translate key="button.cancel"}</a>
                    {/if}
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
                                {$file = $asset->getValue()|decorate:'file'}
                                {if $file !== $asset->getValue()}
                                    <dt>{translate key="label.size"}</dt>
                                    <dd>{$file->getSize()|decorate:"storage.size"}</dd>
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
                            {$transformations = $style->getTransformations()}

                            <div id="tab-{$style->getSlug()}" class="tabs__pane assets__image-styles js-image-style">
                                {if $transformations}
                                    <div class="spacer--med">
                                        {translate key="label.image.style.transformations.applied"}:
                                        <ul>
                                        {foreach $transformations as $transformation}
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
                                    </div>
                                {/if}

                                <div class="spacer--med form__group asset__crop js-image-style-crop" data-asset="{$asset->getId()}" data-style="{$style->getId()}"{if $cropRatio} data-ratio="{$cropRatio['width'] / $cropRatio['height']}"{/if}>
                                    <h4>{translate key="label.image.style.crop"}</h4>
                                    <a href="#" class="js-crop-toggle spacer">{translate key="button.crop.image"}</a>
                                    <div class="js-crop-image superhidden">
                                        <div class="spacer">
                                            {* Use a scaled image to 2500px width for performance... *}
                                            <img class="img-responsive js-enable-cropper" src="{image src=$asset->getImage() width=2500 transformation='resize'}" />
                                        </div>
                                        <div class="spacer">
                                            <a href="#" class="btn js-crop-save">{translate key="button.crop.save"}</a> <span class="form__help">{translate key="label.crop.save.warning"}</span>
                                        </div>
                                    </div>
                                    <div class="loading tree-spinner"></div>
                                </div>

                                <div class="spacer--med form__group js-image-style-file">
                                    <h4>{translate key="label.image.style.upload"}</h4>
                                    {call formWidget form=$form row="style-`$style->slug`"}
                                    {call formWidgetErrors form=$form row="style-`$style->slug`"}
                                </div>

                                <div class="superhidden js-crop-preview spacer"></div>
                            </div>
                        {/foreach}
                    </div>
                </div>

            </div>
            {/if}

            {call formRows form=$form}
        </div>
    </form>
    <script type="text/template" id="form-image-preview-template">
        <div class="form__image-preview">
            <img src="<%- dataUrl %>" width="100"><br>
            <a href="#" class="js-file-delete" data-id="<%- id %>" data-message="{translate key="label.confirm.file.delete"}">
                <i class="glyphicon glyphicon-remove"></i>
                {translate key="button.delete"}
            </a>
        </div>
    </script>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
{/block}
