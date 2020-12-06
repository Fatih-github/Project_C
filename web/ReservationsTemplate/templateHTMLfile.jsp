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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css" rel="stylesheet"/>

    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'>

    <meta name="google-signin-client_id" content="621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
    <link rel = "stylesheet" href="templateCSSfile.css"/>




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
                    <label class="control-label"><b></b></label>
                    <div class="card border-0">
                        <div class="row px-3">
                            <div class="col-sm-10 list">
                                <div class="mb-2 row justify-content-between px-3">

                                    <%
                                        String Email = "0986192@hr.nl";

                                        System.out.println("email: " + Email);
                                        Connection database = null;
                                        Statement st = null;
                                        try {
                                            Class.forName("org.postgresql.Driver");
                                            database = DriverManager
                                                    .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                                            "BaseFramePC", "none");
                                            st = database.createStatement();
                                            String sql = "select * from loginattempts where email='" + Email + "' order by attime limit 10";
                                            ResultSet rs = st.executeQuery(sql);




                                    %>

                                    <label class="text-grey mr-1" id="Mon" value="Mon">Mon:</label>



                                    <div class="mob">
                                        <label class="text-grey mr-1">Session</label>
                                        <select id="session" class="mob mb-2">
                                            <%
                                                while (rs.next()) {%>
                                            <option value="morning"><%=rs.getString("State")%></option>
                                            <%}%>

                                            <option value="" disabled selected></option>
                                            <option value="morning">Morning</option>
                                            <option value="afternoon">Afternoon</option>
                                            <option value="day">Entire day</option>
                                        </select>
                                    </div>


                                    <div class="mob">
                                        <label class="text-grey mr-1">Seat</label>
                                        <select id="seats" class="mob mb-2">
                                            <%
                                            while (rs.next()) {%>
                                            <option value="morning"><%=rs.getString("Slot")%></option>
                                            <%}%>
                                            <option value="MonS1">Seat1</option>
                                            <option value="MonS2">Seat2</option>
                                            <option value="MonS3">Seat3</option>
                                            <option value="MonS4">Seat4</option>
                                            <option value="MonS5">Seat5</option>
                                        </select>
                                    </div>


                                </div>
                            </div>


                            <div class="col-sm-10 list">
                                <div class="mb-2 row justify-content-between px-3">
                                    <label class="text-grey mr-1" id="Tue" value="Tue">Tue:</label>

                                    <div class="mob">
                                        <label class="text-grey mr-1">Session</label>
                                        <select id="session2" class="mob mb-2">
                                            <option value="" disabled selected></option>
                                            <option value="morning">Morning</option>
                                            <option value="afternoon">Afternoon</option>
                                            <option value="day">Entire day</option>
                                        </select>
                                    </div>
                                    <div class="mob">
                                        <label class="text-grey mr-1">Seat</label>
                                        <select id="seats2" class="mob mb-2">
                                            <option value="TueS1">Seat1</option>
                                            <option value="TueS2">Seat2</option>
                                            <option value="TueS3">Seat3</option>
                                            <option value="TueS4">Seat4</option>
                                            <option value="TueS5">Seat5</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-10 list">
                                <div class="mb-2 row justify-content-between px-3">
                                    <label class="text-grey mr-1" id="Wed" value="Wed">Wed:</label>


                                    <div class="mob">
                                        <label class="text-grey mr-1">Session</label>
                                        <select id="session3" class="mob mb-2">
                                            <option value="" disabled selected></option>
                                            <option value="morning">Morning</option>
                                            <option value="afternoon">Afternoon</option>
                                            <option value="day">Entire day</option>
                                        </select>
                                    </div>

                                    <div class="mob">
                                        <label class="text-grey mr-1">Seat</label>
                                        <select id="seats3" class="mob mb-2">
                                            <option value="WedS1">Seat1</option>
                                            <option value="WedS2">Seat2</option>
                                            <option value="WedS3">Seat3</option>
                                            <option value="WedS4">Seat4</option>
                                            <option value="WedS5">Seat5</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-10 list">
                                <div class="mb-2 row justify-content-between px-3">
                                    <label class="text-grey mr-1" id="Thu" value="Thu">Thu:</label>


                                    <div class="mob">
                                        <label class="text-grey mr-1">Session</label>
                                        <select id="session4" class="mob mb-2">
                                            <option value="" disabled selected></option>
                                            <option value="morning">Morning</option>
                                            <option value="afternoon">Afternoon</option>
                                            <option value="day">Entire day</option>
                                        </select>
                                    </div>
                                    <div class="mob">
                                        <label class="text-grey mr-1">Seat</label>
                                        <select id="seats4" class="mob mb-2">
                                            <option value="ThuS1">Seat1</option>
                                            <option value="ThuS2">Seat2</option>
                                            <option value="ThuS3">Seat3</option>
                                            <option value="ThuS4">Seat4</option>
                                            <option value="ThuS5">Seat5</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-10 list">
                                <div class="mb-2 row justify-content-between px-3">
                                    <label class="text-grey mr-1" id="Fri" value="Fri">Fri:</label>


                                    <div class="mob">
                                        <label class="text-grey mr-1">Session</label>
                                        <select id="session5" class="mob mb-2">
                                            <option value="" disabled selected></option>
                                            <option value="morning">Morning</option>
                                            <option value="afternoon">Afternoon</option>
                                            <option value="day">Entire day</option>
                                        </select>
                                    </div>
                                    <div class="mob">
                                        <label class="text-grey mr-1">Seat</label>
                                        <select id="seats5" class="mob mb-2">
                                            <option value="FriS1">Seat1</option>
                                            <option value="FriS2">Seat2</option>
                                            <option value="FriS3">Seat3</option>
                                            <option value="FriS4">Seat4</option>
                                            <option value="FriS5">Seat5</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <%
                                }
                                catch (Exception ex)
                                {
                                    System.out.println("Error: " + ex);
                                }
                            %>

                            <br><br>





                        </div>
                        <br>
                        <a><img src="https://i.ibb.co/h89cD9p/download-1.png" alt="download-1" class="center"></a>

                    </div>
                </div>
                <br>





            </form>
            <a href="Confirmation.html">
                <button class="button button1">Submit</button>
            </a>

            <button onclick="displayResult()">Change text</button>
        </div>
        <div style="height: 500px"></div>
    </div>
