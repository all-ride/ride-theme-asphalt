{if isset($app.cms.node)}
    {$bodyComponent = $app.cms.node->get('body.components')}
    {if !$bodyComponent|strstr:'form'}
        {$app.cms.node->set('body.components', "`$bodyComponent` form")}
    {/if}
{/if}

{*
    Prototype functions for the form rendering

    To override, create a file and recreate the functions you wish to override.
    At the end of your file, include this one to define the missing functions.
*}

{*
    Renders the rows of the form
*}
{function name="formRows" rows=null form=null rowClass=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if !$rows && $form}
        {$rows = $form->getRows()}
    {/if}

    {if $rows}
        {foreach $rows as $row}
            {if !$row->isRendered()}
                {call formRow form=$form row=$row class=$rowClass}
            {/if}
        {/foreach}
    {/if}
{/function}

{*
    Renders a simple row of the form
*}
{function name="formRow" form=null row=null part=null class=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {$type = $row->getType()}
        {if $type == 'hidden'}
            {call formWidget form=$form row=$row part=$part}

            {$errors = $form->getValidationErrors($row->getName())}
            {if $errors}
            <div class="form__group form__error">
                {call formWidgetErrors form=$form row=$row}
            </div>
            {/if}
        {elseif $type == 'component' && $row->getOption('embed')}
            <div class="form__item">
                {call formWidgetComponent form=$form row=$row}
            </div>
        {elseif $type == 'collection'}
            {$errors = $form->getValidationErrors($row->getName())}

            <div class="form__item row-{$row->getName()|replace:'[':''|replace:']':''}{if $row->isRequired()} required{/if}{if $row->isDisabled()} disabled{/if}{if $row->isReadOnly()} readonly{/if} clearfix{if $errors} form__error{/if}{if $class} {$class}{/if}"{if $row->getOption('order')} data-order="true"{/if}>
                <label class="form__label">{$row->getLabel()}</label>

                {$description = $row->getDescription()}
                {if $description}
                    <p class="form__help">{$description}</p>
                {/if}

                {call formCollectionPrototype assign="prototype" form=$form row=$row part='%prototype%'}

                <div class="collection-controls form__collection" data-prototype="{$prototype|escape:"html"|trim|replace:"\n":''}">
                    {call formWidgetCollection form=$form row=$row part=$part}

                   {if $errors}
                        <ul class="form__error-list">
                        {foreach $errors as $error}
                            <li>{$error->getCode()|translate:$error->getParameters()}</li>
                        {/foreach}
                        </ul>
                    {/if}
                </div>
            </div>
        {else}
            {$errors = $form->getValidationErrors()}
            {$widget = $row->getWidget()}
            {$errorsName = $widget->getName()}
            {if $widget->isMultiple() && $part}
                {$errorsName = "`$errorsName`[`$part`]"}
            {/if}

            {if isset($errors.$errorsName)}
                {$errors = $errors.$errorsName}
            {else}
                {$errors = array()}
            {/if}

            <div class="form__item form__item--{$row->getName()|replace:'[':''|replace:']':''}{if $row->isRequired()} form__item--required{/if}{if $row->isDisabled()} form__item--disabled{/if}{if $row->isReadOnly()} form__item--readonly{/if} clearfix{if $errors} form__error{/if}{if $class} {$class}{/if}">
            {if $widget->getType() == 'component'}
                {$attributes = $widget->getAttributes()}
                <div
                {foreach $attributes as $name => $attribute}
                    {$name}="{$attribute|escape}"
                {/foreach}
                >
            {/if}

            {if ($row->getLabel()|replace:' ':'')}
                <label class="form__label" for="{$widget->getId()}">{if $type != 'button'}{$row->getLabel()}{if $type != 'label' && $type != 'component' && !$row->isRequired()} <small>({translate key="label.optional"})</small>{/if}{/if}</label>
            {/if}

            {call formWidget form=$form row=$row part=$part}

            {if $errors}
                <ul class="form__error-list">
                {foreach $errors as $error}
                    <li>{$error->getCode()|translate:$error->getParameters()}</li>
                {/foreach}
                </ul>
            {/if}

            {if $widget && $type == 'option'}
                {$widgetOptions = $widget->getOptions()}
            {else}
                {$widgetOptions = array()}
            {/if}

            {$description = $row->getDescription()}
            {if $description && $type !== 'checkbox' && ($type !== 'option' || ($type === 'option' && $widget && $widgetOptions))}
                <div class="form__help">{$description}</div>
            {/if}

            {if $type == 'date'}
                <div class="form__help">{translate key="label.date.example" example=time()|date_format:$row->getFormat() format=$row->getFormat()}</div>
            {elseif $type == 'select' && $widget->isMultiple()}
                <div class="form__help">{translate key="label.multiselect"}</div>
            {/if}

            {if $widget->getType() == 'component'}
                </div>
            {/if}
            </div>
        {/if}

        {$row->setIsRendered(true)}
    {else}
        <div class="alert alert-danger">No row provided</div>
    {/if}
{/function}

{*
    Renders the errors of a single widget of the form
*}
{function name="formWidgetErrors" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {$widget = $row->getWidget()}

        {if $widget}
            {$errors = $form->getValidationErrors()}
            {$errorsName = $widget->getName()}
            {if $widget->isMultiple() && $part !== null}
                {$errorsName = "`$errorsName`[`$part`]"}
            {/if}

            {if isset($errors.$errorsName)}
                {$errors = $errors.$errorsName}
            {else}
                {$errors = array()}
            {/if}

            {if $errors}
                <ul class="errors form__help">
                {foreach $errors as $error}
                    <li>{$error->getCode()|translate:$error->getParameters()}</li>
                {/foreach}
                </ul>
            {/if}
        {else}
            <div class="error">No widget set in row {$row->getName()}.</div>
        {/if}
    {else}
        <div class="error">No row provided</div>
    {/if}
{/function}

{*
    Renders a single control of the form
*}
{function name="formWidget" form=null row=null part=null type=null class=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {if !$type}
            {$widget = $row->getWidget()}
            {$type = $widget->getType()}
        {/if}
        {$type = $type|ucfirst}

        {if !$type}
            <div class="error">No type provided for row {$row->getName()}</div>
        {else}
            {$function = "formWidget`$type`"}
            {call $function form=$form row=$row part=$part class=$class}

            {$row->setIsRendered(true)}
        {/if}
    {else}
        <div class="error">No row provided</div>
    {/if}
{/function}

{function name="formWidgetHidden" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        <input type="hidden"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $widget->getAttributes() as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetLabel" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__label"}
        {else}
            {$attributes.class = 'form__label'}
        {/if}

        {$value = $widget->getValue($part)}
        <p
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >{if $row->getOption('html')}{$value}{else}{$value|escape}{/if}</p>
    {/if}
{/function}

{function name="formWidgetButton" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "btn btn--default `$attributes.class`"}
        {else}
            {$attributes.class = 'btn btn--default'}
        {/if}

        <button
            name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
            value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >{$row->getLabel()}</button>
    {/if}
{/function}

{function name="formWidgetString" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {$validators = $row->getValidators()}
        {$value = $widget->getValue($part)}

        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text"}
        {else}
            {$attributes.class = 'form__text'}
        {/if}

        {foreach $validators as $validator}
            {foreach $validator->getOptions() as $option => $optionValue}
                {* Don't set min/max length attribute on autocomplete fields *}
                {if isset($attributes["data-autocomplete-max-items"])}
                    {continue}
                {/if}

                {if $option == 'minimum'}
                    {$attributes.minlength = $optionValue}
                {else if $option == 'maximum'}
                    {$attributes.maxlength = $optionValue}
                {/if}
            {/foreach}
        {/foreach}

        {if $widget->isMultiple()}
            {$attributes["data-multiple"] = "true"}
        {/if}

        {if is_array($value)}
            {foreach $value as $part => $val}
            <input type="text"
                   name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
                   value="{$val|escape}"
               {foreach $attributes as $name => $attribute}
                   {$name}="{$attribute|escape}"
               {/foreach}
             />
             {/foreach}
        {else}
            <input type="text"
                   name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
                   value="{$value|escape}"
               {foreach $attributes as $name => $attribute}
                   {$name}="{$attribute|escape}"
               {/foreach}
             />
        {/if}
    {/if}
{/function}

{function name="formWidgetNumber" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text"}
        {else}
            {$attributes.class = 'form__text'}
        {/if}

        <input type="text" inputmode="number"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetEmail" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text"}
        {else}
            {$attributes.class = 'form__text'}
        {/if}

        {$validators = $row->getValidators()}
        {foreach $validators as $validator}
            {foreach $validator->getOptions() as $option => $value}
                {if $option == 'minimum'}
                    {$attributes.minlength = $value}
                {else if $option == 'maximum'}
                    {$attributes.maxlength = $value}
                {/if}
            {/foreach}
        {/foreach}

        <input type="email"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetDate" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text js-datepicker"}
        {else}
            {$attributes.class = 'form__text js-datepicker'}
        {/if}

        <input type="text"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetWebsite" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text"}
        {else}
            {$attributes.class = 'form__text'}
        {/if}

        {$validators = $row->getValidators()}
        {foreach $validators as $validator}
            {foreach $validator->getOptions() as $option => $value}
                {if $option == 'minimum'}
                    {$attributes.minlength = $value}
                {else if $option == 'maximum'}
                    {$attributes.maxlength = $value}
                {/if}
            {/foreach}
        {/foreach}

        <input type="website"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetPassword" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text"}
        {else}
            {$attributes.class = 'form__text'}
        {/if}

        {$validators = $row->getValidators()}
        {foreach $validators as $validator}
            {foreach $validator->getOptions() as $option => $value}
                {if $option == 'minimum'}
                    {$attributes.minlength = $value}
                {else if $option == 'maximum'}
                    {$attributes.maxlength = $value}
                {/if}
            {/foreach}
        {/foreach}

        <input type="password"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetText" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}
    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text"}
        {else}
            {$attributes.class = 'form__text'}
        {/if}

        {$validators = $row->getValidators()}
        {foreach $validators as $validator}
            {foreach $validator->getOptions() as $option => $value}
                {if $option == 'minimum'}
                    {$attributes.minlength = $value}
                {else if $option == 'maximum'}
                    {$attributes.maxlength = $value}
                {/if}
            {/foreach}
        {/foreach}

        {$value = $widget->getValue($part)}
        {if is_array($value)}
            {foreach $value as $part => $val}
                <textarea name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
                   {foreach $attributes as $name => $attribute}
                       {$name}="{$attribute|escape}"
                   {/foreach}
                 >{$val|escape}</textarea>
             {/foreach}
        {else}
            <textarea name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
               {foreach $attributes as $name => $attribute}
                   {$name}="{$attribute|escape}"
               {/foreach}
             >{$widget->getValue($part)|escape}</textarea>
        {/if}
    {/if}
{/function}

{function name="formWidgetWysiwyg" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__text"}
        {else}
            {$attributes.class = 'form__text'}
        {/if}

        {$locale = $row->getOption('locale')}
        {if $locale}
            {$attributes["data-locale"] = $locale}
        {/if}

        {$validators = $row->getValidators()}
        {foreach $validators as $validator}
            {foreach $validator->getOptions() as $option => $value}
                {if $option == 'minimum'}
                    {$attributes.minlength = $value}
                {else if $option == 'maximum'}
                    {$attributes.maxlength = $value}
                {/if}
            {/foreach}
        {/foreach}

        <textarea name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >{$widget->getValue($part)|escape}</textarea>
    {/if}
{/function}

{function name="formWidgetRichcontent" form=null row=null part=null}
    {call formWidgetWysiwyg form=$form row=$row part=$part}
{/function}

{function name="formWidgetAssets" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {$safeName = $widget->getName()|replace:"[":"_"|replace:"]":"_"}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__assets-input"}
        {else}
            {$attributes.class = 'form__assets-input'}
        {/if}

        <div class="form__assets" data-field="{$attributes.id}"{if $widget->isMultiple()} data-max="999"{else} data-max="1"{/if}>
            {$assets = $widget->getAssets()}
            {foreach $assets as $asset}
                <div class="form__asset" data-id="{$asset->getId()}">
                    {if $asset->getThumbnail()}
                        <img src="{image src=$asset->getThumbnail() width=160 height=125 transformation='crop'}" alt="" class="image image--full-width" title="{$asset->getName()}"/>
                    {else}
                        {$imgSource = "asphalt/img/preview/`$asset->getType()`.png"}
                        <img src="{image src=$imgSource}" alt="" class="image" title="{$asset->getName()}"/>
                    {/if}
                    <a href="#" class="form__remove-asset">&times;</a>
                </div>
            {/foreach}
            <a href="#modalAssetsAdd-{$safeName}" class="form__add-assets btn btn--default"><i class="icon icon--plus"></i> {'button.add'|translate}</a>
        </div>

        {$value = $widget->getValue($part)}

        <input type="hidden"
               name="{$widget->getName()}"
               data-name="{$safeName}"
               value="{$value|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />

        <div class="modal modal--large fade" id="modalAssetsAdd-{$safeName}" tabindex="-1" role="dialog" aria-labelledby="myModalAssetsAdd" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        {if !isset($locale)}
                            {$locale = null}
                        {/if}
                        {if $widget->getFolderId()}
                            {url id="assets.folder.overview" parameters=["folder" => $widget->getFolderId(), "locale" => $locale] var="assetsUrl"}
                        {else}
                            {if $locale}
                                {url id="assets.overview.locale" parameters=["locale" => $locale] var="assetsUrl"}
                            {else}
                                {url id="assets.overview.locale" parameters=["locale" => $app.locale] var="assetsUrl"}
                            {/if}
                        {/if}
                        <iframe {* data-src="{$assetsUrl}?embed=1&amp;selected={$value|escape}" *} data-url="{$assetsUrl}?embed=1" frameborder="0" scrolling="no"></iframe>
                    </div>
                    <div class="modal-footer">
                        <div class="grid">
                            <div class="grid--bp-xsm__9">
                                <div class="form__assets form__assets--sml" data-field="{$attributes.id}"{if $widget->isMultiple()} data-max="999"{else} data-max="1"{/if}>
                                    {$assets = $widget->getAssets()}
                                    {foreach $assets as $asset}
                                        <div class="form__asset" data-id="{$asset->getId()}">
                                            <img src="{image src=$asset->getThumbnail() transformation='crop' width=40 height=40}" alt="" width="40" height="40">
                                            <a href="#" class="form__remove-asset">&times;</a>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                            <div class="grid--bp-xsm__3 text--right">
                                <button type="button" class="btn btn--default" data-dismiss="modal">{translate key="button.done"}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/function}

{function name="formWidgetOption" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {if $widget->isMultiple()}
            {$type = "checkbox"}
        {else}
            {$type = "radio"}
        {/if}

        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form__`$type`"}
        {else}
            {$attributes.class = "form__`$type`"}
        {/if}

        {$value = $widget->getValue()}
        {$options = $widget->getOptions()}
        {if $part !== null}
            {if isset($options.$part)}
            <input type="{$type}"
                   name="{$widget->getName()}{if $type == 'checkbox'}[{$part}]{/if}"
                   value="{$part}"
                   {if (!is_array($value) && strcmp($value, $part) == 0) || (is_array($value) && isset($value[$part]))}checked="checked"{/if}
                   {foreach $attributes as $name => $attribute}
                       {if $name == 'id'}
                            {$attribute = "`$attribute`-`$part`"}
                       {/if}
                       {$name}="{$attribute|escape}"
                   {/foreach}
             />
             {/if}
        {else}
            {if is_array($options)}
                <div>
                {foreach $options as $option => $label}
                    <div class="form__{$type}-item">
                        <label class="form__label form__label--checkbox">
                            <input type="{$type}"
                                   name="{$widget->getName()}{if $type == 'checkbox'}[]{/if}"
                                   value="{$option}"
                                   {if (!is_array($value) && strcmp($value, $option) == 0) || (is_array($value) && isset($value[$option]))}checked="checked"{/if}
                                   {foreach $attributes as $name => $attribute}
                                       {if $name == 'id'}
                                            {$attribute = "`$attribute`-`$option`"}
                                       {/if}
                                       {$name}="{$attribute|escape}"
                                   {/foreach}
                             />
                            {$label}
                        </label>
                    </div>
                {/foreach}
                </div>
            {else}
                <div class="form__checkbox-type">
                    <label class="form__label form__label--checkbox{if isset($attributes.disabled)} form__label--muted{/if}">
                        <input type="checkbox" name="{$widget->getName()}" value="1"{if $value} checked="checked"{/if}
                            {foreach $attributes as $name => $attribute}
                                {$name}="{$attribute|escape}"
                            {/foreach}
                        />
                        {$row->getDescription()}
                    </label>
                </div>
            {/if}
        {/if}
    {/if}
{/function}

{function name="formWidgetSelect" form=null row=null part=null class=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {$defaultClass = 'form__select'}
        {if $class}
            {$defaultClass = "`$defaultClass` `$class`"}
        {/if}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` `$defaultClass`"}
        {else}
            {$attributes.class = "`$defaultClass`"}
        {/if}

        {$value = $widget->getValue()}
        {$options = $widget->getOptions()}

        {*
            We don't want to break old sites so we check for false
            Old value is null
        *}
        {if $row->getOption('order') === false}
            {$attributes['data-order'] = 'false'}
        {else}
            {$attributes['data-order'] = 'true'}
        {/if}

        <select name="{$widget->getName()}{if $part !== null}[{$part}]{elseif $widget->isMultiple()}[]{/if}"
           {if $widget->isMultiple()} multiple="multiple"{/if}
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}

           {if $value}
              {if is_array($value)}
                 data-value="{foreach $value as $k => $v}{$k}{if !$v@last},{/if}{/foreach}"
              {else}
                 data-value="{$value}"
              {/if}
          {/if}
        >
            {* Print selected items first *}
            {if !is_array($value) && isset($value)}
                {if !is_object($value) && isset($options.$value)}
                    <option value="{$value|escape}" selected="selected">{$options[$value]}</option>
                {/if}
            {else}
                {foreach $value as $option}
                    {if $option|array_key_exists:$options}
                        <option value="{$option|escape}" selected="selected">{$options[$option]}</option>
                    {/if}
                {/foreach}
            {/if}

            {* Print other items *}
            {foreach $options as $option => $label}
                {if !isset($value) || (!is_array($value) && !strcmp($option, $value) == 0) || (is_array($value) && !isset($value[$option]))}
                    {if is_array($label)}
                        <optgroup label="{$option|escape}">
                            {foreach $label as $o => $l}
                                <option value="{$o|escape}"{if (!is_array($value) && strcmp($o, $value) == 0) || (is_array($value) && isset($value[$o]))} selected="selected"{/if}>{$l}</option>
                            {/foreach}
                        </optgroup>
                    {else}
                        <option value="{$option|escape}">{$label}</option>
                    {/if}
                {/if}
            {/foreach}
        </select>

    {/if}
{/function}

{function name="formWidgetFile" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {$value = $widget->getValue($part)}

        {if $value}
        <input type="hidden"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$value}" />
        {/if}
        <div>
            <input type="file"
                   name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               {foreach $attributes as $name => $attribute}
                   {$name}="{$attribute|escape}"
               {/foreach}
             />
         </div>

        {if $value}
        <div class="form__help">
            {$value}
            <a href="#" class="btn-file-delete" data-message="{translate key="label.confirm.file.delete"}">
                <i class="glyphicon glyphicon-remove"></i>
                {translate key="button.delete"}
            </a>
        </div>
        {/if}
    {/if}
{/function}

{function name="formWidgetImage" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {$value = $widget->getValue($part)}

        {if $value}
        <input type="hidden"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$value}" />
        {/if}
        <div>
            <input type="file"
                   name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               {foreach $attributes as $name => $attribute}
                   {$name}="{$attribute|escape}"
               {/foreach}
             />
         </div>

        {if $value}

        <div class="form__help">
            <div class="form__image-preview">
                <img src="{image src=$value transformation="crop" width=100 height=100}" title="{$value}" /><br>
                <a href="#" class="btn-file-delete js-file-delete" data-message="{translate key="label.confirm.file.delete"}"{if $attributes && array_key_exists('data-id', $attributes) && $attributes['data-id']} data-id="{$attributes['data-id']}"{/if}>
                    <i class="glyphicon glyphicon-remove"></i>
                    {translate key="button.delete"}
                </a>
            </div>
        </div>
        {/if}
    {/if}
{/function}


{*
    Renders a component control of the form
*}
{function name="formWidgetComponent" form=null row=null class=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {if $row->getType() == 'component'}
            {call formRows form=$form rows=$row->getRows() rowClass=$class}
        {else}
            <div class="error">No component row provided</div>
        {/if}
    {else}
        <div class="error">No row provided</div>
    {/if}
{/function}

{*
    Renders a collection control of the form
*}
{function name="formWidgetCollection" form=null row=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {$attributes = $row->getOption('attributes')}
    {if isset($attributes.class)}
        {$attributes.class = "`$attributes.class` collection-control-group sortables"}
    {else}
        {$attributes.class = 'collection-control-group sortables'}
    {/if}

    <div
       {foreach $attributes as $name => $attribute}
           {$name}="{$attribute|escape}"
       {/foreach}
     >

        {$widget = $row->getWidget()}
        {if $widget}
            {$values = $widget->getValue()}
            {foreach $values as $key => $value}
                {call formCollectionPrototype form=$form row=$row part=$key}
            {/foreach}
        {else}
            {$rows = $row->getRows()}
            {foreach $rows as $key => $r}
                {if $key !== '%prototype%'}
                    {call formCollectionPrototype form=$form row=$row part=$key}
                {/if}
            {/foreach}
        {/if}
    </div>

    {if !$row->getOption('disable_add')}
        {$label = $row->getOption('label_add')}
        {if !$label}
            {$label = "button.add"|translate}
        {/if}
        <a href="#" class="btn btn--default prototype-add{if $row->isDisabled() || $row->isReadOnly()} disabled{/if}"><i class="icon icon--plus"></i> {$label}</a>
    {/if}
{/function}

{*
    Renders a single collection control of the form
*}
{function name="formCollectionPrototype" form=null row=null part=null}
    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    <div class="collection-control sortable clearfix">
        <div class="order-handle sortable__handle"><i class="icon icon--bars"></i></div>
        <div class="grid">
            <div class="grid--bp-med__10">
            {$widget = $row->getWidget()}
            {if $widget}
                {call formWidget form=$form row=$row part=$part type=$widget->getType()}
            {else}
                {call formRow form=$form row=$row->getRow($part)}
            {/if}
            </div>
            {if !$row->getOption('disable_remove')}
            <div class="grid--bp-med__2">
                <a href="#" class="btn btn--default btn--xsmall prototype-remove{if $row->isDisabled() || $row->isReadOnly()} disabled{/if}"><i class="icon icon--times"></i></a>
            </div>
            {/if}
        </div>
    </div>
{/function}

{*
    Renders the form actions, if a referer is passed, a cancel button will be presented
*}
{function name="formActions" referer=null submit="button.save"}
    <div class="form__actions">
        <button type="submit" class="btn btn--brand">{translate key=$submit}</button>
        {if $referer}
            <a href="{$referer}" class="btn btn--link">{translate key="button.cancel"}</a>
        {/if}
    </div>
{/function}
