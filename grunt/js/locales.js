$(".locales").sortable({
    axis: 'y',
    handle: 'h3',
    helper: 'clone',
    opacity: 0.5,
    update: function() {
        $.post($('.locales').data('url-order'), $(this).sortable('serialize'));
    }
});
$('.locales h3').css('cursor', 'move');

$(".btn-toggle-properties").click(function() {
    $($(this).data('target')).toggle();

    return false;
});
$('.locales .properties').hide();
