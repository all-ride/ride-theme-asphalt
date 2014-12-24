$.fn.honeyPot = function(options) {
    var $this = $(this);

    $(options.fields).each(function(index, value) {
        var $input = $('input[name=' + value + ']', $this);
        if ($input.length === 0) {
            return;
        }

        var defaultValue = $input.data('value');
        if (defaultValue) {
            // $input.val(defaultValue);
        }

        $input.parents('.form__item').hide();
    });

    $this.on('submit', function() {
        var submitValue = '';

        $(options.fields).each(function(index, value) {
            var $input = $('input[name=' + value + ']', $this);

            submitValue += (submitValue === '' ? '' : ',') + $input.val();
        });

        $('input[name=honeypot-submit]', $this).val(submitValue);
    });
};


var rideApp = rideApp || {};

function findAncestor(el, cls) {
    while ((el = el.parentElement) && !el.classList.contains(cls));
    return el;
}

rideApp.honeyPot = function(form, options) {
    [].prototype.forEach.call(options.fields, function(field) {
        var input = form.querySelector('input[name=' + value + ']'),
            defaultValue,
            group;
        if (input.length === 0) {
            return;
        }

        defaultValue = input.dataset.value;
        if (defaultValue) {
            input.value = defaultValue;
        }

        group = findAncestor(input, 'form__item');
        group.style.display = 'none';
    });
};
