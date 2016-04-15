{if !isset($tableActions)}
    {$tableActions = []}
{/if}
{$tmpTableActions = []}
{foreach $tableActions as $tableActionUrl => $tableActionLabel}
    {isGranted url=$tableActionUrl var="isGranted"}{/isGranted}
    {if $isGranted}
        {$tmpTableActions[$tableActionUrl] = $tableActionLabel}
    {/if}
{/foreach}
{$tableActions = $tmpTableActions}

{if $table->hasRows() || $table->hasSearch() || $tableActions}
    {tableVars}
    {include file="base/form.prototype"}
    {include file="base/helper.prototype"}

    {$tableMessages = json_encode($table->getActionConfirmationMessages())}
    <form id="{$tableForm->getId()}" action="{if isset($tableAction)}{$tableAction}{else}{$table->getFormUrl()}{/if}" method="POST" class="table spacer" role="form" data-confirm-messages="{$tableMessages|escape}">
        {formWidget form=$tableForm row=$tableNameField}

        <div class="form__group">

        {if $tableActions || $table->hasOrderMethods() || $table->hasSearch()}
            <div class="grid table-header clearfix">
                <div class="grid--bp-med__4">
                    {if $tableActions}
                        <div class="btn-group">
                            {foreach $tableActions as $url => $dataAction}
                                {if $dataAction@first}
                                    <a class="btn btn--brand" href="{$url}"><i class="icon icon--plus"></i> {$dataAction}</a>
                                    {if $tableActions|count > 1}
                                        <a href="#" class="btn btn--brand" data-toggle="dropdown">
                                          <i class="icon icon--angle-down"></i>
                                          <span class="visuallyhidden">Toggle Dropdown</span>
                                        </a>
                                        <ul class="dropdown__menu" role="menu">
                                    {/if}
                                {else}
                                    <li><a href="{$url}">{$dataAction}</a></li>
                                {/if}
                            {/foreach}
                            {if $tableActions|count > 1}
                                </ul>
                            {/if}
                        </div>
                    {/if}
                </div>
                <div class="grid--bp-med__4 search form__item">
                    {if $table->hasSearch()}
                        {block name="table.search"}
                            {$tableForm->getRow($tableSearchQueryField)->getWidget()->setAttribute('placeholder', "label.search"|translate)}
                            {formWidget form=$tableForm row=$tableSearchQueryField}
                        {/block}
                    {/if}
                </div>
                <div class="grid--bp-med__4 order text--right form__item">
                    {if $table->hasOrderMethods()}
                        {block name="table.order"}
                            {translate key="label.table.order"}
                            {formWidget form=$tableForm row=$tableOrderField}

                            {if $table->getOrderDirection() == 'asc'}
                                {assign var="direction" value="desc"}
                                {assign var="iconClass" value="icon icon--chevron-down"}
                            {else}
                                {assign var="direction" value="asc"}
                                {assign var="iconClass" value="icon icon--chevron-up"}
                            {/if}

                            <a href="{$table->getOrderDirectionUrl()|replace:"%direction%":$direction}">
                                <i class="{$iconClass}"></i>
                            </a>
                        {/block}
                    {/if}
                </div>
            </div>
        {/if}

        {if $table->hasRows()}
            {block name="table.content"}
                {$table->getHtml()}
            {/block}
            {if $table->hasActions() || $table->hasPaginationOptions()}
                <div class="grid">
                    <div class="options grid--bp-med__3">
                        {if $table->hasActions()}
                            {block name="table.actions"}
                                {if $tableForm->hasRow($tableActionField)}
                                    <input type="checkbox" id="{$tableForm->getId()}-action-all" class="check-all" />
                                    {formWidget form=$tableForm row=$tableActionField}
                                {/if}
                            {/block}
                        {/if}
                    </div>
                    {if $table->hasPaginationOptions()}
                        {block name="table.pagination"}
                            {if $table->getRowsPerPage() || $table->getPaginationOptions()}
                                {assign var="page" value=$table->getPage()}
                                {assign var="pages" value=$table->getPages()}
                                {assign var="href" value=$table->getPaginationUrl()}

                                <div class="grid--bp-med__6">
                                    {if $pages > 1}
                                        {pagination pagination=$table->getPagination()}
                                    {/if}
                                </div>
                                <div class="grid--bp-med__3 pagination-options text--right">
                                    {if $table->getPaginationOptions()}
                                        {formWidget form=$tableForm row=$tablePageRowsField}
                                        {translate key="label.table.rows.page"}
                                    {/if}

                                    ({translate key="label.table.rows.total" rows=$table->countRows()})
                                </div>
                            {else}
                                <div class="grid--bp-med__9 pagination-options text--right">
                                    {translate key="label.table.rows.total" rows=$table->countRows()}
                                </div>
                            {/if}
                        {/block}
                    {/if}
                </div>
            {/if}
        {else}
            <div style="clear:both; font-size:1.2em;">{translate key="label.result.notfound"}</div>
        {/if}
        </div>
    </form>
{/if}
