<%--
  Created by IntelliJ IDEA.
  User: kevin
  Date: 25-9-2020
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
  <head>
    <title>WEB PAGE TITLE</title>
    <meta name="google-signin-client_id" content="621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.5.2/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel = "stylesheet" type = "text/css" href = "styles.css"/>

  <body>
    <div class="container-sm h-100 d-flex justify-content-center align-items-center">
      <div class="card bg-white text-white align-items-center" style="width: 30rem; border-radius: 10%">
        <div class="card-body p-5">
            <figure>
                <img src="Pictures/ngti-logo.png" class="img-fluid" alt="Responsive image">
            </figure>
            <br><br>
            <div class="g-signin2" data-width="auto" data-height="50em" data-longtitle="true" data-onsuccess="onSignIn" data-prompt="select_account"></div>
            <br>
        </div>
      </div>
    </div>

  </body>

  <script>
    function onSignIn(googleUser) {
      //document.querySelector('#content').innerText = googleUser.getBasicProfile().getName()
      console.log(googleUser.getId())
      console.log(googleUser.getBasicProfile().getGivenName())
      console.log(googleUser.getBasicProfile().getFamilyName())
      console.log(googleUser.getBasicProfile().getEmail())

      var id_token = googleUser.getAuthResponse().id_token
      console.log("ID Token: " + id_token);

      var Bool = false;
      var client = new HttpClient();
      var verified = true;
      client.get('https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=' + id_token, function(response) {
          console.log(response);
          JSON.parse(response, function (key, value) {
              if (key === "aud") {
                if (value === "621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com")
                  Bool = true;
                else
                  Bool = false;
                console.log("nummer 1: " + Bool);
              }
              if (key === "iss") {
                if (value === "accounts.google.com" || value === "https://accounts.google.com")
                  Bool = true;
                else
                  Bool = false;
                console.log("nummer 2: " + Bool);
              }
              if (key === "hd") {
                if (value === "hr.nl")
                  Bool = true;
                else
                  Bool = false;
                console.log("nummer 3: " + Bool);
              }
              if (key !== "hd") {
                Bool = false;
                console.log("nummer 4: " + Bool);
              }
              if (Bool === true) {
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
          });
      });

      // if(verified){
      //   //send user details to server
      //   var redirectUrl = 'login';
      //
      //   //using jquery to post data dynamically
      //   var form = $('<form action="' + redirectUrl + '" method="post">' +
      //           '<input type="text" name="id_token" value="' + googleUser.getAuthResponse().id_token + '" />' +
      //           '<input type="text" name="name" value="' + googleUser.getBasicProfile().getGivenName() + '" />' +
      //           '<input type="text" name="email" value="' + googleUser.getBasicProfile().getEmail() + '" />' +
      //           '</form>');
      //   $('body').append(form);
      //   form.submit();
      // }


      //var url= "http://localhost:8080/BaseFramePC_war_exploded/PageTemplate/templateHTMLfile.html";
      //window.location = url;
          // window.location.pathname = 'BaseFramePC_war_exploded/PageTemplate/templateHTMLfile.html'
    }

    var HttpClient = function() {
        this.get = function(aUrl, aCallback) {
            var anHttpRequest = new XMLHttpRequest();
            anHttpRequest.onreadystatechange = function() {
                if (anHttpRequest.readyState == 4 && anHttpRequest.status == 200)
                    aCallback(anHttpRequest.responseText);
                if (anHttpRequest.status == 400)
                    alert("invalid user");
            }
            anHttpRequest.open( "GET", aUrl, true );
            anHttpRequest.send( null );
        }
    }
  </script>
</html>