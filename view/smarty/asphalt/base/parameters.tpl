{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.parameters"} - {/block}

{block name="taskbar_panels" append}
    {call taskbarPanelSearch url=$app.url.request method="GET" query=$query}
{/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.system"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/system.tabs" active="parameters"}

    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn--default" value="{translate key="button.submit"}" />
                    <a class="btn" href="{url id="system.parameters"}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </div>
    </form>

    <table class="table table-responsive table-striped">
        <thead>
            <tr>
                <th>{translate key="label.parameter"}</th>
                <th>{translate key="label.value"}</th>
            </tr>
        </thead>
        <tbody>
    {foreach $parameters as $key => $value}
            <tr>
                <td><a href="{url id="system.parameters.edit" parameters=["key" => $key]}">{$key}</a></td>
                <td>{$value|escape}</td>
            </tr>
    {/foreach}
        </tbody>
    </table>
{/block}
