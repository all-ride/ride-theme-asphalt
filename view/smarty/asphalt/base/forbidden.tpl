{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.forbidden"} - {/block}

{block name="content"}
    <div class="page-header">
        <h1 class="heading--alt">{translate key="title.forbidden"}</h1>
    </div>
    <div class="page-main">
        <p class="">{translate key="label.forbidden.description"}</p>
    </div>
{/block}
