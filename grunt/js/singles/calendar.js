$.fn.performanceForm = function() {
    var $this = $(this);

    var handleDateFields = function() {
        var isDay = $('input[name=isDay]', $this).is(':checked');
        var isPeriod = $('input[name=isPeriod]', $this).is(':checked');

        if (isDay) {
            $('.time', $this).hide();
        } else {
            $('.time', $this).show();
        }

        if (isPeriod) {
            $('input[name=dateStop]', $this).show();
        } else {
            $('input[name=dateStop]', $this).hide();
        }

        if (!isPeriod && isDay) {
            $('.until', $this).hide();
        } else {
            $('.until', $this).show();
        }
    };

    var handleRepeater = function() {
        var isRepeat = $('input[name=isRepeat]', $this).is(':checked');

        if (isRepeat) {
            $('.repeater', $this).show();

            var mode = $('select[name=mode]', $this).val();
            $('.step', $this).hide();
            $('.step-' + mode, $this).show();

            if (mode == 'weekly') {
                $('.form__item--weekly').show();
                $('.form__item--monthly').hide();
            } else if (mode == 'monthly') {
                $('.form__item--weekly').hide();
                $('.form__item--monthly').show();
            } else {
                $('.form__item--weekly').hide();
                $('.form__item--monthly').hide();
            }
        } else {
            $('.repeater', $this).hide();
        }
    };

    $this.on('change', 'input[name=isDay]', handleDateFields);
    $this.on('change', 'input[name=isPeriod]', handleDateFields);
    $this.on('change', 'input[name=isRepeat]', handleRepeater);
    $this.on('change', 'select[name=mode]', handleRepeater);

    handleDateFields();
    handleRepeater();
};

$(function() {
    $('#form-event-performance').performanceForm();
});
