<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OfficePlanager - Invitations</title>
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
    <link rel = "stylesheet" type = "text/css" href="InvitationsPage/invitationsCSSfile.css"/>
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
                        <th>Invitedby</th>
                        <th>Accept</th>
                        <th>Decline</th>
                    </tr>
                    </thead>

                    <%

                        System.out.println("\tInvitations JSP");

                        String name = request.getParameter("name");
                        String email = request.getParameter("email");

                        System.out.println("\t\tuser: " + name);
                        System.out.println("\t\temail: " + email);
                        Connection database = null;
                        Statement st = null;
                        try {

                            System.out.println("\t\t InvitationsHTMLfile JAVA code");

                            Class.forName("org.postgresql.Driver");
                            database = DriverManager
                                    .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                            "BaseFramePC", "none");
                            st = database.createStatement();
                            String sql = "select to_char(date, 'Dy Mon DD YYYY') as date, timeslot, roomid, invitedby, res.reservationid as reservationid, res.workspaceid as workspaceid, calendarid from invitationtable inv join reservationtable res on inv.reservationid=res.reservationid join workspacetable wrk on wrk.workspaceid=res.workspaceid where '" + name + "' = any(invitee) and date > current_date order by res.date";
                            ResultSet rs = st.executeQuery(sql);
                            while (rs.next()) {
                    %>
                    <tbody>
                    <tr class="table">
                        <td class="table"><%=rs.getString("date")%></td>
                        <td class="table"><%=rs.getString("timeslot")%></td>
                        <td class="table"><%=rs.getString("roomid")%></td>
                        <td class="table"><%=rs.getString("invitedby")%></td>
                        <td class="table" style="display: none"><%=rs.getString("reservationid")%></td>
                        <td class="table" style="display: none"><%=rs.getString("workspaceid")%></td>
                        <td class="table" style="display: none"><%=rs.getString("calendarid")%></td>
                        <td class="table command">
                            <a onclick="onAccept()" style="color: #007bff; cursor: pointer"> <i class="fa fa-check" aria-hidden="true"></i></a>
                        </td>
                        <td class="table command">
                            <a onclick="onDecline()" style="color: #007bff; cursor: pointer"> <i class="fa fa-ban" aria-hidden="true"></i></a>
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
</script>

<script type="text/javascript">
    var CLIENT_ID = '621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com';
    var API_KEY = 'AIzaSyC3WIx6dVn9Auv9uvPLa9bpXS6cuh0EK5Q';
    var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];
    var SCOPES = "https://www.googleapis.com/auth/calendar";

    function handleClientLoad() {
        gapi.load('client:auth2', initClient);
    }
</script>

<script async defer src="https://apis.google.com/js/api.js"
        onload="this.onload=function(){};handleClientLoad()"
        onreadystatechange="if (this.readyState === 'complete') this.onload()">
</script>

<script>
    function initClient() {
        gapi.client.init({
            apiKey: API_KEY,
            clientId: CLIENT_ID,
            discoveryDocs: DISCOVERY_DOCS,
            scope: SCOPES
        }).then(function () {
            gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
            updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
        }, function(error) {
            console.log(error)
        });
    }

    function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
            console.log("if signed in")
        } else {
            console.log("else not signed in")
        }
    }

    function deleteDate(calendarid) {
        gapi.client.load('calendar', 'v3', function() {					// load the calendar api (version 3)
            var request = gapi.client.calendar.events.delete({
                'calendarId':		'primary',	// calendar ID
                "eventId": calendarid		// pass event id
            });

            // handle the response from our api call
            request.execute(function(resp) {
                if(resp.error || resp == false) {
                    console.log("failed to delete")
                } else {
                    console.log("successfully deleted")
                }
                console.log(resp);
            });
        });
    }

    // function load the calendar api and make the api call
    function patchDate(calendarid, dateFormat) {
        gapi.client.load('calendar', 'v3', function() {					// load the calendar api (version 3)
            var request = gapi.client.calendar.events.patch({
                'calendarId':		'primary',	// calendar ID
                "eventId": calendarid,		// pass event id
                "sendNotifications": true,
                "resource":			dateFormat		// pass event details with api call
            });

            // handle the response from our api call
            request.execute(function(resp) {
                if(resp.error || resp == false) {
                    console.log("failed to update")
                } else {
                    console.log("successfully updated")
                }
                console.log(resp);
            });
        });
    }

    function onAccept() {
        var tableData;
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();

        $("tr.table").click(function () {
            tableData = $(this).children("td").map(function () {
                return $(this).text();
            }).get();
        });

        $.confirm({
            title: 'Accept Invite',
            content: 'Are you sure you want to accept this Invite?',
            buttons: {
                confirm: function () {
                    // var dateFormat = {
                    //     "email": '0986192@hr.nl',
                    //     "responseStatus": 'accepted'
                    // };
                    // patchDate(tableData[6], dateFormat)

                    var redirectUrl = 'linkAcceptInvite';
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="Date" value="' + tableData[0] + '" />' +
                        '<input type="text" name="TimeSlot" value="' + tableData[1] + '" />' +
                        '<input type="text" name="Room" value="' + tableData[2] + '" />' +
                        '<input type="text" name="ReservationId" value="' + tableData[4] + '" />' +
                        '<input type="text" name="WorkspaceId" value="' + tableData[5] + '" />' +
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

    function onDecline() {
        var tableData;
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();

        $("tr.table").click(function () {
            tableData = $(this).children("td").map(function () {
                return $(this).text();
            }).get();
        });

        $.confirm({
            title: 'Decline Invite',
            content: 'Are you sure you want to decline this Invite?',
            buttons: {
                confirm: function () {
                    deleteDate(tableData[6]);
                    console.log(tableData[6]);
                    var redirectUrl = 'linkDeclineInvite';
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="Date" value="' + tableData[0] + '" />' +
                        '<input type="text" name="TimeSlot" value="' + tableData[1] + '" />' +
                        '<input type="text" name="Room" value="' + tableData[2] + '" />' +
                        '<input type="text" name="ReservationId" value="' + tableData[4] + '" />' +
                        '<input type="text" name="workspaceid" value="' + tableData[5] + '" />' +
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

</html>