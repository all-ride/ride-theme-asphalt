
<div class="grid grid--2-col grid--bp-xsm-4-col grid--bp-sml-8-col" data-order="true">
{foreach $items as $item}
<div class="grid__item order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">
    {if $item->getType() == 'folder'}
        <div class="preview preview--folder">
            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}&assets={$app.request->getQueryParameter('assets')}">
                <img src="{$app.url.base}/asphalt/img/folder.svg" width="200" height="200" class="data image image--responsive" />
            </a>
        </div>
        {if !$embed}
            <label class="checkbox">
                <input type="checkbox" name="assets[]" value="{$item->getId()}" />
            </label>
        {/if}
        <div class="name">
            <span class="option{if !$flatten} order-handle{/if}">
                <i class="icon icon--arrows"></i>
            </span>
            {if $embed}
                <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}&assets={$app.request->getQueryParameter('assets')}">
                    {$item->getName()}
                </a>
            {else}
                <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}">
                    {$item->getName()}
                </a>
            {/if}
        </div>
    {else}
        {$selected = ($app.request->getQueryParameter('assets') && strpos($app.request->getQueryParameter('assets'), $item->getId()) !== false)}
        <div class="preview{if $embed} is-addable{/if}{if $selected} is-selected{/if}">
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
            <span class="option{if !$flatten} order-handle{/if}">
                <i class="icon icon--arrows"></i>
            </span>
            {if $embed}
                <span>{$item->getName()}</span>
            {else}
                <a href="{url id="assets.asset.edit" parameters=["locale" => $locale, "asset" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}">
                    {$item->getName()}
                </a>
            {/if}
        </div>
    {/if}
</div>
{/foreach}
</div>
