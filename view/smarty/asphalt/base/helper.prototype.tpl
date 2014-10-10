{*
    Renders the pagination
*}
{function name="pagination"  pagination=null}
    {* {$pagination = new Pagination($pages, $page);} *}
    {if $pagination}
        {$anchors = $pagination->getAnchors()}
        <div class="btn-group">
            {foreach $anchors as $anchor}
                {$anchor->addToClass('btn btn--default')}
                {$anchor->getHtml()}
            {/foreach}
        </div>
    {/if}
{/function}

{*
 $anchors = $pagination->getAnchors();

 $html = '<div class="btn-group">';
 foreach ($anchors as $anchor) {
     $anchor->addToClass('btn btn--default');

     $html .= $anchor->getHtml();
 }
*}
