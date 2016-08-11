<?php

namespace ride\library\form\row;

use ride\library\form\row\util\MomentDateFormatConverter;
use ride\library\form\widget\DateWidget;

/**
 * Date row
 */
class AsphaltDateRow extends DateRow implements HtmlRow {

    /**
     * Default date format
     * @var string
     */
    const DATE_FORMAT = 'd/m/Y';

    /**
     * Gets the date format
     * @return string
     */
    public function getFormat() {
        return $this->getOption(self::OPTION_FORMAT, static::DATE_FORMAT);
    }

    /**
     * Creates the widget for this row
     * @param string $name
     * @param mixed $default
     * @param array $attributes
     * @return \ride\library\form\widget\Widget
     */
    protected function createWidget($name, $default, array $attributes) {
        $format = $this->getFormat();

        $dateConverter = new MomentDateFormatConverter();

        $attributes['data-format-php'] = $format;
        $attributes['data-format'] = $dateConverter->convertFormatFromPhp($format);

        return new DateWidget('date', $name, $default, $attributes);
    }

    /**
     * Gets all the javascript files which are needed for this row
     * @return array
     */
    public function getJavascripts() {
        return array('js/moment.js', 'js/pikaday.js');
    }

    /**
     * Gets all the inline javascripts which are needed for this row
     * @return array
     */
    public function getInlineJavascripts() {
        return array();
    }

    /**
     * Gets all the stylesheets which are needed for this row
     * @return array
     */
    public function getStyles() {
        return array();
    }

}
