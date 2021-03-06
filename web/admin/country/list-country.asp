<!-- #include virtual="/config/bootstrap.asp"-->
<% 
response.expires = 0 
call verifiedLogin()
%>
<!doctype html>
<html lang="pt">
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!--#include virtual="/web/includes/header.html"-->
		<title>Country</title>
    </head>
    <body>
        <!--#include virtual="/web/includes/nav.html"-->
        <div class="container">
        <h3>Country</h3>        
            <table class="table table-hover table-striped" id="tb-country" style="width:100%">
                <thead>
                    <tr>
                        <th scope="col">Name</th>                        
                        <th scope="col">Initials</th>
                        <th scope="col">Active</th>
                    </tr>
                </thead>
                <tbody>
                <%                
                set rs = listCountry()
                do while not rs.EOF
                    country_id      = rs("country_id")
                    country_active  = rs("country_active")
                    country_name    = rs("country_name")                    
                    country_initials = rs("country_initials_alfa_2")

                    badge = "badge-primary"
                    active  = "Yes"

                    if country_active <> 1 Then 
                        active = "No"
                        badge = "badge-danger"
                    end if
                
                    flag = ""
                    flag_initials = LCase(country_initials)

                    if flag_initials <> "" Then
                        flag = "<span class='flag-icon " & "flag-icon-" & flag_initials & "'" & "></span>"
                    end if
                %>
                    <tr> 
                        <td><%=flag & vbcrlf & country_name %></td>
                        <td><%=country_initials%></td>
                        <td><a href="#" data-id="<%=country_id%>" id="btn-active" class="badge badge-pill <%=badge%>"><%=active%></a></td>                        
                    </tr>
                    <span><input type="hidden" id="active" value="<%=country_active%>"></span>
                <%
                    rs.MoveNext 
                loop
                set rs = Nothing
                %>
                </tbody>
            </table>
        </div>          
        <script type="text/javascript">
            $(document).ready(function() {
                $(".badge").click(function() { 
                    var id = $(this).attr("data-id");
                    var active = $("#active").val()

                    if (typeof id !== 'undefined') {
                        $.ajax({
                            method: "POST",
                            url: "action-country.asp",
                            data: {id: id, action: "inactive/active", active: active}
                        }).done(function(data) {
                           location.reload();
                        }).fail(function(textStatus) {
                            alert(textStatus);
                            alert(jqXHR);
                        });
                    }
                });

                loadDataTable("#tb-country");            
            });
        </script>
    </body>
</html>
