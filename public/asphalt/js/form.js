function updateQueryStringParameter(a,b,c){var d=new RegExp("([?&])"+b+"=.*?(&|$)","i"),e=-1!==a.indexOf("?")?"&":"?";return a.match(d)?a.replace(d,"$1"+b+"="+c+"$2"):a+e+b+"="+c}function escapeID(a){return"#"+a.replace(/(:|\.|\[|\]|\%|\<|\>|,)/g,"\\$1")}var rideApp=rideApp||{};rideApp.form=function(a,b){var c=a(document),d=new JsonApiClient("/api/v1"),e=function(){g(),h(),jQuery.fn.sortable&&i(),k(),l(),this.assets.init(),ready("[maxlength]",function(){rideApp.form.checkLength.init(a(this),!1)}),ready("[data-recommended-maxlength]",function(){rideApp.form.checkLength.init(a(this),!0)}),a("[data-toggle-dependant]").on("change",function(){n(a(this))}).each(function(){n(a(this))}),f(),rideApp.translator.submitTranslationKeys()},f=function(){function b(a,b,c){d.load("image-styles",a,function(a){e(g,a,b,c)})}function e(a,b,c,e){var g=d.url+"/asset-image-styles?filter[exact][asset]="+a.id+"&filter[exact][style]="+b.id+"&fields[asset-image-styles]=id",h=c.getCroppedCanvas().toDataURL();d.sendRequest("GET",g,null,function(g){if(g.length)g[0].setAttribute("image",h),d.save(g[0],function(a){f(e,c,h,a.id)});else{var i=new JsonApiDataStoreModel("asset-image-styles");i.setRelationship("asset",a),i.setRelationship("style",b),i.setAttribute("image",h),d.save(i,function(a){f(e,c,h,a.id)})}})}function f(a,b,c,d){var e=a.find(".js-crop-preview");a.removeClass("is-loading"),a.find(".js-crop-toggle").removeClass("superhidden").next(".js-crop-image").addClass("superhidden"),e.html(j({dataUrl:c,id:d})).removeClass("superhidden"),b.destroy(),a.prev(".form__group").find(".form__image-preview").addClass("superhidden"),alertify.logPosition("bottom right").success(h)}var g=null,h=rideApp.translator.translate("label.image.style.added"),i=rideApp.translator.translate("label.image.style.removed"),j=_.template(a("#form-image-preview-template").html());a(".asset__crop").each(function(){var c,e=a(this),f=e.data("asset"),h=e.data("style"),i=e.data("ratio");e.find(".js-crop-toggle").on("click",function(b){b.preventDefault(),e.find(".js-crop-preview").addClass("superhidden");var d=a(this).addClass("superhidden").next(".js-crop-image").removeClass("superhidden");d[0].querySelector(".js-enable-cropper");c=new Cropper(d.find(".js-enable-cropper")[0],{aspectRatio:i,zoomOnWheel:!1,movable:!1})}),e.find(".js-crop-save").on("click",function(a){a.preventDefault(),e.addClass("is-loading"),g?b(h,c,e):d.load("assets",f,function(a){g=a,b(h,c,e)})})}),c.on("click",".assets__image-styles .js-file-delete",function(b){b.preventDefault();var c=a(this);if(confirm(c.data("message"))){var e=c.data("id"),f=c.closest(".js-crop-preview"),g=c.closest(".form__image-preview"),h=d.url+"/asset-image-styles/"+e;d.sendRequest("DELETE",h,null,function(){g.remove(),f.addClass("superhidden"),alertify.logPosition("bottom right").success(i)})}})},g=function(){c.on("click",".btn-file-delete:not(.assets__image-styles .btn-file-delete)",function(b){b.preventDefault();var c=a(this);confirm(c.data("message"))&&(c.closest(".form__item").find("input[type=hidden]").val(""),c.parent("div").remove())})},h=function(){c.on("click",".prototype-add:not(.disabled)",function(b){b.preventDefault();var c=a(this).parent(".collection-controls"),d=c.attr("data-prototype"),e=c.attr("data-index");e||(e=a(".collection-control",c).length),d=d.replace(/%prototype%/g,"prototype-"+e),a(".collection-control-group",c).first().append(d),e++,c.attr("data-index",e),c.trigger("collectionAdded")}),c.on("click",".prototype-remove:not(.disabled)",function(b){if(b.preventDefault(),confirm("Are you sure you want to remove this item?")){var c=a(this).closest(".collection-control");c.trigger("collectionRemoved"),c.remove()}})},i=function(){a("[data-order=true] .collection-control-group").sortable({axis:"y",cursor:"move",handle:".order-handle",items:"> .collection-control",select:!1,scroll:!0})},j={init:function(b,c){if(!b.length)return!1;if(c)var d=b.attr("data-recommended-maxlength");else var d=b.attr("maxlength");if(!d)return!1;var e=a('<div class="form__countdown" />').insertAfter(b);rideApp.form.checkLength.updateCount(b,e,d,c),b.on("keyup",function(){rideApp.form.checkLength.updateCount(b,e,d,c)})},updateCount:function(a,b,c,d){var e=a.val().length,f=parseInt(c,10);if(d){var g=f-e;b.text(rideApp.translator.translate("label.length.recommended")+": "+g+"/"+c),0>g?b.addClass("text--warning"):b.removeClass("text--warning")}else{var g=f-e>=0?f-e:0;b.text(g+"/"+c)}return 0>=g&&!d?!1:void 0}},k=function(){if(jQuery.fn.selectize){var b=(a(".form--selectize"),{plugins:["drag_drop","remove_button"]});a(".form--selectize select:visible:not(.selectized)").selectize(b).addClass("selectized"),a('a[data-toggle="tab"]').on("shown.bs.tab",function(c){a(".form--selectize select:visible").selectize(b)}),c.on("collectionAdded",function(){a(".form--selectize select:visible:not(.selectized)").selectize(b).addClass("selectized")})}},l=function(){function b(b){var c=b.data("autocomplete-url"),d=b.is("[data-autocomplete-multiple]"),e=b.data("autocomplete-type"),f=b.data("autocomplete-locale"),g={},h=[];f&&(g["Accept-Language"]=f),d&&h.push("drag_drop","remove_button");var i={valueField:"name",labelField:"name",searchField:"name",maxItems:d?null:1,plugins:h,create:b.hasClass("js-tags")?!0:!1,load:function(b,d){if(!b.length)return d();var f=c;f=f.replace(/%25term%25/g,b),f=f.replace(/%term%/g,b),a.ajax({url:f,headers:g,success:function(b){"jsonapi"===e?res=b.meta.list:res=b;var c=a.map(res,function(a){return{name:a}});d(c)}})}};b.selectize(i)}jQuery.fn.selectize&&ready("[data-autocomplete-url]",function(c){b(a(c))})},m={allAssets:function(){return c.find(".form__assets")},modalTriggers:function(){return c.find(".form__add-assets")},removeTriggers:function(){return c.find(".form__remove-asset")},iframes:[],init:function(){var b=rideApp.form.assets.modalTriggers();rideApp.form.assets.removeTriggers();ready(".form__assets",function(){var c=a(this),d=c.data("field"),e=(a(escapeID(d)),c.find(".form__edit-assets"));e.text(),c.find(".form__add-assets");rideApp.form.assets.checkAssetsLimit(),c.sortable({items:".form__asset"}).on("sortstop",function(a,b){rideApp.form.assets.setAssetsOrder(c)}).disableSelection(),b.on("click",function(b){b.preventDefault();var c=a(this).attr("disabled");if("disabled"!==c){var d=a(this),e=a(this).attr("href"),f=a(e),g=f.find("iframe"),h=d.closest(".form__assets"),i=rideApp.form.assets.getSelected(h),j=g.data("url"),k=j.indexOf("?"),l={};k>=0&&(l=queryString.parse(j.slice(k)),j=j.slice(0,k+1)),l.selected=i,g.attr("src",j+queryString.stringify(l)),f.modal("show").on("hidden.bs.modal",function(){g.attr("src","")})}})}),ready(".form__remove-asset",function(){this.addEventListener("click",function(a){a.preventDefault(),rideApp.form.assets.removeAsset(this)})})},getSelected:function(b){var c=b.data("field"),d=a("#"+c);return d.val()},setAssetsOrder:function(b){var c=b.sortable("toArray",{attribute:"data-id"}),d=b.data("field"),e=a("#"+d);e[0].value=c.join(",");var f=rideApp.form.assets.allAssets().filter('[data-field="'+d+'"] ').not(b);f.find(".form__asset").detach(),f.prepend(b.find(".form__asset").clone())},checkAssetsLimit:function(){var b=a(".form__assets");b.each(function(){var b=a(this),c=b.data("max"),d=b.find(".form__add-assets");b.find(".form__asset").length>=c?d.attr("disabled",!0):d.attr("disabled",!1)})},removeAsset:function(b){var c=a(b).parent(),d=c.parent(),e=c.data("id"),f=d.data("field"),g=(a("#"+f),a('[data-field="'+f+'"] [data-id="'+e+'"]'));g.addClass("is-removed").on("webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend",function(){g.remove(),rideApp.form.assets.setAssetsOrder(d),rideApp.form.assets.checkAssetsLimit()})},addAsset:function(b,c,d){var e=a(".modal.in"),f=e.find(".form__assets"),g=f.data("field"),h=(a("#"+g),a('[data-field="'+g+'"]')),i=h.find(".form__asset"),j=f.data("max"),k=h.find('[data-id="'+b+'"]');if(k.length||i.length>=j)return k.find(".form__remove-asset").each(function(){rideApp.form.assets.removeAsset(this)}),!1;var l=a('<div class="form__asset" data-id="'+b+'"><img src="'+d+'" alt="'+c+'"><a href="#" class="form__remove-asset">×</a></div>');return i.last().length?l.insertAfter(i.last()):l.prependTo(h),rideApp.form.assets.checkAssetsLimit(),rideApp.form.assets.setAssetsOrder(f),rideApp.form.assets.init(),!0},resizeIframe:function(b,c){a("iframe",b.document).height(c)}},n=function(b){var c=b.parents("form"),d=b.data("toggle-dependant"),e=c.find('[name^="'+b.attr("name")+'"]'),f=e.filter(":checked"),g=f.length?f.val():null;a("."+d,c).parents(".form__item").hide(),a("."+d+"-"+g,c).parents(".form__item").show()};return{initialize:e,checkLength:j,assets:m}}(jQuery),$(document).ready(function(){rideApp.form.initialize()}),$.fn.formDependantRows=function(){var a=function(a){var b=a.parents("form"),c=a.data("toggle-dependant"),d=a.filter(":checked").length?a.val():null;$("."+c,b).parents(".form-group").hide(),$("."+c+"-"+d,b).parents(".form-group").show()};$("[data-toggle-dependant]",$(this)).on("change",function(){a($(this))}).each(function(){a($(this))})};