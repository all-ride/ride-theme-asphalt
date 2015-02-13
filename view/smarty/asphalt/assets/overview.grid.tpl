<div class="grid grid--bp-xsm-3-col grid--bp-sml-6-col" data-order="true">
{foreach $items as $item}
<div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">
    {if $item->getType() == 'folder'}
        <div class="preview preview--folder">
            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}">
                <img src="{$app.url.base}/asphalt/img/folder.svg" width="200" height="200" class="data image image--responsive" />
            </a>
        </div>
        {if !$embed}
            <label class="checkbox">
                <input type="checkbox" name="assets[]" value="{$item->getId()}" />
            </label>
        {/if}
        <div class="name">
            {if $embed}
                <span class="option{if !$flatten} order-handle{/if}">
                    <i class="icon icon--arrows"></i>
                </span>
                <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?referer={$app.url.request|urlencode}">
                    {$item->getName()}
                </a>
            {else}
                <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?referer={$app.url.request|urlencode}">
                    {$item->getName()}
                </a>
            {/if}
        </div>
    {else}
        <div class="preview{if $embed} is-addable{/if}">
        {if $item->getThumbnail()}
            <img src="{image src=$item->getThumbnail() width=200 height=200 transformation="crop"}" class="data image image--responsive" />
        {/if}
        </div>
        {if !$embed}
            <label class="checkbox">
                <input type="checkbox" name="assets[]" value="{$item->getId()}" />
            </label>
        {/if}
        <div class="name">
            {if $embed}
                <span class="option{if !$flatten} order-handle{/if}">
                    <i class="icon icon--arrows"></i>
                </span>
                <span>{$item->getName()}</span>
            {else}
                <span class="option{if !$flatten} order-handle{/if}">
                    <i class="icon icon--arrows"></i>
                </span>
                <a href="{url id="assets.asset.edit" parameters=["locale" => $locale, "asset" => $item->getId()]}?referer={$app.url.request|urlencode}">
                    {$item->getName()}
                </a>
            {/if}
        </div>
    {/if}
</div>
{/foreach}
</div>
