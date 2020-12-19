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
    <link rel = "stylesheet" type = "text/css"  href="LoginPage/loginCSSfile.css"/>
</head>

<body>
    <div id="nav-placeholder"></div>

    <div class="container">
        <div class="card border-0 shadow my-5">
            <div class="card-body p-5">
                <%
                    String name = request.getParameter("name");
                    String id_token = request.getParameter("id_token");
                    String email = request.getParameter("email");
                    Connection database = null;
                    Statement st = null;
                    try {
                        Class.forName("org.postgresql.Driver");
                        database = DriverManager
                                .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                        "BaseFramePC", "none");
                        st = database.createStatement();
                        String sql = "select * from logintable where logintable_emailaddress = '"+email+"'";
                        ResultSet rs = st.executeQuery(sql);
                        rs.next();
                %>
                <tbody>
                <h1 class="font-weight-light">Hello <%=rs.getString("logintable_loginname")%>!</h1>
                </tbody>
                <%
                    }
                    catch (Exception ex) {
                        System.out.println("Error: " + ex);
                    }
                %>



                <div style="height: 500px"></div>
            </div>
        </div>
    </div>
    <%
        String image = request.getParameter("image");
        session.setAttribute("image", image);
    %>
</body>

<script>
    $(function(){
        $("#nav-placeholder").load("nav-bar.jsp");
    });

    function onDelete() {
        var tableData;

        $("tr.table").click(function () {
            tableData = $(this).children("td").map(function () {
                return $(this).text();
            }).get();
        });

        $.confirm({
            title: 'Delete Reservation',
            content: 'Are you sure you want to delete this reservation?',
            buttons: {
                confirm: function () {
                    var redirectUrl = 'linkDeleteReservations';
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="time" value="' + tableData[0] + '" />' +
                        '<input type="text" name="email" value="' + tableData[1] + '" />' +
                        '<input type="text" name="name" value="' + tableData[2] + '" />' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                },
                cancel: function () {

                }
            }
        });
    }

    function onUpdate() {
        $("tr.table").click(function () {
            var tableData = $(this).children("td").map(function () {
                return $(this).text();
            }).get();

            // alert($.trim(tableData[0]) + " , " + $.trim(tableData[1]) + ", " + $.trim(tableData[2]));

            var redirectUrl = 'linkUpdateReservations';
            //using jquery to post data dynamically
            var form = $('<form action="' + redirectUrl + '" method="post">' +
                '<input type="text" name="time" value="' + tableData[0] + '" />' +
                '<input type="text" name="email2" value="' + tableData[1] + '" />' +
                '<input type="text" name="name" value="' + tableData[2] + '" />' +
                '</form>');
            $('body').append(form);
            form.submit();
        });
    }
</script>
</html>
