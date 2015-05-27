{extends file="base/index"}

{block name="head_title" prepend}{if $folder->getId()}{$folder->getName()} - {/if}{translate key="title.assets"} - {/block}

{block name="taskbar"}{if !$embed}{$smarty.block.parent}{/if}{/block}

{block name="taskbar_panels" append}
    {url id="assets.folder.overview" parameters=["locale" => "%locale%", "folder" => $folder->id] var="url"}
    {$url = "`$url``$urlSuffix`"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title"}
    {if !$embed}
        <div class="page-header">
            <h1>{translate key="title.assets"}{if $folder->getId()} <small>{$folder->getName()}</small>{/if}</h1>
        </div>
    {/if}
{/block}

{block name="content_body" append}
    <div class="breadcrumb">
        <span itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="breadcrumb__item{if $breadcrumbs|count == 0} breadcrumb__item--active{/if}">
          <a href="{url id="assets.overview.locale" parameters=["locale" => $locale]}?view={$view}&embed={$embed}&limit={$limit}&selected={$app.request->getQueryParameter('selected')}" itemprop="url">
            <span itemprop="title">{translate key="title.assets"}</span>
          </a>{if $breadcrumbs|count != 0}  &rsaquo;{/if}
        </span>
        {foreach $breadcrumbs as $id => $name}
            <span itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="breadcrumb__item{if $name@last} breadcrumb__item--active{/if}">
              <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $id]}?view={$view}&embed={$embed}&limit={$limit}&selected={$app.request->getQueryParameter('selected')}" itemprop="url">
                <span itemprop="title">{$name}</span>
              </a>{if !$name@last} &rsaquo;{/if}
            </span>
        {/foreach}
    </div>


    {include file="base/form.prototype"}
    {include file="base/helper.prototype"}

    <form action="{url id="assets.asset.add" parameters=["locale" => $locale]}?folder={$folder->id}&embed={$embed}"
        class="dropzone"
        id="asset-dropzone">

        <div class="fallback">
            <input name="file" type="file" multiple />
        </div>
    </form>
    <form id="{$form->getId()}" class="form form-filter{*  form--selectize *}" action="{$app.url.request}" method="POST" role="form">
        <div class="actions clearfix">
            <div class="btn-group">
                <a href="{url id="assets.asset.add" parameters=["locale" => $locale]}?folder={$folder->id}&embed={$embed}&referer={$app.url.request|urlencode}" class="btn btn--default btn--small">
                   {translate key="button.add.asset"}
                </a>
                <a href="{url id="assets.folder.add" parameters=["locale" => $locale]}?folder={$folder->id}&embed={$embed}&referer={$app.url.request|urlencode}" class="btn btn--default btn--small">
                   {translate key="button.add.folder"}
                </a>
            </div>

            {if !$embed}
                <div class="btn-group">
                    <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=grid&type={$filter.type}&date={$filter.date}&embed={$embed}" class="btn btn--default btn--small{if $view == "grid"} active{/if}">
                        <i class="icon icon--th"></i>
                    </a>
                    <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=list&type={$filter.type}&date={$filter.date}&embed={$embed}" class="btn btn--default btn--small{if $view == "list"} active{/if}">
                        <i class="icon icon--th-list"></i>
                    </a>
                </div>
            {/if}

            {call formWidget form=$form row="type"}
            {call formWidget form=$form row="date"}
            {call formWidget form=$form row="query"}
            <button type="submit" name="submit" value="filter" class="btn btn--default btn--small">{translate key="button.filter"}</button>
        </div>

        {if $folder->description}
            <div class="description">{$folder->description}</div>
        {/if}

        <div class="assets assets-{$view}">
            <div class="asset-items clearfix">
                {if $embed}
                    {include file="assets/overview.grid"}
                {else}
                    {include file="assets/overview.`$view`" inline}
                {/if}
            </div>
            <div class="asset-actions">
                <div class="form__actions grid">
                    <div class="grid__12 grid--bp-med__3">
                        <input type="checkbox" name="all" class="select-all" />
                        <select name="action" class="form-control form-action form__select form__select--inline">
                            <option value="">- {translate key="label.actions.bulk"} -</option>
                            <option value="delete">{translate key="button.delete"}</option>
                        </select>
                        <button class="btn btn--default btn--small" name="submit" value="bulk-action" type="submit">{translate key="button.apply"}</button>
                    </div>
                    <div class="grid__12 grid--bp-med__6 text--center">
                        {if $pages > 1}
                            {url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id] var="urlPagination"}
                            {$urlPagination = "`$urlPagination``$urlSuffix`&limit=`$limit`&page=%page%"}
                            {pagination pagination=$pagination}
                        {/if}
                    </div>
                    <div class="grid--bp-med__3 text--right">
                        <form action="{$app.url.request}" class="form-horizontal form-limit" method="POST" role="form">
                            <select name="limit" class="form-control form__select form__select--inline">
                                <option value="12"{if $limit == 12} selected="selected"{/if}>12</option>
                                <option value="24"{if $limit == 24} selected="selected"{/if}>24</option>
                                <option value="48"{if $limit == 48} selected="selected"{/if}>48</option>
                                <option value="96"{if $limit == 96} selected="selected"{/if}>96</option>
                            </select>
                            <button value="limit" name="submit" class="btn btn--default btn--small" type="submit">{translate key="button.apply"}</button>
                        </form>
                    </div>
                </div>
                <div class="form__actions text--center">
                    <select name="order" class="form-control form-order  form__select form__select--inline">
                        <option value="">- {translate key="label.actions.order"} -</option>
                        <option value="asc">{translate key="label.order.asc"}</option>
                        <option value="desc">{translate key="label.order.desc"}</option>
                        <option value="newest">{translate key="label.order.newest"}</option>
                        <option value="oldest">{translate key="label.order.oldest"}</option>
                    </select>
                    <button name="submit" value="order" type="submit" class="btn btn--default btn--small btn--order">{translate key="button.order"}</button>
                </div>
            </div>
        </form>
    </div>

