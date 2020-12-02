<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <meta name="google-signin-client_id" content="621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
    <link rel = "stylesheet" type = "text/css" href = "nav-bar.css"/>
</head>
<body>
    <nav class="navbar navbar-expand-sm navbar-light bg-light">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/linkHome"><img src="LoginTemplate/Resources/ngti-logo.png" alt="Logo" style="width:50px; height:50px"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="#navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/linkPlan">Plan</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" onclick="onReservations()" style="cursor: pointer">Reservations</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/linkInvitations">Invitations</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
<%--                    <img class="nav-link" src="<%=request.getParameter("image")%>" alt="profilePic">--%>
                    profilePic
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/index.jsp" onclick="signOut();">Sign out</a>
                </li>
            </ul>
        </div>
    </nav>
</body>

<script>
    function signOut() {
        gapi.auth2.getAuthInstance().signOut().then(function() {
            console.log('user signed out')
        })
        gapi.auth2.getAuthInstance().disconnect()
    }

    function onLoad() {
        gapi.load('auth2', function() {
            gapi.auth2.init();
        });
    }

    function onReservations() {
        console.log("onreservations called")

        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();
        console.log(profile.getName());
        console.log(profile.getEmail());

        var redirectUrl = 'linkReservations';
        //using jquery to post data dynamically
        var form = $('<form action="' + redirectUrl + '" method="post">' +
            '<input type="text" name="email" value="' + profile.getEmail() + '" />' +
            '</form>');
        $('body').append(form);
        form.submit();
    }
</script>
</html>