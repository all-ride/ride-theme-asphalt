$.fn.performanceForm = function() {
    var $this = $(this);

    var handleDateFields = function() {
        var isDay = $('input[name="date[isDay]"]', $this).is(':checked');
        var isPeriod = $('input[name="date[isPeriod]"]', $this).is(':checked');

        if (isDay) {
            $('.time', $this).hide();
        } else {
            $('.time', $this).show();
        }

        if (isPeriod) {
            $('input[name="date[dateStop]"]', $this).show();
        } else {
            $('input[name="date[dateStop]"]', $this).hide();
        }

        if (!isPeriod && isDay) {
            $('.until', $this).hide();
        } else {
            $('.until', $this).show();
        }
    };

    var handleRepeater = function() {
        var isRepeat = $('input[name="date[isRepeat]"]', $this).is(':checked');

        if (isRepeat) {
            $('.repeater', $this).show();

            var mode = $('select[name="date[mode]"]', $this).val();
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

    $this.on('change', 'input[name="date[isDay]"]', handleDateFields);
    $this.on('change', 'input[name="date[isPeriod]"]', handleDateFields);
    $this.on('change', 'input[name="date[isRepeat]"]', handleRepeater);
    $this.on('change', 'select[name="date[mode]"]', handleRepeater);

    handleDateFields();
    handleRepeater();
};

$(function() {
    $('#form-event-performance').performanceForm();
});
