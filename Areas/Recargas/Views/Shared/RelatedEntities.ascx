<%@ Control Language="C#" Inherits="MvcContrib.FluentHtml.ModelViewUserControl<Gambling.Models.ViewModels.Lottery.RelatedEntitiesViewModel>" %>
<%  const int RowsShownInitially = 5;%>
<script type="text/javascript">
    $('.showMoreLink').click(function () {
        $(this).parent().parent().find('li').show();
        $(this).hide();
    });
</script>
<div id="relatedEntitiesContainer" class="leftBorder">
    <h5>Quien esta usando este perfil: <%= Model.ProfileName %></h5> 
    <% if( Model.Users.Count() > 0 )
       {%>
    <div>
        <p class="subtitle">Usuarios</p>
        <ul>
            <% foreach( var User in Model.Users.Take( RowsShownInitially ) )
               {%>
                <li><%= Html.ActionLink( User.Data.Name, "Edit", "Account", new { @area = "root", code = User.User.UserName}, null )%></li>
            <% }%>
            <% foreach( var User in Model.Users.Skip( RowsShownInitially ) )
               {%>
                <li style="display:none"><%= Html.ActionLink( User.Data.Name, "Edit", "Account", new { @area = "root", code = User.User.UserName}, null )%></li>
            <% }%>
            <% if( Model.Users.Skip( RowsShownInitially ).Count( ) > 0 )
                {%>
                <li><a class="showMoreLink">Ver mas...</a></li>
            <% }%>
        </ul>
    </div>
    <%}%>
    <% if( Model.Terminals.Count( ) > 0 )
       {%>
    <div>
        <p class="subtitle">Terminales</p>
        <ul>
            <% foreach( var Terminal in Model.Terminals.Take( RowsShownInitially ) )
               {%>
                <li><%= Html.ActionLink( Terminal.TerminalId.ToString("00000000"), "Edit", "Terminal", new { @area = "root", code = Terminal.Id }, null )%></li>
            <% }%>
            <% foreach( var Terminal in Model.Terminals.Skip( RowsShownInitially ) )
               {%>
                <li style="display:none"><%= Html.ActionLink( Terminal.TerminalId.ToString("00000000"), "Edit", "Terminal", new { @area = "root", code = Terminal.Id }, null )%></li>
            <% }%>
            <% if( Model.Terminals.Skip( RowsShownInitially ).Count( ) > 0 )
                {%>
                <li><a class="showMoreLink">Ver mas...</a></li>
            <% }%>
        </ul>
    </div>
    <%}%>
    <% if( Model.SportBooks.Count( ) > 0 )
       {%>
    <div>
        <p class="subtitle">Bancas</p>
        <ul>
            <% foreach( var Sportbook in Model.SportBooks.Take( RowsShownInitially ) )
               {%>
                <li><%= Html.ActionLink( Sportbook.Name, "Edit", "SportBook", new { @area = "root", code = Sportbook.Id }, null )%></li>
            <% }%>
            <% foreach( var Sportbook in Model.SportBooks.Skip( RowsShownInitially ) )
               {%>
                <li style="display:none"><%= Html.ActionLink( Sportbook.Name, "Edit", "SportBook", new { @area = "root", code = Sportbook.Id }, null )%></li>
            <% }%>
            <% if( Model.SportBooks.Skip( RowsShownInitially ).Count( ) > 0 )
                {%>
                <li><a class="showMoreLink">Ver mas...</a></li>
            <% }%>
        </ul>
    </div>
    <%}%>
    <% if( Model.StoringCenters.Count( ) > 0 )
       {%>
    <div>
        <p class="subtitle">Centros de acopio</p>
        <ul>
            <% foreach( var StoringCenter in Model.StoringCenters.Take( RowsShownInitially ) )
               {%>
                <li><%= Html.ActionLink( StoringCenter.Name, "Edit", "StoringCenter", new { @area = "root", code = StoringCenter.Id }, null )%></li>
            <% }%>
             <% foreach( var StoringCenter in Model.StoringCenters.Skip( RowsShownInitially ) )
               {%>
                <li style="display:none"><%= Html.ActionLink( StoringCenter.Name, "Edit", "StoringCenter", new { @area = "root", code = StoringCenter.Id }, null )%></li>
            <% }%>
            <% if( Model.StoringCenters.Skip( RowsShownInitially ).Count( ) > 0 )
                {%>
                <li><a class="showMoreLink">Ver mas...</a></li>
            <% }%>
        </ul>
    </div>            
    <%}%>
</div>
