window.app=window.app||{},app.common=function(a){var b=(a(document),a(window)),c=a("html"),d=(a("body"),function(){this.windowResize(),b.on("resize",debounce(app.common.windowResize,250,!1)),this.svgFallback(),f()}),e=function(){a.extend(app.variables,{windowWidth:b.width(),windowHeight:b.height()})},f=function(){a("#toggle-flyout-nav").flyoutNav({back:function(){return'<span class="icon -previous"></span> Terug'}})},g=function(){if(!Modernizr.svg){var b=a("html"),c=a('img[src$=".svg"]');c.each(function(c,d){var e=a(d),f=e.attr("data-url"),g=e.attr("width"),h=e.attr("height");e.attr("src",f),b.hasClass("lt-ie9")&&e.parent("a").css({width:g,height:h})})}},h=function(){var b=a(".toggle-menu"),c=a("[class*=pane-menu-sidebar]"),d=a("span",c);b.on("click",function(a){a.preventDefault(),c.toggle()}),d.on("click",function(b){b.preventDefault(),a(this).next("ul").toggle()})},i=function(){function a(){c.hasClass(d)||c.addClass(d)}var d="js-done";b.on("load",function(){c.addClass(d)}),window.setTimeout(a,4e3)};return{init:d,windowResize:e,toggleSubmenu:h,svgFallback:g,finalize:i}}(jQuery),window.debounce=function(a,b,c){var d;return function(){var e=this,f=arguments,g=function(){d=null,c||a.apply(e,f)},h=c&&!d;clearTimeout(d),d=setTimeout(g,b),h&&a.apply(e,f)}};