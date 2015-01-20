{*
    Renders the pagination
*}
{function name="pagination"  pagination=null}
    {* {$pagination = new Pagination($pages, $page);} *}
    {if $pagination}
        {$anchors = $pagination->getAnchors()}
        <ul class="pagination">
            {foreach $anchors as $anchor}
                {* {$anchor->addToClass('btn btn--default')} *}
                <li>{$anchor->getHtml()}</li>
            {/foreach}
        </ul>
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
