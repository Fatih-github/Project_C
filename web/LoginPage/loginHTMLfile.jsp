<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.5.2/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />

    <meta name="google-signin-client_id" content="621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
    <link rel = "stylesheet" type = "text/css"  href="LoginPage/loginCSSfile.css"/>
</head>

<body>
<div id="nav-placeholder"></div>

<div class="container" style="min-height: 48em">
    <div class="card border-0 shadow my-5">
        <div class="card-body p-5">
            <%
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
                    String sql = "select * from logintable where emailaddress = '" + email + "'";
                    rs = st.executeQuery(sql);
                    rs.next();
            %>

            <tbody>
            <span  STYLE="font-size: 300%; font-weight: bold" class="welcome control-label label_info">Hello <%=rs.getString("loginname")%>!</span>
            <%
                rs.beforeFirst();
            %>
            </tbody>
            <%
                } catch (Exception ex) {
                    System.out.println("Error: " + ex);
                }
            %>
            <h5 class="text-justify">It is nice seeing you again! On this page you can create a team and see your upcoming reservations.</h5>
            <h5 class="text-justify mb-5">We hope to see you soon at the office!</h5>
        </div>


        <div class="reservations form-group col-md-6 align-self-center">
            <span STYLE="font-size: x-large" class="text-nowrap control-label label_info">Upcoming reservations:</span><br>

            <div class="container_reservations">
                <div class="card border-0">
                    <div class="card-body p-0">

                        <table STYLE="font-size: large" class="table m-7 table-bordered table-responsive-md table-hover table-dark">
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Timeslot</th>
                                <th>Room</th>
                                <th>Team</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr class="table reservationtable">
                                    <%
                Connection database3 = null;
                Statement st3 = null;
                ResultSet rs3 = null;
                try {
                    Class.forName("org.postgresql.Driver");
                    database3 = DriverManager
                            .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                    "BaseFramePC", "none");
                    st3 = database3.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    String sql = "select * from reservationtable where emailaddress = '" + email + "'";
                    rs3 = st3.executeQuery(sql);
                                            while (rs3.next()){ %>

                                <td class="table reservationtable"><%=rs3.getString("date")%></td>
                                <td class="table reservationtable"><%=rs3.getString("timeslot")%></td>
                                <td class="table reservationtable"><%=rs3.getString("roomid")%></td>
                                <td class="table reservationtable"><%=rs3.getString("teamid")%></td>
                            </tbody>
                            <%}
                            } catch (Exception ex) {
                                System.out.println("Error: " + ex);
                            }
                            %>

                            </tr>
                        </table>
                    </div>

                    <span STYLE="font-size: x-large" class="text-nowrap text-black control-label mt-5">Create a team:</span>
                    <div class="team1 rounded p-4 bg-dark form-group mb-5 align-self-center w-100">

                        <%
                            Connection database2 = null;
                            String selectedname = request.getParameter("name");
                            Statement st2 = null;
                            ResultSet rs2 = null;
                            try {
                                Class.forName("org.postgresql.Driver");
                                database2 = DriverManager
                                        .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                                "BaseFramePC", "none");
                                st2 = database2.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                String sql = "select * from employeetable\n" +
                                        "where firstname not like '"+selectedname+"'";
                                rs2 = st2.executeQuery(sql);
                                rs2.next();
                        %>
                        <select style="font-size: large" id="Invite" class="team form-control" multiple="multiple">
                            <option id="ownname" class="ownname" selected><%=selectedname%></option>
                            <% while (rs2.next()) { %>
                            <option class="teamoptions"><%=rs2.getString("firstname")%></option>
                            <%
                                }
                            %>
                        </select><%
                        } catch (Exception ex) {
                            System.out.println("Error: " + ex);
                        }%>

                        <input style="font-size: large" id="teamName" class="teamname form-control" type="text" placeholder="Team name...">
                        <button style="font-size: large" class="teamsubmit btn btn-sm" onclick="onTeam()" type="button">Submit</button>
                    </div>

                    <div class="card-body p-0">

                        <table STYLE="font-size: large" class="table m-7 table-bordered table-responsive-md table-hover table-dark">
                            <thead>
                            <tr>
                                <th>Team name</th>
                                <th>Team members</th>
                                <th>Team organizer</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr class="table teamtable">
                                    <%
                Connection database4 = null;
                Statement st4 = null;
                ResultSet rs4 = null;
                String name = request.getParameter("name");
                try {
                    Class.forName("org.postgresql.Driver");
                    database4 = DriverManager
                            .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                    "BaseFramePC", "none");
                    st4 = database4.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    String sql = "select * from teamtable\n" +
                "where invitedbyemail = '"+ email +"' or  '"+name+"' = any(teaminvites)";
                    rs4 = st4.executeQuery(sql);
                                            while (rs4.next()){ %>

                                <td class="table teamtable"><%=rs4.getString("teamname")%></td>
                                <td class="table teamtable"><%=rs4.getString("teaminvites")%></td>
                                <td class="table teamtable"><%=rs4.getString("invitedbyemail")%></td>
                                        <td class="table teamtable">
                                            <a onclick="onDelete()" style="color: white; cursor: pointer"> <i class="fa fa-trash" aria-hidden="true"></i></a>
                                        </td>
                            </tbody>
                            <%}
                            } catch (Exception ex) {
                                System.out.println("Error: " + ex);
                            }
                            %>


                            </tr>
                        </table>
                    </div>



                </div>



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

    var TeamSelect
    $('#Invite').select2({
        placeholder: 'Choose..',
    });
    $('#Invite').on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
       TeamSelect = $(this).val();
    });
    $('#Invite').val(request.getParameter("name"));

    function onTeam(){
        console.log(TeamSelect);
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();
        var teamName = document.getElementById("teamName").value;
        var ownName = document.getElementById("ownname").value;
        TeamSelect.push(ownName);
        var redirectUrl = 'teamSubmit';
        //using jquery to post data dynamically
        var form = $('<form action="' + redirectUrl + '" method="post">' +
            '<input type="text" name="name" value="'+profile.getGivenName()+'" />' +
            '<input type="text" name="ownName" value="'+ownName+ '" />' +
            '<input type="text" name="teamname" value="'+teamName+ '" />' +
            '<input type="text" name="teamselect" value="' + TeamSelect.toString() + '" />' +
            '<input type="text" name="email" value="' + profile.getEmail() + '" />' +
            '</form>');
        $('body').append(form);
        form.submit();
    }

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
                    var auth2 = gapi.auth2.getAuthInstance();
                    var profile = auth2.currentUser.get().getBasicProfile();
                    var redirectUrl = 'linkDeleteTeam';
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="name" value="'+profile.getGivenName()+'" />' +
                        '<input type="text" name="teamname" value="' + tableData[0] + '" />' +
                        '<input type="text" name="teaminvites" value="' + tableData[1] + '" />' +
                        '<input type="text" name="invitedbyemail" value="' + tableData[2] + '" />' +
                        '<input type="text" name="email" value="' + profile.getEmail() + '" />' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                },
                cancel: function () {

                }
            }
        });
    }

</script>

<style>
    .welcome{
        position: relative;
        top: -5px;
    }

    .team1{
        width: 280px;
    }

    .team
    {
        width: auto;
        font-size: x-large;
        display: inline-block;
        position: relative;
        cursor: pointer;
        margin-top: 10px;
    }

    .teamsubmit{
        margin-top: 10px;
        color: #343a40;
        background-color: #9f8974;
    }

    .teamname{
        width: 100%;
        margin-top: 10px;
    }

    .reservationtable{
        color: white;
        background-color: #9f8974;

    }

    .teamtable{
        color: white;
        background-color: #9f8974;

    }

    select option:hover,
    select option:active,
    select option:checked{
        color: white;
        background:#343a40 ;
    }

    select option:focus{
        color: white;
    }


    select option:checked,
    select option:active{
        color:white;
        background: linear-gradient( #9f8974, #9f8974);
    }

    .select2{
        width: 100% !important;
    }


</style>

</html>
