<div class="grid grid--bp-med-6-col" data-order="true">
{foreach $items as $item}
<div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">
    {if $item->getType() == 'folder'}
        <div class="image">
            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}">
                <img src="{$app.url.base}/bootstrap/img/folder.svg" width="200" height="200" class="data img-responsive" />
            </a>
        </div>
        <div class="name">
            <div class="option order-handle">
                <input type="checkbox" name="folders[]" value="{$item->getId()}" />
            </div>
            <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?referer={$app.url.request|urlencode}">
                {$item->getName()}
            </a>
        </div>
    {else}
        <div class="image">
        {if $item->getThumbnail()}
            <img src="{image src=$item->getThumbnail() width=200 height=200 transformation="crop"}" class="data image image--responsive" />
        {/if}
        </div>
        <div class="name">
            <div class="option order-handle">
                <input type="checkbox" name="assets[]" value="{$item->getId()}" />
            </div>
            <a href="{url id="assets.asset.edit" parameters=["locale" => $locale, "asset" => $item->getId()]}?referer={$app.url.request|urlencode}">
                {$item->getName()}
            </a>
        </div>
    {/if}
</div>
{/foreach}
</div>
