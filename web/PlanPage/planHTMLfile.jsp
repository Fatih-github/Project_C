<%@ page import="java.util.Date" %>
<%@ page import="java.time.temporal.TemporalUnit" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                //forloop adding days to page
                for (int i = 0; i < 14; i++) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(Date.from(new Date().toInstant().plus(i, ChronoUnit.DAYS)));
                    int dayNum = cal.get(Calendar.DAY_OF_WEEK);
                    if (!(dayNum == 1 || dayNum == 7)){
                        %>

                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <h3 style="margin-top: 1.2em" id="Date<%= ""+i %>"><%=  new SimpleDateFormat("EEE dd MMM yyyy").format(Date.from(new Date().toInstant().plus(i, ChronoUnit.DAYS)))%></h3>
                                </div>
                                <div class="form-group col-md-3">
                                    <label>Timeslot</label>
                                    <select id="Timeslot<%= ""+i %>" class="form-control">
                                        <option selected>Choose...</option>
                                        <option value="morning">Morning</option>
                                        <option value="afternoon">Afternoon</option>
                                        <option value="day">Entire day</option>
                                    </select>
                                </div>

                                <div class="form-group col-md-3">
                                    <label>Room</label>
                                    <select id="Room<%= ""+i %>" class="form-control">
                                        <option selected>Choose...</option>
                                        <option value="room1">room1</option>
                                        <option value="room2">room2</option>
                                        <option value="room3">room3</option>
                                        <option value="room4">room4</option>
                                        <option value="room5">room5</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-3">
                                    <label>Invite (ctrl + click)</label>
                                    <select id="Invite<%= ""+i %>" class="form-control" multiple="multiple" size="2">
                                        <option value="Peter">Peter</option>
                                        <option value="John">John</option>
                                        <option value="Fatih">Fatih</option>
                                        <option value="Jan">Jan</option>
                                        <option value="Luc">Luc</option>
                                    </select>
                                </div>
                            </div>
                        <%
                    }
                }
                //code after adding days to page
            %>
            </form>

            <%--<form>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite1" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateTwo"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite2" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateThree"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite3" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateFour"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite4" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateFive"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite5" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateSix"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite6" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateSeven"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite7" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateEight"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite8" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateNine"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite9" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <h3 style="margin-top: 1.2em" id="DateTen"></h3>
                    </div>
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
                        <label>Invite (ctrl + click)</label>
                        <select id="Invite10" class="form-control" multiple="multiple" size="2">
                            <option value="Peter">Peter</option>
                            <option value="John">John</option>
                            <option value="Fatih">Fatih</option>
                            <option value="Jan">Jan</option>
                            <option value="Luc">Luc</option>
                        </select>
                    </div>
                </div>
                <br>
                <button type="button" class="btn btn-primary" onclick="onPlan2()">Submit</button>
            </form>--%>
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
    var dateArray = []
    var count = 0;

    for(var i = 0; i < 14; i++)
    {
        if(date.getDay() === 6) {
            date.setDate(date.getDate() + 1)
        }
        if(date.getDay() === 5) {
            date.setDate(date.getDate() + 2)
        }
        dateArray[count++] = new Date(date.setDate(date.getDate() + 1)).toDateString();
        console.log(date.getDay());
        console.log(dateArray[i]);
    }

    // document.getElementById("DateOne").innerHTML = dateArray[0];
    // document.getElementById("DateTwo").innerHTML = dateArray[1];
    // document.getElementById("DateThree").innerHTML = dateArray[2];
    // document.getElementById("DateFour").innerHTML = dateArray[3];
    // document.getElementById("DateFive").innerHTML = dateArray[4];
    // document.getElementById("DateSix").innerHTML = dateArray[5];
    // document.getElementById("DateSeven").innerHTML = dateArray[6];
    // document.getElementById("DateEight").innerHTML = dateArray[7];
    // document.getElementById("DateNine").innerHTML = dateArray[8];
    // document.getElementById("DateTen").innerHTML = dateArray[9];


    var stored;
    $('#Invite2').select2({
        placeholder: 'Choose..'
    });
    //var stored = $('#Invite2').find(':selected');

    function onPlan2() {
        //send user details to server
        var redirectUrl = 'planSubmit';
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();


        var form = $('<form action="' + redirectUrl + '" method="post">' +
            '<input type="text" name="email" value="' + profile.getEmail() + '" />' +

            '</form>');
        $('body').append(form);


        var submitList = [];
        for (let i = 1; i < 11; i++) {
            console.log("\n\nreading day:" + i.toString());
            console.log("reading timeslot:" + i.toString() + " " + document.getElementById('Timeslot'+ i.toString()).value);
            var entry ={
                date : dateArray[i-1],
                timeSlot : document.getElementById('Timeslot'+ i.toString()).value,
                room : document.getElementById('Room'+ i.toString()).value

            };
            console.log("entry creation complete for day:" + i.toString());
            console.log("date: " + entry["date"]);
            console.log("timeslot: " + entry["timeSlot"]);
            console.log("room: " + entry["room"]);
            console.log("entry: " + JSON.stringify(entry))
            submitList.push(JSON.stringify(entry));
        }

        // console.log("submitList:" + submitList.toString());
        var sub = submitList.toString().replaceAll("\"", "'");
        console.log("submitList:" + sub);
        form.append('<input type="text" name="submission" value="' + sub + '" />');
        form.submit();

    }
</script>
</html>