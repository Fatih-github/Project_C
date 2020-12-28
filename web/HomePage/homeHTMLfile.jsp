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
    <link rel = "stylesheet" type = "text/css"  href="HomePage/homeCSSfile.css"/>
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
                ResultSet rs = null;
                try {
                    Class.forName("org.postgresql.Driver");
                    database = DriverManager
                            .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                    "BaseFramePC", "none");
                    st = database.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    String sql = "select * from logintable where logintable_emailaddress = '" + email + "'";
                    rs = st.executeQuery(sql);
                    rs.next();
            %>

            <tbody>
            <span  STYLE="font-size: 300%; font-weight: bold" class="welcome control-label label_info">Hello <%=rs.getString("logintable_loginname")%>!</span>
            <%
                rs.beforeFirst();
            %>
            </tbody>
            <%
                } catch (Exception ex) {
                    System.out.println("Error: " + ex);
                }
            %>

            <h5>It is nice seeing you again! On this page you can create a team and see your upcoming reservations.</h5>
            <h5>We hope to see you soon at the office!</h5>



        </div>
        <div class="row">
            <div class="team1 form-group col-md-2">
                <span STYLE="font-size: x-large" class="m-4 text-nowrap control-label label_info ">Create a team: (ctrl + click)</span> <br>
                <%
                    rs.beforeFirst();
                    {%>
                <select id="Invite" class="mw-100 form-control col-xs-4 col-sm-4 col-md-4 team" multiple="multiple">
                    <% while (rs.next()) { %>
                    <option><%=rs.getString("logintable_loginname")%></option>
                    <%
                        }
                    %>
                </select><%
                }%>
            </div>


            <div class="reservations form-group col-md-3">
                <span STYLE="font-size: x-large" class="text-nowrap control-label label_info ">Upcoming reservations:</span><br>

                <div class="container_reservations">
                    <div class="card border-0">
                        <div class="card-body p-2">

                            <table STYLE="font-size: small" class="table m-7 table-bordered table-responsive-sm table-hover table-dark table-sm col-xs-7 col-sm-7 col-md-7">
                                <thead>
                                <tr>
                                    <th>attime</th>
                                    <th>email</th>
                                    <th>loginname</th>
                                    <th width="10em">update</th>
                                    <th width="10em">delete</th>
                                </tr>
                                </thead>

                                <tbody>
                                <tr class="table reservationtable">
                                        <%
                                        rs.beforeFirst();
                                        while (rs.next()){ %>

                                    <td class="table reservationtable"><%=rs.getString("logintable_timestamp")%></td>
                                    <td class="table reservationtable"><%=rs.getString("logintable_emailaddress")%></td>
                                    <td class="table reservationtable"><%=rs.getString("logintable_loginname")%></td>
                                    <td class="table reservationtable">
                                        <a onclick="onUpdate()" style="color: white; cursor: pointer"> <i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
                                    </td>
                                    <td class="table reservationtable">
                                        <a onclick="onDelete()" style="color: white; cursor: pointer"> <i class="fa fa-trash" aria-hidden="true"></i></a>
                                    </td>
                                </tbody>
                                <%}%>

                                </tr>
                            </table>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>

                <div style="height: 500px"></div>
            </div>
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

<style>

    .welcome{
        position: relative;
        top: -5px;
    }

    .team1{
        margin-left: 25px;
    }


    .team
    {
        font-size: 1rem;
        display: inline-block;
        width: 300px;
        position: relative;
        cursor: pointer;
        margin-top: 10px;
        margin-left: 25px;

    }


    .reservations
    {
        margin-left: 350px;
    }


    .container_reservations{
    }




    .reservationtable{
        color: white;
        background-color: #9f8974;

    }

    .tableres{
        margin-top: 10px;
        margin-left: 20px;
    }


    .clear{
        clear: both;
    }

    select option{
        color: white;
        background: #2ecc71;
    }

    select option:hover{
        color: white;
        background:#9f8974 ;
    }

    select option:focus{
        color: white;
    }


    select option:checked
    select option:active{
        background: linear-gradient( #343a40, #343a40);
        color:white;
    }

    p{
        margin-bottom: 0px;
    }



</style>

</html>
