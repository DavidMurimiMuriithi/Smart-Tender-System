<% 
    if (request.getAttribute("message") != null) { 
%>
    <div class="alert alert-success"><%= request.getAttribute("message") %></div>
<% 
    } else if (request.getAttribute("error") != null) { 
%>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
<% 
    } 
%>
