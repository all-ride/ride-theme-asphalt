<?php

use ride\library\html\Pagination;

function smarty_function_pagination($params, &$smarty) {
    $page = 0;
    $pages = null;
    $href = null;
    $onclick = null;
    $label = null;
    $class = null;
    $pagination = null;

    foreach ($params as $k => $v) {
        switch ($k) {
            case 'label':
            case 'page':
            case 'pages':
            case 'href':
            case 'onclick':
            case 'class':
            case 'pagination':
                $$k = $v;
                break;
        }
    }

    if ($pagination === null) {
        $pagination = new Pagination($pages, $page);
        $pagination->setHref($href);
        $pagination->setOnclick($onclick);
    }

    if ($label) {
        $pagination->setLabel($label);
    }
    if ($class) {
        $pagination->setClass($class);
    }

    $anchors = $pagination->getAnchors();

    $html = '<ul class="pagination">';
    foreach ($anchors as $anchor) {
        $html .= '<li>' . $anchor->getHtml() . '</li>';
    }
    $html .= '</ul>';

    return $html;
}
