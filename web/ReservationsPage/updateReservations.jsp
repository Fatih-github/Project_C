<%@ page import="java.sql.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OfficePlanager - updateReservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
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
            <h1 class="font-weight-light">Update your reservation</h1>
            <form>
                <%
                    Connection database = null;
                    Statement st = null;
                    String result;
                    System.out.println("invitee: " + request.getParameter("invitee"));
                    System.out.println("inviteeaccepted:" + request.getParameter("inviteeaccepted") + "test");
                    if (request.getParameter("invitee") != null && !request.getParameter("invitee").isEmpty() && !request.getParameter("invitee").equals("  ") && request.getParameter("inviteeaccepted") != null && !request.getParameter("inviteeaccepted").isEmpty() && !request.getParameter("inviteeaccepted").equals("  ")) {
                        result = request.getParameter("invitee") + ", " + request.getParameter("inviteeaccepted");
                    }
                    else if (request.getParameter("invitee") != null && !request.getParameter("invitee").isEmpty() && !request.getParameter("invitee").equals("  ")) {
                        result = request.getParameter("invitee");
                    }
                    else if (request.getParameter("inviteeaccepted") != null && !request.getParameter("inviteeaccepted").isEmpty() && !request.getParameter("inviteeaccepted").equals("  ")) {
                        result = request.getParameter("inviteeaccepted");
                    }
                    else {
                        result = "";
                    }
                    System.out.println("result" + result);
                    System.out.println("Lengte result" + result.length());
                    String[] ary = result.trim().split(", ");
                    System.out.println("string[] ary " + ary);
                    System.out.println("string[] ary lengte" + ary.length);
                    Arrays.sort(ary);
                    System.out.println("string[] ary sorted" + ary);
                    String sortedArray = Arrays.toString(ary).replace("[", "").replace("]", "").replace(", ", ",").trim();
                    System.out.println("newarrstring" + sortedArray);

                    String calendarId = request.getParameter("calendarId");
                    System.out.println("CalendarId: " + calendarId);
                    try {
                        Class.forName("org.postgresql.Driver");
                        database = DriverManager
                                .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                        "BaseFramePC", "none");
                        st = database.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                ResultSet.CONCUR_READ_ONLY);
                        String sql = "select * from employeetable where emailaddress != '"+request.getParameter("email")+"'";
                        ResultSet rs = st.executeQuery(sql);
                %>
                <div class="form-group">
                    <label for="date">Date</label>
                    <select class="form-control" id="date">
                        <option disabled selected><%=request.getParameter("date")%></option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="timeSlot">Timeslot</label>
                    <select class="form-control" id="timeSlot">
                        <option disabled selected><%=request.getParameter("timeSlot")%></option>
                        <option value="Morning">Morning</option>
                        <option value="Afternoon">Afternoon</option>
                        <option value="Entire day">Entire day</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="roomId">Room</label>
                    <select class="form-control" id="roomId">
                        <option disabled selected><%=request.getParameter("roomId")%></option>
                        <option value="room1">room1</option>
                        <option value="room2">room2</option>
                        <option value="room3">room3</option>
                        <option value="room4">room4</option>
                        <option value="room5">room5</option>
                        <option value="room6">room6</option>
                        <option value="room7">room7</option>
                        <option value="room8">room8</option>
                        <option value="room9">room9</option>
                        <option value="room10">room10</option>
                        <option value="room11">room11</option>
                        <option value="room12">room12</option>
                        <option value="room13">room13</option>
                        <option value="room14">room14</option>
                        <option value="room15">room15</option>
                        <option value="room16">room16</option>
                        <option value="room17">room17</option>
                        <option value="room18">room18</option>
                        <option value="room19">room19</option>
                        <option value="room20">room20</option>
                        <option value="room21">room21</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="invitee">Invite</label>
                    <select class="form-control" id="invitee" multiple="multiple">
                        <option id="selectedArray" selected><%=sortedArray%></option>
                        <% while (rs.next()) { %>
                        <option value="<%=rs.getString("firstname")%> <%=rs.getString("lastname")%>-<%=rs.getString("emailaddress")%>"><%=rs.getString("firstname")%> <%=rs.getString("lastname")%></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <button type="button" onclick="onUpdate2()" class="btn btn-primary">Submit</button>
                <div id="calendarId" style="display: none"><%=calendarId%></div>
                <%
                    }
                    catch (Exception ex) {
                        System.out.println("Error: " + ex);
                    }
                %>
            </form>
        </div>
    </div>
