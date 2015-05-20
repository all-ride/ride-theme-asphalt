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
        <div class="form__group row-date">
            <div class="form__group">
                <label for="date-dateStart" class="form__label">{translate key="label.date"}</label>
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
            <div class="form__group">
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
            <div class="form__group row-step">
                <label for="date-mode" class="form__label">{translate key="label.mode"}</label>
                <div class="form__group">
                    {call formWidget form=$form row=$form->getRow('date')->getRow('mode')}
                    &nbsp;{"label.event.every"|translate|lower}&nbsp;
                    {call formWidget form=$form row=$form->getRow('date')->getRow('step')}
                    <span class="step step-daily">{"label.days"|translate|lower}</span>
                    <span class="step step-weekly">{"label.weeks"|translate|lower}</span>
                    <span class="step step-monthly">{"label.months"|translate|lower}</span>
                    <span class="step step-yearly">{"label.years"|translate|lower}</span>
                </div>
                <div class="form__group">
                    {call formRow form=$form row=$form->getRow('date')->getRow('weekly')}
                    {call formRow form=$form row=$form->getRow('date')->getRow('monthly')}
                </div>
            </div>

            <div class="form__group row-until">
                <label class="form__label" for="form-event-performance-until"><strong>{translate key="label.until"}</strong></label>
                <div class="form__item form__item--radios">
                    <div class="form__radio-item form__item">
                        <label class="form__label form__label--radio">
                            {call formWidget form=$form row=$form->getRow('date')->getRow('until') part="date"}
                            &nbsp;{"label.date"|translate}&nbsp;
                        </label>
                        {call formWidget form=$form row=$form->getRow('date')->getRow('dateUntil')}
                        {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('dateUntil')}
                    </div>
                    <div class="form__radio-item form__item">
                        <label class="form__label form__label--radio">
                            {call formWidget form=$form row=$form->getRow('date')->getRow('until') part="occurences"}
                            &nbsp;
                        </label>
                        {call formWidget form=$form row=$form->getRow('date')->getRow('occurences')}
                        {"label.occurences"|translate|lower}
                        {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('occurences')}
                    </div>
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('until')}
                </div>
            </div>
        </div>

        <div class="form__group edit-confirm superhidden">
            {call formRow form=$form row="editMode"}
            {call formRow form=$form row="ignoreEdited"}
        </div>

        <div class="form__group">
            {call formRows form=$form}
        </div>

        <div class="form__actions">
            <button type="submit" class="btn btn--brand">{translate key="button.save"}</button>
            <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/calendar.js"></script>
{/block}
