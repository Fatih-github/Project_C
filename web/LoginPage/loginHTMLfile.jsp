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
    <link rel = "stylesheet" type = "text/css"  href="planCSSfile.css"/>
</head>

<body>
    <div id="nav-placeholder"></div>

    <div class="container">
            <div class="card-body p-5">
                <div class="container-form">


                    <form action="#">
                        <h2 class="heading">Reserve Online</h2>

                        <div class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label"><b>Name</b></label>
                                <div class="controls float-right">
                                    <input type="Name" class="form-control" id="inputName" placeholder="Your Name">
                                </div>
                            </div>
                        </div>

                        <div class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label"><b>Email</b></label>
                                <div class="controls float-right">
                                    <input type="Email" class="form-control" id="inputMail" placeholder="Your Email">
                                </div>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label"><b>Date</b></label>
                            <div class="card border-0">
                                <div class="row px-3">
                                    <div class="col-sm-10 list">
                                        <div class="mb-2 row justify-content-between px-3">
                                            <label class="text-grey mr-1">Day</label>
                                            <select id="day" class="mb-2 mob">
                                                <option value="mon">Mon</option>
                                                <option value="tue">Tue</option>
                                                <option value="wed">Wed</option>
                                                <option value="thu">Thu</option>
                                                <option value="fri">Fri</option>
                                            </select>

                                            <div class="mob">
                                                <label class="text-grey mr-1">Session</label>
                                                <select id="session" class="mob mb-2">
                                                    <option value="morning">Morning</option>
                                                    <option value="afternoon">Afternoon</option>
                                                    <option value="day">Entire day</option>
                                                    </select>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="col-sm-10 list">
                                        <div class="mb-2 row justify-content-between px-3">
                                            <label class="text-grey mr-1">Day</label>
                                            <select id="day2" class="mb-2 mob">
                                                <option value="mon">Mon</option>
                                                <option value="tue">Tue</option>
                                                <option value="wed">Wed</option>
                                                <option value="thu">Thu</option>
                                                <option value="fri">Fri</option>
                                            </select>

                                            <div class="mob">
                                                <label class="text-grey mr-1">Session</label>
                                                <select id="session2" class="mob mb-2">
                                                    <option value="morning">Morning</option>
                                                    <option value="afternoon">Afternoon</option>
                                                    <option value="day">Entire day</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-10 list">
                                        <div class="mb-2 row justify-content-between px-3">
                                            <label class="text-grey mr-1">Day</label>
                                            <select id="day3" class="mb-2 mob">
                                                <option value="mon">Mon</option>
                                                <option value="tue">Tue</option>
                                                <option value="wed">Wed</option>
                                                <option value="thu">Thu</option>
                                                <option value="fri">Fri</option>
                                            </select>

                                            <div class="mob">
                                                <label class="text-grey mr-1">Session</label>
                                                <select id="session3" class="mob mb-2">
                                                    <option value="morning">Morning</option>
                                                    <option value="afternoon">Afternoon</option>
                                                    <option value="day">Entire day</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-10 list">
                                        <div class="mb-2 row justify-content-between px-3">
                                            <label class="text-grey mr-1">Day</label>
                                            <select id="day4" class="mb-2 mob">
                                                <option value="mon">Mon</option>
                                                <option value="tue">Tue</option>
                                                <option value="wed">Wed</option>
                                                <option value="thu">Thu</option>
                                                <option value="fri">Fri</option>
                                            </select>

                                            <div class="mob">
                                                <label class="text-grey mr-1">Session</label>
                                                <select id="session4" class="mob mb-2">
                                                    <option value="morning">Morning</option>
                                                    <option value="afternoon">Afternoon</option>
                                                    <option value="day">Entire day</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-10 list">
                                        <div class="mb-2 row justify-content-between px-3">
                                            <label class="text-grey mr-1">Day</label>
                                            <select id="day5" class="mb-2 mob">
                                                <option value="mon">Mon</option>
                                                <option value="tue">Tue</option>
                                                <option value="wed">Wed</option>
                                                <option value="thu">Thu</option>
                                                <option value="fri">Fri</option>
                                            </select>

                                            <div class="mob">
                                                <label class="text-grey mr-1">Session</label>
                                                <select id="session5" class="mob mb-2">
                                                    <option value="morning">Morning</option>
                                                    <option value="afternoon">Afternoon</option>
                                                    <option value="day">Entire day</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>

                    </form>
                    <button onclick="displayResult()">Submit</button>

<!--                    <a href="Confirmation.html">-->
<!--                        <button class="button button1">Submit</button>-->
<!--                    </a>-->
                </div>
                <div style="height: 500px"></div>
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
</script>



<script>
    function displayResult() {
        console.log(document.getElementById('inputName').value);
        console.log(document.getElementById('inputMail').value);
        console.log(document.getElementById('day').value);
        console.log(document.getElementById('session').value);
        console.log(document.getElementById('day2').value);
        console.log(document.getElementById('session2').value);
        console.log(document.getElementById('day3').value);
        console.log(document.getElementById('session3').value);
        console.log(document.getElementById('day4').value);
        console.log(document.getElementById('session4').value);
        console.log(document.getElementById('day5').value);
        console.log(document.getElementById('session5').value);


        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();
        var redirectUrl = 'planSubmit';
        //using jquery to post data dynamically
        var form = $('<form action="' + redirectUrl + '" method="post">' +
             '<input type="text" name="email" value="' + profile.getEmail() + '" />' +
            '<input type="text" name="day1" value="' + document.getElementById('day').value + '" />' +
            '<input type="text" name="session1" value="' + document.getElementById('session').value + '" />' +
            '<input type="text" name="day2" value="' + document.getElementById('day2').value + '" />' +
            '<input type="text" name="session2" value="' + document.getElementById('session2').value + '" />' +
            '<input type="text" name="day3" value="' + document.getElementById('day3').value + '" />' +
            '<input type="text" name="session3" value="' + document.getElementById('session3').value + '" />' +
            '<input type="text" name="day4" value="' + document.getElementById('day4').value + '" />' +
            '<input type="text" name="session4" value="' + document.getElementById('session4').value + '" />' +
            '<input type="text" name="day5" value="' + document.getElementById('day5').value + '" />' +
            '<input type="text" name="session5" value="' + document.getElementById('session5').value + '" />' +
            '</form>');
        $('body').append(form);
        form.submit();


    }
</script>


</html>
