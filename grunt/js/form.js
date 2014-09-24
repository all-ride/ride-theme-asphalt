$.fn.formCollection = function() {
    $(this).on('click', '.prototype-add:not(.disabled)', function() {
        var parent = $(this).parent('.collection-controls');
        var prototype = parent.attr('data-prototype');
        var index = parent.attr('data-index');
        if (!index) {
            index = $('.collection-control', parent).length;
        }

        prototype = prototype.replace(/%prototype%/g, 'prototype-' + index);

        // add prototype to the container
        $('.collection-control-group', parent).first().append(prototype);

        // increase the index for the next addition
        index++;

        parent.attr('data-index', index);

        return false;
    });

    $(this).on('click', '.prototype-remove:not(.disabled)', function() {
        if (confirm('Are you sure you want to remove this item?')) {
            $(this).parents('.collection-control').remove();
        }

        return false;
    });

    $('[data-order=true] .collection-control-group').sortable({
        axis: "y",
        cursor: "move",
        handle: ".order-handle",
        items: "> .collection-control",
        select: false,
        scroll: true
    });
};

$.fn.formFile = function() {
    $(this).on('click', '.btn-file-delete', function() {
        var anchor = $(this);
        if (confirm(anchor.data('message'))) {
            anchor.parents('.form-group').find('input[type=hidden]').val('');
            anchor.parent('div').remove();
        }

        return false;
    });
};

$(function() {
    $('form[role=form]').formCollection();
    $('form[role=form]').formFile();
});
