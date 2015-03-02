<table class="table table-striped" data-order="true">
{foreach $items as $item}
    {$type = $item->getType()}
<tr class="order-item" data-type="{$type}" data-id="{$item->getId()}">
{if $type == 'folder'}
    <td class="option{if !$flatten} order-handle{/if}">
        <input type="checkbox" name="folders[]" value="{$item->getId()}" />
    </td>
    <td>
        <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}">
            <img src="{$app.url.base}/asphalt/img/folder.svg" width="50" height="50" class="data img-responsive" />
        </a>
        <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}">
            {$item->getName()}
        </a>
        <div class="text-muted">
            {translate key="label.type.`$type`"}
        </div>
    </td>
    <td>{$item->getDateAdded()|date_format}</td>
{else}
    <td class="option{if !$flatten} order-handle{/if}">
        <input type="checkbox" name="assets[]" value="{$item->getId()}" />
    </td>
    <td>
        {if $item->getThumbnail()}
            <img src="{image src=$item->getThumbnail() width=50 height=50 transformation="crop"}" class="data img-responsive" />
        {/if}
        <a href="{url id="assets.asset.edit" parameters=["locale" => $locale, "asset" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}">
            {$item->getName()}
        <a>
        <div class="text-muted">
            {translate key="label.type.`$type`"}
        </div>
    </td>
    <td>{$item->getDateAdded()|date_format}</td>
{/if}
</tr>
{/foreach}
</table>
