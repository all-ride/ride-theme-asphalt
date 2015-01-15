{extends file="base/index"}

{block name="head_title" prepend}{if $folder->getId()}{$folder->getName()} - {/if}{translate key="title.assets"} - {/block}

{block name="taskbar_panels" append}
    {url id="assets.folder.overview" parameters=["locale" => "%locale%", "folder" => $folder->id] var="url"}
    {$url = "`$url``$urlSuffix`"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.assets"}{if $folder->getId()} <small>{$folder->getName()}</small>{/if}</h1>
</div>
{/block}

{block name="content_body" append}
    <div class="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="{url id="assets.overview.locale" parameters=["locale" => $locale]}?view={$view}&flatten={$flatten}">{translate key="title.assets"}</a></li>
        {foreach $breadcrumbs as $id => $name}
            <li><a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $id]}?view={$view}&flatten={$flatten}">{$name}</a></li>
        {/foreach}
        </ol>
    </div>

    <div class="actions clearfix">
        <div class="btn-group">
            <a href="{url id="assets.asset.add" parameters=["locale" => $locale]}?folder={$folder->id}&referer={$app.url.request|urlencode}" class="btn btn--default">
               {translate key="button.add.asset"}
            </a>
            <a href="{url id="assets.folder.add" parameters=["locale" => $locale]}?folder={$folder->id}&referer={$app.url.request|urlencode}" class="btn btn--default">
               {translate key="button.add.folder"}
            </a>
        </div>

        <div class="btn-group">
            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=grid&type={$filter.type}&date={$filter.date}&flatten={$flatten}" class="btn btn-default{if $view == "grid"} active{/if}">
                <i class="icon icon--th"></i>
            </a>
            <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=list&type={$filter.type}&date={$filter.date}&flatten={$flatten}" class="btn btn-default{if $view == "list"} active{/if}">
                <i class="icon icon--th-list"></i>
            </a>
        </div>

        {include file="base/form.prototype"}
        <form id="{$form->getId()}" class="form-horizontal form-filter" action="{$app.url.request}" method="POST" role="form">
            {call formWidget form=$form row="type"}
            {call formWidget form=$form row="date"}
            <button type="submit" class="btn btn--default">{translate key="button.filter"}</button>
        </form>
    </div>

    {if $folder->description}
        <div class="description">{$folder->description}</div>
    {/if}

    <div class="assets assets-{$view}">
        <form class="table" action="{url id="assets.folder.bulk" parameters=["locale" => $locale, "folder" => $folder->getId()]}?referer={$app.url.request|urlencode}" method="post">
            <div class="asset-items clearfix">
                {include file="assets/overview.`$view`" inline}
            </div>
            <div class="asset-actions">
                <input type="checkbox" name="all" class="select-all" />
                <select name="action" class="form-control">
                    <option value="">- {translate key="label.actions.bulk"} -</option>
                    <option value="delete">{translate key="button.delete"}</option>
                </select>
                <button class="btn btn--default" type="submit">{translate key="button.apply"}</button>
            </div>
        </form>
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.select-all').click(function() {
                $('.order-item input[type=checkbox]').prop('checked', $(this).prop('checked'));
            });

            var sortUrl = "{url id="assets.sort" parameters=["locale" => $locale, "folder" => $folder->getId()]}";

            $(".assets").sortable({
                cursor: "move",
                handle: ".order-handle",
                items: ".order-item",
                select: false,
                scroll: true,
                update: function (event, ui) {
                    var order = [];

                    $('.order-item').each(function() {
                        var $this = $(this);

                        order.push({
                            type: $this.data('type'),
                            id: $this.data('id'),
                        });
                    });

                    $.post(sortUrl, {ldelim}order: order});
                }
            });
        });
    </script>
{/block}
