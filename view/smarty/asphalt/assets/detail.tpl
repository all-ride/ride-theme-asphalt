
<div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">
    <div class="preview preview--asset{if $embed} is-addable{/if}">
        {if !$embed}
            <label class="preview__checkbox checkbox">
                <input type="checkbox" name="assets[]" value="{$item->getId()}" />
            </label>
        {/if}
        <div class="preivew__image-container">
            <div class="preview__image">
                {if $item->getThumbnail()}
                    <img src="{image src=$item->getThumbnail() width=160 height=125 transformation="crop"}" class="image" />
                {/if}
            </div>
        </div>
        <div class="preview__name-container">
            <div class="preview__handle option order-handle">
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
