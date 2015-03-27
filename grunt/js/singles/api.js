$(function() {
    $(".source-toggle").click(function() {
        $(this).parent().next().toggle();

        return false;
    });

    $(".source").css("display", "none");
});
