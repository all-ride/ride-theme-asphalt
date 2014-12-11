{function name="taskbarMenuItems" items=null class=null}
    {foreach from=$items item="item"}
        {if $item === '-'}
            <li role="presentation" class="dropdown__divider"></li>
        {elseif is_string($item)}
            <li role="presentation" class="dropdown__header">{$item}</li>
        {elseif !method_exists($item, 'hasItems')}
            <li><a href="{$item->getUrl()}">{$item->getLabel()}</a></li>
        {elseif $class}
            <li class="{$class}">
                <a href="#" tabindex="-1" class="dropdown-toggle" data-toggle="dropdown">{$item->getLabel()} <i class="icon icon--angle-down"></i></a>
                <ul class="dropdown__menu">
                {call taskbarMenuItems items=$item->getItems() class="dropdown-submenu"}
                </ul>
            </li>
        {else}
            <li role="presentation" class="dropdown__header">{$item->getLabel()}</li>
            {call taskbarMenuItems items=$item->getItems()}
        {/if}
    {/foreach}
{/function}

{function name="taskbarPanelSearch" url=null method=null query=null}
    {if !$method}
        {$method = "POST"}
    {/if}
    <li>
        <form action="{$url}" class="navbar__form" role="search" method="{$method}">
            <input type="text" name="query" class="form__text" placeholder="{translate key="label.search"}" value="{$query|escape}" />
        </form>
    </li>
{/function}

{function name="taskbarPanelLocales" url=null locale=null locales=null}
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            {$locale|upper}
            <i class="icon icon--angle-down"></i>
        </a>
        <ul class="dropdown__menu">
        {foreach $locales as $code => $locale}
            <li>
                <a href="{$url|replace:"%25locale%25":$code}">
                    {translate key="language.`$code`"}
                </a>
            </li>
        {/foreach}
        </ul>
    </li>
{/function}

<div class="navbar">
    <div class="container">
        {block name="taskbar_title"}<a class="navbar__brand" href="{$app.url.base}">{$title}</a>{/block}

        <ul class="navbar__nav nav">
        {block name="taskbar_applications"}
            {if $applicationsMenu->hasItems()}
                {call taskbarMenuItems items=$applicationsMenu->getItems() class="dropdown"}
            {/if}
        {/block}
        </ul>
        <ul class="navbar__nav navbar__right nav">
            {block name="taskbar_panels"}
            {/block}
            {block name="taskbar_menu"}
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    {if $app.user}
                        <i class="icon icon--user"></i>
                        {$app.user->getDisplayName()}
                    {else}
                        {translate key="label.user.anonymous"}
                    {/if}
                    <i class="icon icon--angle-down"></i>
                </a>
                <ul class="dropdown__menu dropdown__menu--right">
                    {block name="taskbar_settings"}
                        {if $settingsMenu->hasItems()}
                            {call taskbarMenuItems items=$settingsMenu->getItems()}
                        {/if}
                    {/block}
                </ul>
            </li>
            {/block}
        </ul>
    </div>
</div>