</div>
</body>

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
    $(function(){
        $("#nav-placeholder").load("nav-bar.jsp");
    });

    var date = new Date();
    var array = []
    var count = 0;

    for(var i = 0; i < 14; i++)
    {
        if(date.getDay() === 6) {
            date.setDate(date.getDate() + 1)
        }
        if(date.getDay() === 5) {
            date.setDate(date.getDate() + 2)
        }
        array[count++] = new Date(date.setDate(date.getDate() + 1)).toDateString();
        console.log("date: " + array[i]);
        console.log("day number: " + date.getDay());
    }

    var select = document.getElementById("date");

    for(var i = 0; i < array.length; i++) {
        var opt = array[i];
        var el = document.createElement("option");
        el.textContent = opt;
        el.value = opt;
        select.appendChild(el);
    }

    var Invite;
    $('#invitee').select2({
        placeholder: ''
    });
    $("#invitee").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite = $(this).val();
    })

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

    // function load the calendar api and make the api call
    function updateDate(calendarid, dateFormat) {
        gapi.client.load('calendar', 'v3', function() {					// load the calendar api (version 3)
            var request = gapi.client.calendar.events.update({
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

    function onUpdate2() {
        console.log("calendarId: " + document.getElementById('calendarId').innerText)
        console.log("roomid " + document.getElementById('roomId').value)
        console.log("selectedArray " + document.getElementById('selectedArray').value)
        console.log("timeslot " + document.getElementById('timeSlot').value)
        console.log("date " + document.getElementById('date').value)
        console.log("invitee" + document.getElementById('invitee').value)
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();

        console.log("Invite: " + Invite)
        var arrayInvites = Invite;
        var arrayInvitesSplit1 = [];
        var arrayInvitesSplit2 = [];
        if(arrayInvites !== undefined && document.getElementById('selectedArray').value != arrayInvites) {
            console.log("lengte array " + arrayInvites.length)
            for (let j = 0; j < arrayInvites.length; j++) {
                console.log(arrayInvites[j].split('-')[0] + "data")
                console.log(arrayInvites[j].split('-')[1] + "data2")
                arrayInvitesSplit1[j] = arrayInvites[j].split('-')[0]
                arrayInvitesSplit2[j] = arrayInvites[j].split('-')[1]
                console.log("first split array in loop: " + arrayInvitesSplit1[j])
                console.log("second split array in loop: " + arrayInvitesSplit2[j])
                console.log("---------------------------------------------------------")
            }

            var startTime;
            var endTime;

            if (document.getElementById('timeSlot').value === "Morning") {
                startTime = "08:00";
                endTime = "12:00";
            } else if (document.getElementById('timeSlot').value === "Afternoon") {
                startTime = "13:00";
                endTime = "17:00";
            } else {
                startTime = "08:00";
                endTime = "17:00";
            }

            var startDate = new Date(document.getElementById('date').value + " " + startTime);
            let startDateString = startDate.toISOString();

            var endDate = new Date(document.getElementById('date').value + " " + endTime);
            let endDateString = endDate.toISOString();

            var dateFormat = {
                "summary": "NGTI Reservation - " + document.getElementById('roomId').value,
                "start": {
                    "dateTime": startDateString
                },
                "end": {
                    "dateTime": endDateString
                },
                "attendees": [
                    //{"email": "example@gmail.com"},
                ]
            };

            for(var j = 0; arrayInvitesSplit2.length !== 0 && j < arrayInvitesSplit2.length; j++) {
                dateFormat.attendees.push(
                    {
                        "email": arrayInvitesSplit2[j].toString()
                    }
                )
            }
            console.log("dateFormat attendees: " + dateFormat.attendees)
            console.log("calendarId: " + document.getElementById('calendarId').innerText)
            //updateDate(document.getElementById('calendarId').innerText, dateFormat)
        }
        else {
            var startTime;
            var endTime;

            if (document.getElementById('timeSlot').value === "Morning") {
                startTime = "08:00";
                endTime = "12:00";
            } else if (document.getElementById('timeSlot').value === "Afternoon") {
                startTime = "13:00";
                endTime = "17:00";
            } else {
                startTime = "08:00";
                endTime = "17:00";
            }

            var startDate = new Date(document.getElementById('date').value + " " + startTime);
            let startDateString = startDate.toISOString();

            var endDate = new Date(document.getElementById('date').value + " " + endTime);
            let endDateString = endDate.toISOString();

            var dateFormat = {
                "summary": "NGTI Reservation - " + document.getElementById('roomId').value,
                "start": {
                    "dateTime": startDateString
                },
                "end": {
                    "dateTime": endDateString
                },
            };
            arrayInvitesSplit1 = arrayInvites;
            console.log("calendarId: " + document.getElementById('calendarId').innerText)
            //patchDate(document.getElementById('calendarId').innerText, dateFormat)
        }

        $.confirm({
            title: 'Changing Reservation',
            content: 'Are you sure you want to update your reservation',
            buttons: {
                confirm: function () {
                    //send user details to server
                    var redirectUrl = 'linkUpdateReservations';
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="date" value="' + document.getElementById("date").value + '" />' +
                        '<input type="text" name="timeSlot" value="' + document.getElementById("timeSlot").value + '" />' +
                        '<input type="text" name="roomId" value="' + document.getElementById("roomId").value + '" />' +
                        '<input type="text" name="invitee" value="' + arrayInvitesSplit1 + '" />' +
                        '<input type="text" name="oldDate" value=" <%=request.getParameter("date")%> " />' +
                        '<input type="text" name="oldTimeSlot" value=" <%=request.getParameter("timeSlot")%> " />' +
                        '<input type="text" name="oldRoomId" value=" <%=request.getParameter("roomId")%> " />' +
                        '<input type="text" name="oldInvitee" value=" <%=result%> " />' +
                        '<input type="text" name="reservationId" value=" <%=request.getParameter("reservationId")%> " />' +
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