{/block}

{block name="scripts" append}
    <script type="text/javascript">
        $(function () {
            $('.select-all').click(function() {
                $('.order-item input[type=checkbox]').prop('checked', $(this).prop('checked'));
            });

            $('.form-limit').on('change', function() {
                $('.btn-limit').trigger('click');
            });
            $('.btn-limit').hide();

        {if !$isFiltered}
            var sortFolderUrl = "{url id="assets.folder.sort" parameters=["locale" => $locale, "folder" => $folder->getId()]}";
            var sortAssetUrl = "{url id="assets.asset.sort" parameters=["locale" => $locale, "folder" => $folder->getId()]}";

            $(".asset-items-folders").sortable({
                cursor: "move",
                handle: ".order-handle",
                items: ".order-item",
                select: false,
                scroll: true,
                update: function (event, ui) {
                    var order = [];

                    $('.asset-items-folders .order-item').each(function() {
                        var $this = $(this);

                        order.push($this.data('id'));
                    });

                    $.post(sortFolderUrl, {ldelim}order: order, page: {$page}, limit: {$limit}});
                }
            });

            $(".asset-items-assets").sortable({
                cursor: "move",
                handle: ".order-handle",
                items: ".order-item",
                select: false,
                scroll: true,
                update: function (event, ui) {
                    var order = [];

                    $('.asset-items-assets .order-item').each(function() {
                        var $this = $(this);

                        order.push($this.data('id'));
                    });

                    $.post(sortAssetUrl, {ldelim}order: order, page: {$page}, limit: {$limit}});
                }
            });
        {/if}
        });
    </script>
    {$script = 'js/assets.js'}
    {if !isset($app.javascripts[$script]) && $embed}
        <script src="{$app.url.base}/asphalt/js/assets.js"></script>
    {/if}

    {* {$script = 'js/form.js'}
    {if !isset($app.javascripts[$script])}
        <script src="{$app.url.base}/asphalt/js/form.js"></script>
    {/if} *}
{/block}
