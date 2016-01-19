var $document = $(document),
    $defaultOverlay = $('.ajax-overlay');

function getAjaxOverlay() {
    if (window.overlaySelector !== null) {
        return $(window.overlaySelector);
    }

    return $defaultOverlay;
}

$(document).ajaxStart(function(e) {
    getAjaxOverlay().show();
});

$(document).ajaxStop(function() {
    getAjaxOverlay().hide();
    window.overlaySelector = null;
});
