<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.5.2/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <meta name="google-signin-client_id" content="621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
    <link rel = "stylesheet" type = "text/css" href="ReservationsPage/reservationsCSSfile.css"/>
</head>

<body>
    <div id="nav-placeholder"></div>

    <div class="container" style="min-height: 48em">
        <div class="card border-0 shadow my-5">
            <div class="card-body p-5" style="min-height: 46em">

    <table class="table table-bordered table-responsive-sm table-hover">
        <thead>
            <tr>
                <th>attime</th>
                <th>email</th>
                <th>loginname</th>
                <th width="10em">update</th>
                <th width="10em">delete</th>
            </tr>
        </thead>

    <%

        System.out.println("\tRESERVATIONS JSP");

        String name = request.getParameter("name");
        String id_token = request.getParameter("id_token");
        String email = request.getParameter("email");

        System.out.println("\t\tuser: " + name);
        System.out.println("\t\tid_token: " + id_token);
        System.out.println("\t\temail: " + email);
        Connection database = null;
        Statement st = null;
        try {

            System.out.println("\t\t reservaionsHTMLfile JAVA code");

            Class.forName("org.postgresql.Driver");
            database = DriverManager
                    .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                            "BaseFramePC", "none");
            st = database.createStatement();
            String sql = "select * from logintable where logintable_loginname='Kevin' limit 10";
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                %>
                <tbody>
                    <tr class="table">
                        <td class="table"><%=rs.getString("logintable_timestamp")%></td>
                        <td class="table"><%=rs.getString("logintable_loginname")%></td>
                        <td class="table"><%=rs.getString("logintable_emailaddress")%></td>
                        <td class="table">
                            <a href="${pageContext.request.contextPath}/linkHome"> <i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
                        </td>
                        <td class="table">
                            <a href="${pageContext.request.contextPath}/linkHome"> <i class="fa fa-trash" aria-hidden="true"></i></a>
                        </td>
                    </tr>
                </tbody>
                <%
            }
        }
        catch (Exception ex) {
            System.out.println("Error: " + ex);
        }
    %>
    </table>
            </div>
        </div>
    </div>
</body>

<script>
    $(function(){
        $("#nav-placeholder").load("nav-bar.jsp");
    });

    $("tr.table").click(function() {
        var tableData = $(this).children("td").map(function() {
            return $(this).text();
        }).get();

        alert($.trim(tableData[0]) + " , " + $.trim(tableData[1]));
        //call servlet here (with ajax)
    });

</script>
</html>