function updateQueryStringParameter(a,b,c){var d=new RegExp("([?&])"+b+"=.*?(&|$)","i"),e=a.indexOf("?")!==-1?"&":"?";return a.match(d)?a.replace(d,"$1"+b+"="+c+"$2"):a+e+b+"="+c}function escapeID(a){return"#"+a.replace(/(:|\.|\[|\]|\%|\<|\>|,)/g,"\\$1")}var rideApp=rideApp||{};rideApp.form=function(a,b){var c=a(document),d=new JsonApiClient("/api/v1"),e=function(){g(),h(),jQuery.fn.sortable&&i(),k(),l(),this.assets.init(),ready("[maxlength]",function(){rideApp.form.checkLength.init(a(this),!1)}),ready("[data-recommended-maxlength]",function(){rideApp.form.checkLength.init(a(this),!0)}),a("[data-toggle-dependant]").on("change",function(){n(a(this))}).each(function(){n(a(this))}),f()},f=function(){function b(a,b,c){d.load("image-styles",a,function(a){e(g,a,b,c)})}function e(a,b,c,e){var g=d.url+"/asset-image-styles?filter[exact][asset]="+a.id+"&filter[exact][style]="+b.id+"&fields[asset-image-styles]=id",h=c.getCroppedCanvas().toDataURL();d.sendRequest("GET",g,null,function(g){if(g.length)g[0].setAttribute("image",h),d.save(g[0],function(a){f(e,c,h,a.id)});else{var i=new JsonApiDataStoreModel("asset-image-styles");i.setRelationship("asset",a),i.setRelationship("style",b),i.setAttribute("image",h),d.save(i,function(a){f(e,c,h,a.id)})}})}function f(a,b,c,d){var e=a.find(".js-crop-preview"),f=a.find(".js-image-style-crop"),g=a.find(".js-image-style-file");f.removeClass("is-loading"),f.find(".js-crop-toggle").removeClass("superhidden").next(".js-crop-image").addClass("superhidden"),e.html(j({dataUrl:c,id:d})).removeClass("superhidden"),b.destroy(),g.removeClass("superhidden").find(".form__image-preview").addClass("superhidden"),alertify.logPosition("bottom right").success(h)}var g=null,h=rideApp.translator.translate("label.image.style.added"),i=rideApp.translator.translate("label.image.style.removed"),j=_.template(a("#form-image-preview-template").html());a(".js-image-style").each(function(){var c,e=a(this),f=e.find(".js-image-style-crop"),h=e.find(".js-image-style-file"),i=f.data("asset"),j=f.data("style"),k=f.data("ratio");f.find(".js-crop-toggle").on("click",function(b){b.preventDefault(),h.addClass("superhidden");var d=a(this).addClass("superhidden").next(".js-crop-image").removeClass("superhidden");d[0].querySelector(".js-enable-cropper");c=new Cropper(d.find(".js-enable-cropper")[0],{aspectRatio:k,zoomOnWheel:!1,movable:!1})}),f.find(".js-crop-save").on("click",function(a){a.preventDefault(),f.addClass("is-loading"),g?b(j,c,e):d.load("assets",i,function(a){g=a,b(j,c,e)})})}),c.on("click",".assets__image-styles .js-file-delete",function(b){b.preventDefault();var c=a(this);if(confirm(c.data("message"))){var e=c.data("id"),f=c.closest(".js-crop-preview"),g=c.closest(".form__image-preview"),h=d.url+"/asset-image-styles/"+e;d.sendRequest("DELETE",h,null,function(){g.remove(),f.addClass("superhidden"),alertify.logPosition("bottom right").success(i)})}})},g=function(){c.on("click",".btn-file-delete:not(.assets__image-styles .btn-file-delete)",function(b){b.preventDefault();var c=a(this);confirm(c.data("message"))&&(c.closest(".form__item").find("input[type=hidden]").val(""),c.parent("div").remove())})},h=function(){c.on("click",".prototype-add:not(.disabled)",function(b){b.preventDefault();var c=a(this).closest(".collection-controls"),d=c.attr("data-prototype"),e=c.attr("data-index");e||(e=a(".collection-control",c).length),d=d.replace(/%prototype%/g,"prototype-"+e),a(".collection-control-group",c).first().append(d),e++,c.attr("data-index",e),c.trigger("collectionAdded")}),c.on("click",".prototype-remove:not(.disabled)",function(b){if(b.preventDefault(),confirm("Are you sure you want to remove this item?")){var c=a(this).closest(".collection-control");c.trigger("collectionRemoved"),c.remove()}})},i=function(){a("[data-order=true] .collection-control-group").sortable({axis:"y",cursor:"move",handle:".order-handle",items:"> .collection-control",select:!1,scroll:!0})},j={init:function(b,c){if(!b.length)return!1;if(c)var d=b.attr("data-recommended-maxlength");else var d=b.attr("maxlength");if(!d)return!1;var e=a('<div class="form__countdown" />').insertAfter(b);rideApp.form.checkLength.updateCount(b,e,d,c),b.on("keyup",function(){rideApp.form.checkLength.updateCount(b,e,d,c)})},updateCount:function(a,b,c,d){var e=a.val().length,f=parseInt(c,10);if(d){var g=f-e;b.text(rideApp.translator.translate("label.length.recommended")+": "+g+"/"+c),g<0?b.addClass("text--warning"):b.removeClass("text--warning")}else{var g=f-e>=0?f-e:0;b.text(g+"/"+c)}if(g<=0&&!d)return!1}},k=function(){function b(){var b=d.find("select:visible:not(.selectized)");b.each(function(b,c){var d=a.extend(!0,{},e);"true"===c.dataset.order&&d.plugins.push("drag_drop"),a(c).selectize(d).addClass("selectized")})}if(jQuery.fn.selectize){var d=a(".form--selectize"),e={plugins:["remove_button"]};b(),a('a[data-toggle="tab"]').on("shown.bs.tab",function(a){b()}),c.on("collectionAdded",function(){b()})}},l=function(){function c(c){var d=c.data("autocomplete-url"),e=c.data("autocomplete-max-items"),f=c.data("autocomplete-min-length"),g=c.data("autocomplete-type"),h=c.data("autocomplete-locale"),i={},j=[];h&&(i["Accept-Language"]=h),1!=e&&j.push("drag_drop","remove_button");var k={valueField:"name",labelField:"name",searchField:"name",plugins:j,create:!!c.hasClass("js-tags"),load:function(c,e){if(!c.length||f&&c.length<f)return e();var h=d;h=h.replace(/%25term%25/g,c),h=h.replace(/%term%/g,c),window.overlaySelector=b,a.ajax({url:h,headers:i,success:function(b){"jsonapi"===g?res=b.meta.list:res=b;var c=a.map(res,function(a){return{name:a}});e(c)}})}};0!=e&&(k.maxItems=e),c.selectize(k)}jQuery.fn.selectize&&ready("[data-autocomplete-url]",function(b){c(a(b))})},m={allAssets:function(){return c.find(".form__assets")},modalTriggers:function(){return c.find(".form__add-assets")},removeTriggers:function(){return c.find(".form__remove-asset")},iframes:[],init:function(){var b=rideApp.form.assets.modalTriggers(),c=rideApp.form.assets.removeTriggers();ready(".form__assets",function(){b=rideApp.form.assets.modalTriggers(),c=rideApp.form.assets.removeTriggers();var d=a(this),e=d.data("field"),f=(a(escapeID(e)),d.find(".form__edit-assets"));f.text(),d.find(".form__add-assets");rideApp.form.assets.checkAssetsLimit(),d.sortable({items:".form__asset"}).on("sortstop",function(a,b){rideApp.form.assets.setAssetsOrder(d)}).disableSelection(),b.on("click",function(b){b.preventDefault();var c=a(this).attr("disabled");if("disabled"!==c){var d=a(this),e=a(this).attr("href"),f=a(e),g=f.find(".modal-footer"),h=f.find("iframe"),i=d.closest(".form__assets"),j=rideApp.form.assets.getSelected(i),k=h.data("url"),l=k.indexOf("?"),m={};l>=0&&(m=queryString.parse(k.slice(l)),k=k.slice(0,l+1)),m.selected=j,h.attr("src",k+queryString.stringify(m)),h.on("load",function(b){var c=a(this),d=c.contents(),e=a(this.contentWindow),h=this.contentWindow.location.pathname,i=d.find("body").height();i&&c.animate({height:i},Math.abs(c.height()-i),"linear",function(){g.toggle("add"!=h.split("/").pop()),f.removeClass("is-loading")}),e.on("beforeunload",function(){g.hide(),f.addClass("is-loading"),c.css({height:""})})}),f.on("show.bs.modal",function(){g.hide(),a(this).addClass("is-loading")}),f.on("hidden.bs.modal",function(){h.removeAttr("src style"),g.removeAttr("style"),a(this).removeClass("is-loading")}),f.modal("show")}})}),ready(".form__remove-asset",function(){this.addEventListener("click",function(a){a.preventDefault(),rideApp.form.assets.removeAsset(this)})})},getSelected:function(b){var c=b.data("field"),d=a("#"+c);return d.val()},setAssetsOrder:function(b){var c=b.sortable("toArray",{attribute:"data-id"}),d=b.data("field"),e=a("#"+d);e[0].value=c.join(",");var f=rideApp.form.assets.allAssets().filter('[data-field="'+d+'"] ').not(b);f.find(".form__asset").detach(),f.prepend(b.find(".form__asset").clone())},checkAssetsLimit:function(){var b=a(".form__assets");b.each(function(){var b=a(this),c=b.data("max"),d=b.find(".form__add-assets");b.find(".form__asset").length>=c?d.attr("disabled",!0):d.attr("disabled",!1)})},removeAsset:function(b){var c=a(b).parent(),d=c.parent(),e=c.data("id"),f=d.data("field"),g=(a("#"+f),a('[data-field="'+f+'"] [data-id="'+e+'"]'));g.addClass("is-removed").on("webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend",function(){g.remove(),rideApp.form.assets.setAssetsOrder(d),rideApp.form.assets.checkAssetsLimit()})},addAsset:function(b,c,d){var e=a(".modal.in"),f=e.find(".form__assets"),g=f.data("field"),h=(a("#"+g),a('[data-field="'+g+'"]')),i=h.find(".form__asset"),j=f.data("max"),k=h.find('[data-id="'+b+'"]');if(k.length||i.length>=j)return k.find(".form__remove-asset").each(function(){rideApp.form.assets.removeAsset(this)}),!1;var l=a('<div class="form__asset" data-id="'+b+'"><img src="'+d+'" alt="'+c+'"><a href="#" class="form__remove-asset">×</a></div>');return i.last().length?l.insertAfter(i.last()):l.prependTo(h),rideApp.form.assets.checkAssetsLimit(),rideApp.form.assets.setAssetsOrder(f),rideApp.form.assets.init(),!0},resizeIframe:function(b,c){a("iframe",b.document).height(c)}},n=function(b){var c=b.parents("form"),d=b.data("toggle-dependant"),e=c.find('[name^="'+b.attr("name")+'"]'),f=e.filter(":checked"),g=f.length?f.val():null;a("."+d,c).parents(".form__item").hide(),a("."+d+"-"+g,c).parents(".form__item").show()};return{initialize:e,checkLength:j,assets:m}}(jQuery),$(document).ready(function(){rideApp.form.initialize()}),$.fn.formDependantRows=function(){var a=function(a){var b=a.parents("form"),c=a.data("toggle-dependant"),d=a.filter(":checked").length?a.val():null;$("."+c,b).parents(".form-group").hide(),$("."+c+"-"+d,b).parents(".form-group").show()};$("[data-toggle-dependant]",$(this)).on("change",function(){a($(this))}).each(function(){a($(this))})};