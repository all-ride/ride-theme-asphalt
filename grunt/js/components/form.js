window.rideApp = window.rideApp || {};
window.Parsley = window.Parsley || {};

$.extend(window.Parsley.options, {
  errorsContainer: function (ParsleyField) {
    return ParsleyField.$element.closest('.form__item');
  }
});

window.ParsleyValidator.setLocale('nl');

rideApp.formComponent = (function($, undefined) {
  var $forms = $('form');

  var _initialize = function() {
    $forms.on('click', 'button[type=submit]', this.submit);

    if ($forms.length && $forms.parsley().on !== undefined) {
      $forms.parsley().on('form:error', function() {
        _checkValidation(this.$element);
      });
      $forms.parsley().on('field:success', function() {
        _checkValidation(this.$element.parents('form'));
      });
    }
  };

  var _checkValidation = function($form) {
    // check if the form has tabs
    var $tabs = $form.find('.tabs__tab');

    $tabs.removeClass('error');
    if ($tabs.length) {
      $tabs.each(function() {
        var $tab = $(this),
            panelID = $tab.find('a').attr('href'),
            $errors = $(panelID).find('.parsley-error');
        if ($errors.length) {
          $tab.addClass('error');
        }
      });
    }
  };

  var _submit = function(e) {
    var $form = $(this.form);
    if ($form.data('is-submitted')) return false;
    if ($form.parsley().isValid()) {
      $form
        .data('is-submitted', true)
        .addClass('is-submitted');
    }
  };

  return {
    init: _initialize,
    submit: _submit
  };

})(jQuery);
