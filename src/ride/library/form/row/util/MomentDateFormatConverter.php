<?php

namespace ride\library\form\row\util;

use ride\library\form\exception\FormException;

/**
 * Converter of date formats between MomentJS and PHP
 */
class MomentDateFormatConverter {

    /**
     * Array with PHP date format characters as key and MomentJS format characters as value
     * @var array
     */
    private $formatCharacters = array(
        'j' => 'D',
        'd' => 'DD',
        'D' => 'ddd',
        'l' => 'dddd',
        'n' => 'M',
        'm' => 'MM',
        'M' => 'MMM',
        'F' => 'MMMM',
        'y' => 'YY',
        'Y' => 'YYYY',
    );

    /**
     * Convert a PHP date format to MomentJS format
     * @param string $format PHP date format
     * @return string Datepicker date format of the PHP date format
     */
    public function convertFormatFromPhp($format) {
        if (!is_string($format) || !$format) {
            throw new FormException('Provided format is empty or invalid');
        }

        $converted = '';
        $length = strlen($format);

        for ($i = 0; $i < $length; $i++) {
            $char = $format[$i];
            if (isset($this->formatCharacters[$char])) {
                $converted .= $this->formatCharacters[$char];
            } else {
                $converted .= $char;
            }
        }

        return $converted;
    }

}
