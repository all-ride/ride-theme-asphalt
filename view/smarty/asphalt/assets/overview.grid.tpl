{$selectedParameter = $app.request->getQueryParameter('selected')}
{$referer = $app.url.request|urlencode}

<div class="grid grid--2-col grid--bp-xsm-4-col grid--bp-sml-8-col asset-items-folders" data-order="true">
    {if $folders}
        {foreach $folders as $item}
            {$editUrlRoot = {url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}}
            {$editUrl = "`$editUrlRoot`?embed=`$embed`&referer=`$referer`"}
            {$detailUrlRoot = {url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}}
            {$detailUrl = "`$detailUrlRoot``$urlSuffix`&selected=`$selectedParameter`"}

            <div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">
                <div class="preview preview--folder">
                    {if !$embed}
                        <label class="preview__checkbox checkbox">
                            <input type="checkbox" name="folders[]" value="{$item->getId()}" />
                        </label>
                    {/if}
                    <div class="preview__image-container">
                        <a href="{$editUrl}" style="position: absolute; z-index: 10; top:2px; right:5px; font-size:1.3em;">
                            <i class="icon icon--pencil"></i>
                        </a>
                        <div class="preview__image">
                            <a href="{$detailUrl}">
                                <img src="{$app.url.base}/asphalt/img/folder.svg" width="160" height="125" class="image image--full-width" />
                            </a>
                        </div>
                    </div>
                    <div class="preview__name-container">
                        <div class="preview__handle option{if !$isFiltered} order-handle{/if}">
                            <i class="icon icon--arrows"></i>
                        </div>
                        <a href="{$detailUrl}" class="preview__name" title="{$item->getName()}">
                            {$item->getName()}
                        </a>
                    </div>
                </div>
            </div>
        {/foreach}
    {/if}
</div>
<div class="gridOverview grid grid--2-col grid--bp-xsm-4-col grid--bp-sml-8-col asset-items-assets" data-order="true">
    {if $assets}
        {$selectedAssets = explode(',', $app.request->getQueryParameter('selected'))}
        {foreach $assets as $item}
            {$editUrlRoot = {url id="assets.asset.edit" parameters=["locale" => $locale, "asset" => $item->getId()]}}
            {$editUrlSuffix = "embed=`$embed`&referer=`$referer`"}
            {$editUrl = "$editUrlRoot?$editUrlSuffix"}

            <div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">

                {$selected = in_array($item->getId(), $selectedAssets)}
                <div class="preview preview--asset{if $embed} is-addable{/if}{if $selected} is-selected{/if}">
                    {if !$embed}
                        <label class="preview__checkbox checkbox">
                            <input type="checkbox" name="assets[]" value="{$item->getId()}" />
                        </label>
                    {/if}
                    <div class="preview__image-container">
                        <a href="{$editUrl}" style="position: absolute; z-index: 10; top:2px; right:5px; font-size:1.3em;">
                            <i class="icon icon--pencil"></i>
                        </a>
                        <div class="preview__image">
                            {if $item->getThumbnail()}
                                <img src="{image src=$item->getThumbnail() width=160 height=125 transformation='crop'}" alt="" class="image image--full-width" title="{$item->getName()}"/>
                            {else}
                                {$imgSource = "asphalt/img/preview/`$item->getType()`.png"}
                                <img src="{image src=$imgSource}" alt="" class="image" title="{$item->getName()}"/>
                            {/if}
                        </div>
                    </div>
                    <div class="preview__name-container">
                        <div class="preview__handle option{if !$isFiltered} order-handle{/if}">
                            <i class="icon icon--arrows"></i>
                        </div>
                        {if $embed}
                            <span class="preview__name">{$item->getName()}</span>
                        {else}
                            <a href="{$editUrl}" class="preview__name">
                                {$item->getName()}
                            </a>
                        {/if}
                    </div>
                </div>

            </div>
        {/foreach}
    {/if}
</div>
