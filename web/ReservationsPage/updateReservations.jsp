<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
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
            <h1 class="font-weight-light">Update your reservation</h1>
            <form>
                <div class="form-group">
                    <label for="date">Date</label>
                    <input class="form-control" id="date" value="" placeholder="<%=request.getParameter("date")%>">
                </div>
                <div class="form-group">
                    <label for="timeSlot">Timeslot</label>
                    <input class="form-control" id="timeSlot" value="" placeholder="<%=request.getParameter("timeSlot")%>">
                </div>
                <div class="form-group">
                    <label for="roomId">Room</label>
                    <input class="form-control" id="roomId" value="" placeholder="<%=request.getParameter("roomId")%>">
                </div>
                <div class="form-group">
                    <label for="invitee">Invite</label>
                    <input class="form-control" id="invitee" value="" placeholder="<%=request.getParameter("invitee")%>">
                </div>
                <button type="button" onclick="onUpdate2()" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
</div>
</body>

<script>
    $(function(){
        $("#nav-placeholder").load("nav-bar.jsp");
    });

    function onUpdate2() {
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();

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
                        '<input type="text" name="invitee" value="' + document.getElementById("invitee").value + '" />' +
                        '<input type="text" name="oldDate" value=" <%=request.getParameter("date")%> " />' +
                        '<input type="text" name="oldTimeSlot" value=" <%=request.getParameter("timeSlot")%> " />' +
                        '<input type="text" name="oldRoomId" value=" <%=request.getParameter("roomId")%> " />' +
                        '<input type="text" name="oldInvitee" value=" <%=request.getParameter("invitee")%> " />' +
                        '<input type="text" name="reservationId" value=" <%=request.getParameter("reservationId")%> " />' +
                        '<input type="text" name="workspaceId" value=" <%=request.getParameter("workspaceId")%> " />' +
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