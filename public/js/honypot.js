$.fn.honeyPot=function(a){var b=$(this);$(a.fields).each(function(a,c){var d=$("input[name="+c+"]",b);if(0!==d.length){{d.data("value")}d.parents(".form-group").hide()}}),b.on("submit",function(){var c="";$(a.fields).each(function(a,d){var e=$("input[name="+d+"]",b);c+=(""===c?"":",")+e.val()}),$("input[name=honeypot-submit]",b).val(c)})};