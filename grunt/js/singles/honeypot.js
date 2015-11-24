$.fn.honeyPot = function(options) {
    var $this = $(this);

    $(options.fields).each(function(index, value) {
        var $input = $('input[name*="[' + value + ']"]', $this);
        if ($input.length === 0) {
            return;
        }

        var defaultValue = $input.data('value');
        if (defaultValue) {
            $input.val(defaultValue);
        }

        $input.parents('.form__item').hide();
    });

    $this.on('submit', function() {
        var submitValue = '';

        $(options.fields).each(function(index, name) {
            var $input = $('input[name*="[' + name + ']"]', $this),
                value = $input.val();

            if (value === '') {
                value = name;
            } else {
                value = name + ':' + value;
            }

            submitValue += (submitValue === '' ? '' : ',') + value;
        });

        $(options.submit, $this).val(submitValue);
    });
};


var rideApp = rideApp || {};

function findAncestor(el, cls) {
    while ((el = el.parentElement) && !el.classList.contains(cls));
    return el;
}