</div>
</body>

<script>
    $(function(){
        $("#nav-placeholder").load("nav-bar.jsp");
    });
</script>



<script>
    function displayResult() {
        if (document.getElementById('inputName').value) {
            console.log(document.getElementById('inputName').value);
        }
        if (document.getElementById('inputMail').value) {
            console.log(document.getElementById('inputMail').value);
        }
        if (document.getElementById('session').value){
            console.log('Mon');
            console.log(document.getElementById('session').value);
            console.log(document.getElementById('seats').value);
        }
        if (document.getElementById('session2').value){
            console.log('Tue');
            console.log(document.getElementById('session2').value);
            console.log(document.getElementById('seats2').value);
        }
        if (document.getElementById('session3').value){
            console.log('Wed');
            console.log(document.getElementById('session3').value);
            console.log(document.getElementById('seats3').value);
        }
        if (document.getElementById('session4').value){
            console.log('Thu');
            console.log(document.getElementById('session4').value);
            console.log(document.getElementById('seats4').value);
        }
        if (document.getElementById('session5').value){
            console.log('Fri');
            console.log(document.getElementById('session5').value);
            console.log(document.getElementById('seats5').value);
        }

        //send user details to server
        var redirectUrl = 'linkBooking';
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();
        //using jquery to post data dynamically
        var form = $('<form action="' + redirectUrl + '" method="post">' +
            '<input type="text" name="email" value="' + profile.getEmail() + '" />' +

            '<input type="text" name="Day1" value="' + document.getElementById('Mon') + '" />' +
            '<input type="text" name="Session1" value="' + document.getElementById('session').value + '" />' +
            '<input type="text" name="Seat1" value="' + document.getElementById('seats').value + '" />' +

            '<input type="text" name="Day2" value="' + document.getElementById('Tue') + '" />' +
            '<input type="text" name="Session2" value="' + document.getElementById('session2').value + '" />' +
            '<input type="text" name="Seat2" value="' + document.getElementById('seats2').value + '" />' +

            '<input type="text" name="Day3" value="' + document.getElementById('Wed') + '" />' +
            '<input type="text" name="Session3" value="' + document.getElementById('session3').value + '" />' +
            '<input type="text" name="Seat3" value="' + document.getElementById('seats3').value + '" />' +

            '<input type="text" name="Day4" value="' + document.getElementById('Thu') + '" />' +
            '<input type="text" name="Session4" value="' + document.getElementById('session4').value + '" />' +
            '<input type="text" name="Seat4" value="' + document.getElementById('seats4').value + '" />' +

            '<input type="text" name="Day5" value="' + document.getElementById('Fri') + '" />' +
            '<input type="text" name="Session5" value="' + document.getElementById('session5').value + '" />' +
            '<input type="text" name="Seat5" value="' + document.getElementById('seats5').value + '" />' +
            '</form>');
        $('body').append(form);
        form.submit();

    }
</script>



</html>