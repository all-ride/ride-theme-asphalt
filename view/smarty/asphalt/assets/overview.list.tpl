<table class="table table-striped" data-order="true">
    {if $folders}
        <tbody class="asset-items--folders">
            {foreach $folders as $item}
                {$type = $item->getType()}
                <tr class="order-item" data-type="{$type}" data-id="{$item->getId()}">
                    <td class="option{if !$isFiltered} order-handle{/if}">
                        <input type="checkbox" name="folders[]" value="{$item->getId()}" />
                    </td>
                    <td>
                        <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix|replace:"&page=`$page`":""}">
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
                </tr>
            {/foreach}
        </tbody>
    {/if}
    {if $assets}
        <tbody class="asset-items--assets">
            {foreach $assets as $item}
                {$type = $item->getType()}
                <tr class="order-item" data-type="{$type}" data-id="{$item->getId()}">
                    <td class="option{if !$isFiltered} order-handle{/if}">
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
                </tr>
            {/foreach}
        </tbody>
    {/if}
</table>
