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
          <a href="{url id="assets.overview.locale" parameters=["locale" => $locale]}?view={$view}&flatten={$flatten}&embed={$embed}&limit={$limit}&assets={$app.request->getQueryParameter('assets')}" itemprop="url">
            <span itemprop="title">{translate key="title.assets"}</span>
          </a>{if $breadcrumbs|count != 0}  &rsaquo;{/if}
        </span>
        {foreach $breadcrumbs as $id => $name}
            <span itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="breadcrumb__item{if $name@last} breadcrumb__item--active{/if}">
              <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $id]}?view={$view}&flatten={$flatten}&embed={$embed}&limit={$limit}&assets={$app.request->getQueryParameter('assets')}" itemprop="url">
                <span itemprop="title">{$name}</span>
              </a>{if !$name@last} &rsaquo;{/if}
            </span>
        {/foreach}
    </div>
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
                <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=grid&type={$filter.type}&date={$filter.date}&flatten={$flatten}&embed={$embed}" class="btn btn--default btn--small{if $view == "grid"} active{/if}">
                    <i class="icon icon--th"></i>
                </a>
                <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=list&type={$filter.type}&date={$filter.date}&flatten={$flatten}&embed={$embed}" class="btn btn--default btn--small{if $view == "list"} active{/if}">
                    <i class="icon icon--th-list"></i>
                </a>
            </div>
        {/if}

        {include file="base/form.prototype"}
        <form id="{$form->getId()}" class="form-horizontal form-filter" action="{$app.url.request}" method="POST" role="form">
            {call formWidget form=$form row="type"}
            {call formWidget form=$form row="date"}
            {call formWidget form=$form row="query"}
            <button type="submit" class="btn btn--default btn--small">{translate key="button.filter"}</button>
        </form>
    </div>

    {if $folder->description}
        <div class="description">{$folder->description}</div>
    {/if}

    <div class="assets assets-{$view}">
        <form class="table" action="{url id="assets.folder.bulk" parameters=["locale" => $locale, "folder" => $folder->getId()]}?referer={$app.url.request|urlencode}" method="post">
            <div class="asset-items clearfix">
                {if $embed}
                    {include file="assets/overview.grid"}
                {else}
                    {include file="assets/overview.`$view`" inline}
                {/if}
            </div>
            <div class="asset-actions">
                <input type="checkbox" name="all" class="select-all" />
                <select name="action" class="form-control form__select form__select--inline">
                    <option value="">- {translate key="label.actions.bulk"} -</option>
                    <option value="delete">{translate key="button.delete"}</option>
                </select>
                <button class="btn btn--default btn--small" type="submit">{translate key="button.apply"}</button>
            </div>
        </form>
    </div>
    {include file="base/helper.prototype"}
    <div class="grid">
        <div class="grid--bp-med__6 text--left">
            {if $pages > 1}
                {url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id] var="urlPagination"}
                {$urlPagination = "`$urlPagination``$urlSuffix`&flatten=`$flatten`&limit=`$limit`&page=%page%&assets=`$app.request->getQueryParameter('assets')`"}
                {pagination pagination=$pagination}
            {/if}
        </div>
        <div class="grid--bp-med__6 text--right">
            <form action="{$app.url.request}" class="form-horizontal form-limit" method="POST" role="form">
                <select name="limit" class="form-control form__select form__select--inline">
                    <option value="12"{if $limit == 12} selected="selected"{/if}>12</option>
                    <option value="24"{if $limit == 24} selected="selected"{/if}>24</option>
                    <option value="48"{if $limit == 48} selected="selected"{/if}>48</option>
                    <option value="96"{if $limit == 96} selected="selected"{/if}>96</option>
                </select>
                <button class="btn btn--default btn--small" type="submit">{translate key="button.apply"}</button>
            </form>
        </div>
    </div>


{/block}

{block name="scripts" append}
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

                    $.post(sortUrl, {ldelim}order: order, index: {(($page - 1) * $limit) + 1}});
                }
            });
        });
    </script>

    {$script = 'js/assets.js'}
    {if !isset($app.javascripts[$script]) && $embed}
        <script src="{$app.url.base}/asphalt/js/assets.js"></script>
    {/if}
{/block}

