<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
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
    <link rel="stylesheet" type="text/css" href="PlanPage/planCSSfile.css"/>

</head>

<body>
<div id="nav-placeholder"></div>

<div class="container" style="min-height: 48em">
    <div class="card border-0 shadow my-5">
        <div class="card-body p-5" style="min-height: 46em">
            <form>
                <%
                    Connection database = null;
                    Statement st = null;
                    try {
                        Class.forName("org.postgresql.Driver");
                        database = DriverManager
                                .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                        "BaseFramePC", "none");
                        st = database.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                ResultSet.CONCUR_READ_ONLY);
                        String sql = "select * from employeetable";
                        ResultSet rs = st.executeQuery(sql);
                %>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateOne"></h3>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot1" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room1" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite1" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateTwo"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot2" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room2" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite2" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateThree"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot3" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room3" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite3" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateFour"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot4" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room4" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite4" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateFive"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot5" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room5" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite5" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateSix"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot6" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room6" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite6" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateSeven"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot7" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room7" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite7" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateEight"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot8" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room8" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite8" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateNine"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot9" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room9" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite9" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateTen"></h3>
                    </div>
                    <%
                        rs.beforeFirst();
                    %>
                    <div class="form-group col-md-3">
                        <label>Timeslot</label>
                        <select id="Timeslot10" class="form-control">
                            <option selected>Choose...</option>
                            <option value="morning">Morning</option>
                            <option value="afternoon">Afternoon</option>
                            <option value="day">Entire day</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Room</label>
                        <select id="Room10" class="form-control">
                            <option selected>Choose...</option>
                            <option value="room1">room1</option>
                            <option value="room2">room2</option>
                            <option value="room3">room3</option>
                            <option value="room4">room4</option>
                            <option value="room5">room5</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Invite</label>
                        <select id="Invite10" class="form-control" multiple="multiple">
                            <% while (rs.next()) { %>
                            <option value="<%=rs.getString("employeetable_employeeid")%>"><%=rs.getString("employeetable_firstname")%> <%=rs.getString("employeetable_lastname")%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <br>
                <button type="button" class="btn btn-primary" onclick="onPlan2()">Submit</button>
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

<script>
    $(function(){
        $("#nav-placeholder").load("nav-bar.jsp");
    });
</script>


<script>
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

    document.getElementById("DateOne").innerHTML = array[0]
    document.getElementById("DateTwo").innerHTML = array[1]
    document.getElementById("DateThree").innerHTML = array[2]
    document.getElementById("DateFour").innerHTML = array[3]
    document.getElementById("DateFive").innerHTML = array[4]
    document.getElementById("DateSix").innerHTML = array[5]
    document.getElementById("DateSeven").innerHTML = array[6]
    document.getElementById("DateEight").innerHTML = array[7]
    document.getElementById("DateNine").innerHTML = array[8]
    document.getElementById("DateTen").innerHTML = array[9]

    // var data = [];
    // var stored;
    // $('#Invite2').on('change',function() {
    //     stored = $(this).val();
    //     alert($(this).val());
    //     console.log(stored);
    // });

    var Invite1;
    $('#Invite1').select2({
        placeholder: 'Choose..',
    });
    $("#Invite1").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite1 = $(this).val();
    })

    var Invite2;
    $('#Invite2').select2({
        placeholder: 'Choose..',
    });
    $("#Invite2").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite2 = $(this).val();
    })

    var Invite3;
    $('#Invite3').select2({
        placeholder: 'Choose..',
    });
    $("#Invite3").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite3 = $(this).val();
    })

    var Invite4;
    $('#Invite4').select2({
        placeholder: 'Choose..',
    });
    $("#Invite4").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite4 = $(this).val();
    })

    var Invite5;
    $('#Invite5').select2({
        placeholder: 'Choose..',
    });
    $("#Invite5").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite5 = $(this).val();
    })

    var Invite6;
    $('#Invite6').select2({
        placeholder: 'Choose..',
    });
    $("#Invite6").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite6 = $(this).val();
    })

    var Invite7;
    $('#Invite7').select2({
        placeholder: 'Choose..',
    });
    $("#Invite7").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite7 = $(this).val();
    })

    var Invite8;
    $('#Invite8').select2({
        placeholder: 'Choose..',
    });
    $("#Invite8").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite8 = $(this).val();
    })

    var Invite9;
    $('#Invite9').select2({
        placeholder: 'Choose..',
    });
    $("#Invite9").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite9 = $(this).val();
    })

    var Invite10;
    $('#Invite10').select2({
        placeholder: 'Choose..',
    });
    $("#Invite10").on("select2:select select2:unselect", function (e) {
        //this returns all the selected item
        Invite10 = $(this).val();
    })

    function onPlan2() {
        $.confirm({
            title: 'Reservation',
            content: 'Your reservation has been made',
            buttons: {
                confirm: function () {
                    //send user details to server
                    var redirectUrl = 'planSubmit';
                    var auth2 = gapi.auth2.getAuthInstance();
                    var profile = auth2.currentUser.get().getBasicProfile();
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="email" value="' + profile.getEmail() + '" />' +

                        '<input type="text" name="DateOne" value="' + array[0] + '" />' +
                        '<input type="text" name="Timeslot1" value="' + document.getElementById('Timeslot1').value + '" />' +
                        '<input type="text" name="Room1" value="' + document.getElementById('Room1').value + '" />' +
                        '<input type="text" name="Invite1" value="' + Invite1 + '" />' +

                        '<input type="text" name="DateTwo" value="' + array[1] + '" />' +
                        '<input type="text" name="Timeslot2" value="' + document.getElementById('Timeslot2').value + '" />' +
                        '<input type="text" name="Room2" value="' + document.getElementById('Room2').value + '" />' +
                        '<input type="text" name="Invite2" value="' + Invite2 + '" />' +

                        '<input type="text" name="DateThree" value="' + array[2] + '" />' +
                        '<input type="text" name="Timeslot3" value="' + document.getElementById('Timeslot3').value + '" />' +
                        '<input type="text" name="Room3" value="' + document.getElementById('Room3').value + '" />' +
                        '<input type="text" name="Invite3" value="' + Invite3 + '" />' +

                        '<input type="text" name="DateFour" value="' + array[3] + '" />' +
                        '<input type="text" name="Timeslot4" value="' + document.getElementById('Timeslot4').value + '" />' +
                        '<input type="text" name="Room4" value="' + document.getElementById('Room4').value + '" />' +
                        '<input type="text" name="Invite4" value="' + Invite4 + '" />' +

                        '<input type="text" name="DateFive" value="' + array[4] + '" />' +
                        '<input type="text" name="Timeslot5" value="' + document.getElementById('Timeslot5').value + '" />' +
                        '<input type="text" name="Room5" value="' + document.getElementById('Room5').value + '" />' +
                        '<input type="text" name="Invite5" value="' + Invite5 + '" />' +

                        '<input type="text" name="DateSix" value="' + array[5] + '" />' +
                        '<input type="text" name="Timeslot6" value="' + document.getElementById('Timeslot6').value + '" />' +
                        '<input type="text" name="Room6" value="' + document.getElementById('Room6').value + '" />' +
                        '<input type="text" name="Invite6" value="' + Invite6 + '" />' +

                        '<input type="text" name="DateSeven" value="' + array[6] + '" />' +
                        '<input type="text" name="Timeslot7" value="' + document.getElementById('Timeslot7').value + '" />' +
                        '<input type="text" name="Room7" value="' + document.getElementById('Room7').value + '" />' +
                        '<input type="text" name="Invite7" value="' + Invite7 + '" />' +

                        '<input type="text" name="DateEight" value="' + array[7] + '" />' +
                        '<input type="text" name="Timeslot8" value="' + document.getElementById('Timeslot8').value + '" />' +
                        '<input type="text" name="Room8" value="' + document.getElementById('Room8').value + '" />' +
                        '<input type="text" name="Invite8" value="' + Invite8 + '" />' +

                        '<input type="text" name="DateNine" value="' + array[8] + '" />' +
                        '<input type="text" name="Timeslot9" value="' + document.getElementById('Timeslot9').value + '" />' +
                        '<input type="text" name="Room9" value="' + document.getElementById('Room9').value + '" />' +
                        '<input type="text" name="Invite9" value="' + Invite9 + '" />' +

                        '<input type="text" name="DateTen" value="' + array[9] + '" />' +
                        '<input type="text" name="Timeslot10" value="' + document.getElementById('Timeslot10').value + '" />' +
                        '<input type="text" name="Room10" value="' + document.getElementById('Room10').value + '" />' +
                        '<input type="text" name="Invite10" value="' + Invite10 + '" />' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                }
            }
        });
    }
</script>
</html>