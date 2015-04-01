
<div class="grid grid--2-col grid--bp-xsm-4-col grid--bp-sml-8-col" data-order="true">
    {foreach $items as $item}
        <div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">

            {if $item->getType() == 'folder'}
                <div class="preview preview--folder">
                    {if !$embed}
                        <label class="preview__checkbox checkbox">
                            <input type="checkbox" name="assets[]" value="{$item->getId()}" />
                        </label>
                    {/if}
                    <div class="preivew__image-container">
                        <div class="preview__image">
                            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}&selected={$app.request->getQueryParameter('selected')}">
                                <img src="{$app.url.base}/asphalt/img/folder.svg" width="160" height="125" class="image image--full-width" />
                            </a>
                        </div>
                    </div>
                    <div class="preview__name-container">
                        <div class="preview__handle option{if !$flatten} order-handle{/if}">
                            <i class="icon icon--arrows"></i>
                        </div>
                        {if $embed}
                            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}&selected={$app.request->getQueryParameter('selected')}" class="preview__name">
                                {$item->getName()}
                            </a>
                        {else}
                            <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}" class="preview__name">
                                {$item->getName()}
                            </a>
                        {/if}
                    </div>
                </div>
            {else}
                {$selected = ($app.request->getQueryParameter('selected') && strpos($app.request->getQueryParameter('selected'), $item->getId()) !== false)}
                <div class="preview preview--asset{if $embed} is-addable{/if}{if $selected} is-selected{/if}">
                    {if !$embed}
                        <label class="preview__checkbox checkbox">
                            <input type="checkbox" name="assets[]" value="{$item->getId()}" />
                        </label>
                    {/if}
                    <div class="preivew__image-container">
                        <div class="preview__image">
                            {if $item->getThumbnail()}
                                <img src="{image src=$item->getThumbnail() width=160 height=125 transformation="crop"}" class="image image--full-width" />
                            {/if}
                        </div>
                    </div>
                    <div class="preview__name-container">
                        <div class="preview__handle option{if !$flatten} order-handle{/if}">
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
            {/if}

        </div>
    {/foreach}
</div>
