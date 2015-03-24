{extends file="base/index"}

{block name="content"}
    <div class="grid">
        <div class="grid__12 grid--bp-med__3">
            {block name="sidebar"}{/block}
        </div>
        <div class="grid__12 grid--bp-med__9">
            {block name="content_main"}
                {$smarty.block.parent}
            {/block}
        </div>
    </div>
{/block}
