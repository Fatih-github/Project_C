<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OfficePlanager - Reservations</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
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
                    <th>Date</th>
                    <th>TimeSlot</th>
                    <th>Room</th>
                    <th>Attendees</th>
                    <th>Organizer</th>
                    <th>update</th>
                    <th>delete</th>
                </tr>
                </thead>

                <%

                    System.out.println("\tRESERVATIONS JSP");

                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String Id = (String)request.getAttribute("Id");
//        System.out.println("reservationshtml id: " + Id);

                    System.out.println("\t\tuser: " + name);
                    System.out.println("\t\temail: " + email);
                    System.out.println("\t\tid: " + Id);
                    Connection database = null;
                    Statement st = null;
                    try {

                        System.out.println("\t\t reservaionsHTMLfile JAVA code");

                        Class.forName("org.postgresql.Driver");
                        database = DriverManager
                                .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                        "BaseFramePC", "none");
                        st = database.createStatement();
                        String sql = "select date, timeslot, invitee, inviteeaccepted, roomid, res.reservationid, invitedby, res.roomid, res.employeeid from reservationtable res join roomtable wrk on res.roomid=wrk.roomid join invitationtable inv on inv.reservationid=res.reservationid where (res.employeeid='"+Id+"' and date >= current_date) or ('" + name + "'=any(inviteeaccepted) and date >= current_date) order by res.date";
                        ResultSet rs = st.executeQuery(sql);
                        while (rs.next()) {
                %>
                <tbody>
                <tr class="table">
                    <td class="table"><%=rs.getString("date")%></td>
                    <td class="table"><%=rs.getString("timeslot")%></td>
                    <td class="table"><%=rs.getString("roomid")%></td>
                    <td class="table"><%=rs.getString("inviteeaccepted").replace("{", " ").replace("}", " ").replace("\"", "").replace(",", ", ")%></td>
                    <td class="table" style="display: none"><%=rs.getString("invitee").replace("{", " ").replace("}", " ").replace("\"", "").replace(",", ", ")%></td>
                    <td class="table" style="display: none"><%=rs.getString("reservationid")%></td>
                    <td class="table"><%=rs.getString("invitedby")%></td>
                    <td class="table" style="display: none"><%=rs.getString("roomid")%></td>
                    <td class="table" style="display: none"><%=rs.getString("employeeid")%></td>
                    <td class="table command">
                        <a onclick="onUpdate(this)" style="color: #007bff; cursor: pointer"> <i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
                    </td>
                    <td class="table command">
                        <a onclick="onDelete()" style="color: #007bff; cursor: pointer"> <i class="fa fa-trash" aria-hidden="true"></i></a>
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

    function onDelete() {
        var tableData;
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();

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
                        '<input type="text" name="inviteeaccepted" value="' + tableData[3] + '" />' +
                        '<input type="text" name="reservationId" value="' + tableData[5] + '" />' +
                        '<input type="text" name="invitedby" value="' + tableData[6] + '" />' +
                        '<input type="text" name="roomId" value="' + tableData[7] + '" />' +
                        '<input type="text" name="employeeId" value="' + tableData[8] + '" />' +
                        '<input type="text" name="email" value="' + profile.getEmail() + '" />' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                },
                cancel: function () {
                    console.log(tableData);
                }
            }
        });
    }

    function onUpdate($this) {
        var tableData;
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();

        tableData = $($this).closest('tr').children("td").map(function() {
            return $(this).text();
        }).get();

        if( tableData[8] == <%=Id%>) {
            console.log("if statement");
            console.log(tableData);
            var redirectUrl = 'linkUpdateReservations';
            //using jquery to post data dynamically
            var form = $('<form action="' + redirectUrl + '" method="post">' +
                '<input type="text" name="date" value="' + tableData[0] + '" />' +
                '<input type="text" name="timeSlot" value="' + tableData[1] + '" />' +
                '<input type="text" name="roomId" value="' + tableData[2] + '" />' +
                '<input type="text" name="inviteeaccepted" value="' + tableData[3] + '" />' +
                '<input type="text" name="invitee" value="' + tableData[4] + '" />' +
                '<input type="text" name="reservationId" value="' + tableData[5] + '" />' +
                '<input type="text" name="invitedby" value="' + tableData[6] + '" />' +
                '<input type="text" name="roomId" value="' + tableData[7] + '" />' +
                '<input type="text" name="employeeId" value="' + tableData[8] + '" />' +
                '<input type="text" name="email" value="' + profile.getEmail() + '" />' +
                '</form>');
            $('body').append(form);
            form.submit();
        }
        else {
            console.log(tableData);
            console.log("else statement");
            $.confirm({
                title: 'update Reservation',
                content: 'Only the organiser ' + tableData[6] + ' is allowed to update this reservation',
                buttons: {
                    confirm: function () {

                    }
                }
            });
        }
    }

</script>
</html>
