{if $todos}
    <div class="todo">
        <h5>{translate key="api.title.todo"}</h5>    
        <ul class="todos">
        {foreach $todos as $todo}
            <li>{$todo}</li>
        {/foreach}
        </ul>
    </div>
{/if}

