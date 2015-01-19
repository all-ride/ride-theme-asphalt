{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.image.processor"} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{translate key="title.image.processor"}</h1>
    </div>
{/block}

{block name="content_body" append}
    <div class="grid--bp-med__9">
        <img src="{image src=$path}" id="image-input" />
    </div>

    <div class="grid--bp-med__3">
        {include file="base/form.prototype"}
        <form id="{$form->getId()}" class="form-horizontal" enctype="multipart/form-data" method="post" action="{$app.url.request}" name="{$form->getId()}" role="form">
            {call formRows form=$form}

            <input type="submit" class="btn btn--default btn-lg" value="{translate key="button.save.image"}" />
            {if $referer}
                <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
            {/if}
        </form>

        <h3>{translate key="image.processor.label.instruction"}</h3>
        <ul>
            <li>{translate key="image.processor.label.instruction1"}</li>
            <li>{translate key="image.processor.label.instruction2"}</li>
        </ul>
    </div>
{/block}

{block name="styles" append}
    <link rel="stylesheet" type="text/css" href="{$app.url.base}/asphalt/css/imgareaselect-animated.css">
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/singles/jquery.imgareaselect.pack.js"></script>
    <script type="text/javascript">
        var image = $('#image-input');

        var detectViewPort = function() {
            $('input[name="displayWidth"]').val(image.width());

            console.log('toon mij!');
            console.log($('#form-displayWidth').val());
        };

        $(window).resize(function() {
           detectViewPort();
        });

        $(function() {
            detectViewPort();
            image.imgAreaSelect({
                handles: true,
                onSelectEnd: function (img, selection) {
                    $('input[name="x1"]').val(selection.x1);
                    $('input[name="y1"]').val(selection.y1);
                    $('input[name="x2"]').val(selection.x2);
                    $('input[name="y2"]').val(selection.y2);
                }
            });
        });
    </script>
{/block}
