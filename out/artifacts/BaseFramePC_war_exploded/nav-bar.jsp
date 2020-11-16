<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.5.2/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <meta name="google-signin-client_id" content="621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
    <link rel = "stylesheet" type = "text/css" href = "nav-bar.css"/>
</head>
<body>
    <nav class="navbar navbar-expand-sm navbar-light bg-light">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/login" onclick="javascript:onHome()"><img src="LoginTemplate/Resources/ngti-logo.png" alt="Logo" style="width:50px; height:50px"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/linkPlan">Plan</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/linkReservations">Reservations</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/linkInvitations">Invitations</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
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
            //window.location.pathname = 'BaseFramePC_war_exploded/index.jsp'
        })
        gapi.auth2.getAuthInstance().disconnect()
    }

    function onLoad() {
        gapi.load('auth2', function() {
            gapi.auth2.init();
        });
    }

    function onHome() {
    //send user details to server
        var redirectUrl = 'login';
        //using jquery to post data dynamically
        var form = $('<form action="' + redirectUrl + '" method="post">' +
        '<input type="text" name="id_token" value="' + googleUser.getAuthResponse().id_token + '" />' +
        '<input type="text" name="name" value="' + googleUser.getBasicProfile().getGivenName() + '" />' +
        '<input type="text" name="email" value="' + googleUser.getBasicProfile().getEmail() + '" />' +
        '</form>');
        $('body').append(form);
        form.submit();
    }
</script>
</html>