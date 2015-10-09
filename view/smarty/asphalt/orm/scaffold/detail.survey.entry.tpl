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
    <div class="btn--group">
        <a href="{$backUrl}" class="btn btn--default">{translate key="button.back"}</a>
    </div>

    <div class="tabbable">
        <ul class="tabs">
            <li class="tabs__tab active">
                <a href="#tabgeneral" data-toggle="tab">{translate key="title.general"}</a>
            </li>
            <li class="tabs__tab">
                <a href="#tabquestions" data-toggle="tab">{translate key="title.questions"}</a>
            </li>
            <li class="tabs__tab">
                <a href="#tabevaluations" data-toggle="tab">{translate key="title.evaluations"}</a>
            </li>
        </ul>
        <div class="tabs__content">
            <div id="tabgeneral" class="tabs__pane active">
                {include file="orm/scaffold/detail.survey.entry.detail"}
            </div>
            <div id="tabquestions" class="tabs__pane">
            {foreach $survey->getQuestions() as $question}
                <h3>{$question->getQuestion()}</h3>
                {$question->getDescription()}

                {$entryAnswers = $entry->getAnswersForQuestion($question->getId())}
                {$likert = $question->getLikert()}
                {if $likert}
                    {$likertAnswers = $likert->getAnswers()}
                <table class="table">
                    <tr>
                        <th></th>
                    {foreach $likertAnswers as $likertAnswer}
                        <th data-id="{$likertAnswer->getId()}">{$likertAnswer->getAnswer()}</th>
                    {/foreach}
                    </tr>

                    {foreach $question->getAnswers() as $answer}
                        {$answerLikert = $answer->getLikert()}
                    <tr>
                        <td>{$answer->getAnswer()}</td>
                        {foreach $answerLikert->getAnswers() as $likertAnswer}
                        <td>
                            {foreach $entryAnswers as $entryAnswer}
                                {if $entryAnswer->getQuestionAnswer() && $entryAnswer->getQuestionAnswer()->getId() == $answer->getId()}
                                    {if $entryAnswer->getAnswer() && $entryAnswer->getAnswer->getId() == $likertAnswer->getId()}
                                        {$likertAnswer->getAnswer()}
                                    {/if}
                                {/if}
                            {/foreach}
                        </td>
                        {/foreach}
                    </tr>
                    {/foreach}
                </table>
                {else}
                <ul>
                    {foreach $question->getAnswers() as $answer}
                        {$isSelected = false}
                        {foreach $entryAnswers as $entryAnswer}
                            {if $entryAnswer->getAnswer() && $entryAnswer->getAnswer->getId() == $answer->getId()}
                                {$isSelected = true}
                            {/if}
                        {/foreach}

                        {if $isSelected}
                    <li><strong>{$answer->getAnswer()}</strong></li>
                        {else}
                    <li>{$answer->getAnswer()}</li>
                        {/if}
                    {/foreach}
                </ul>
                {/if}
                {foreach $entryAnswers as $entryAnswer}
                    {if $entryAnswer->getDescription()}
                <p><strong>{$entryAnswer->getDescription()}</strong></p>
                    {/if}
                {/foreach}
            {/foreach}
            </div>
            <div id="tabevaluations" class="tabs__pane">
            {foreach $evaluations as $evaluation}
                {$result = $evaluation->evaluate($entry)}

                <h3>{$evaluation->getName()} <small>{$result->getScore()}</small></h3>
                {if $result->getRule()}
                <h4>{$result->getRule()->getTitle()}</h4>
                {$result->getRule()->getBody()}
                {/if}
            {/foreach}
            </div>
        </div>
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/form.js"></script>
    <script src="{$app.url.base}/asphalt/js/table.js"></script>
{/block}
