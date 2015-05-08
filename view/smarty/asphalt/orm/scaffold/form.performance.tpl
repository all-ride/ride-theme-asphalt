{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $localizeUrl}
        {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
    {/if}
{/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{$title}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <div class="form__group row-date grid">
            <label for="form-event-dateStart" class="grid__item grid--bp-med__2 control-label"><strong>{translate key="label.date"}</strong></label>
            <div class="grid--bp-med__10">
                <div class="form__item">
                    {call formWidget form=$form row=$form->getRow('date')->getRow('dateStart')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('timeStart')}
                    <span class="until">&nbsp;{"label.until"|translate|lower}&nbsp;</span>
                    {call formWidget form=$form row=$form->getRow('date')->getRow('dateStop')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('timeStop')}
                </div>
                <div class="form__item">
                    {call formWidget form=$form row=$form->getRow('date')->getRow('isDay')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('isPeriod')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('isRepeat')}
                </div>
            </div>
            <div class="grid--bp-med__offset-2 grid--bp-med__10">
                {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('dateStart')}
                {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('timeStart')}
                {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('dateStop')}
                {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('timeStop')}

                {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('isDay')}
                {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('isPeriod')}
                {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('isRepeat')}
            </div>
        </div>

        <div class="repeater">
            <div class="form__group row-step grid">
                <label for="form-event-step" class="grid--bp-med__2 control-label"><strong>{translate key="label.mode"}</strong></label>
                <div class="grid--bp-med__10">
                    {call formWidget form=$form row=$form->getRow('date')->getRow('mode')}
                    &nbsp;{"label.event.every"|translate|lower}&nbsp;
                    {call formWidget form=$form row=$form->getRow('date')->getRow('step')}
                    <span class="step step-daily">{"label.days"|translate|lower}</span>
                    <span class="step step-weekly">{"label.weeks"|translate|lower}</span>
                    <span class="step step-monthly">{"label.months"|translate|lower}</span>
                    <span class="step step-yearly">{"label.years"|translate|lower}</span>
                </div>
                <div class="grid--bp-med__offset-2 grid--bp-med__10">
                    {call formRow form=$form row=$form->getRow('date')->getRow('weekly')}
                    {call formRow form=$form row=$form->getRow('date')->getRow('monthly')}
                </div>
            </div>

            <div class="form__group row-until grid">
                <label class="grid--bp-med__2 control-label" for="form-event-performance-until"><strong>{translate key="label.until"}</strong></label>
                <div class="grid--bp-med__10">
                    <div class="form__radio-item form__item">
                        <label>
                            {call formWidget form=$form row=$form->getRow('date')->getRow('until') part="date"}
                            {"label.date"|translate}&nbsp;
                        </label>
                        {call formWidget form=$form row=$form->getRow('date')->getRow('dateUntil')}
                        {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('dateUntil')}
                    </div>
                    <div class="form__radio-item form__item">
                        {call formWidget form=$form row=$form->getRow('date')->getRow('until') part="occurences"}
                        {call formWidget form=$form row=$form->getRow('date')->getRow('occurences')}
                        <label for="date-until-occurences">
                            &nbsp;{"label.occurences"|translate|lower}
                        </label>
                        {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('occurences')}
                    </div>
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('until')}
                </div>
            </div>
        </div>

        <div class="edit-confirm superhidden">
            {call formRow form=$form row="editMode"}
            {call formRow form=$form row="ignoreEdited"}
        </div>

        {call formRows form=$form}

        <div class="form__actions">
            <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
            <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
        </div>
    </form>
{/block}

{block name="styles" append}
    <link href="{$app.url.base}/asphalt/css/calendar.css" rel="stylesheet" media="screen">
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/calendar.js"></script>
{/block}
