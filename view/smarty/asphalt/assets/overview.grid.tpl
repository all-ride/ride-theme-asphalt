<div class="grid grid--2-col grid--bp-xsm-4-col grid--bp-sml-8-col asset-items-folders" data-order="true">
    {if $folders}
        {foreach $folders as $item}
            <div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">

                <div class="preview preview--folder">
                    {if !$embed}
                        <label class="preview__checkbox checkbox">
                            <input type="checkbox" name="folders[]" value="{$item->getId()}" />
                        </label>
                    {/if}
                    <div class="preview__image-container">
                        <div class="preview__image">
                            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}&page=&selected={$app.request->getQueryParameter('selected')}">
                                <img src="{$app.url.base}/asphalt/img/folder.svg" width="160" height="125" class="image image--full-width" />
                            </a>
                        </div>
                    </div>
                    <div class="preview__name-container">
                        <div class="preview__handle option{if !$isFiltered} order-handle{/if}">
                            <i class="icon icon--arrows"></i>
                        </div>
                        {if $embed}
                            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}&selected={$app.request->getQueryParameter('selected')}" class="preview__name" title="{$item->getName()}">
                                {$item->getName()}
                            </a>
                        {else}
                            <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}" class="preview__name" title="{$item->getName()}">
                                {$item->getName()}
                            </a>
                        {/if}
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
            <div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">

                {$selected = in_array($item->getId(), $selectedAssets)}
                <div class="preview preview--asset{if $embed} is-addable{/if}{if $selected} is-selected{/if}">
                    {if !$embed}
                        <label class="preview__checkbox checkbox">
                            <input type="checkbox" name="assets[]" value="{$item->getId()}" />
                        </label>
                    {/if}
                    <div class="preview__image-container">
                        <div class="preview__image">
                            {if $item->getThumbnail()}
                                {$imgSource = $item->getThumbnail()}
                            {elseif !$item->getThumbnail() && $item->getType() == 'audio'}
                                {$imgSource = "asphalt/img/audio.svg"}
                            {elseif !$item->getThumbnail() && $item->getMime() == 'application/pdf'}
                                {$imgSource = "asphalt/img/pdf.svg"}
                            {elseif !$item->getThumbnail() && substr_count($item->getMime(), 'application') > 0}
                                {$imgSource = "asphalt/img/document.svg"}
                            {else}
                                {$imgSource = "asphalt/img/unknown.png"}
                            {/if}
                            <img src="{image src=$imgSource width=160 height=125 transformation="crop"}" class="image image--full-width" title="{$item->getName()}" />
                        </div>
                    </div>
                    <div class="preview__name-container">
                        <div class="preview__handle option{if !$isFiltered} order-handle{/if}">
                            <i class="icon icon--arrows"></i>
                        </div>
                        {if $embed}
                            <span class="preview__name">{$item->getName()}</span>
                        {else}
                            <a href="{url id="assets.asset.edit" parameters=["locale" => $locale, "asset" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}" class="preview__name">
                                {$item->getName()}
                            </a>
                        {/if}
                    </div>
                </div>

            </div>
        {/foreach}
    {/if}
</div>
