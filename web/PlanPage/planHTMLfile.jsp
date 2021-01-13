<%@ page import="java.time.temporal.TemporalUnit" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OfficePlanager - Plan</title>
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


            <!-- Modal -->
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">officeMap</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="container modal-body" id="dynamic-content">
                            <img src="PlanPage/Resources/officeMap.jpg" alt="officeMap" class="img-fluid">
                            <div class="office1"><h3>1</h3></div>
                            <div class="office2"><h3>2</h3></div>
                            <div class="office3"><h3>3</h3></div>
                            <div class="office4"><h3>4</h3></div>
                            <div class="office5"><h3>5</h3></div>
                            <div class="office6"><h3>6</h3></div>
                            <div class="office7"><h3>7</h3></div>
                            <div class="office8"><h3>8</h3></div>
                            <div class="office9"><h3>9</h3></div>
                            <div class="office10"><h3>10</h3></div>
                            <div class="office11"><h3>11</h3></div>
                            <div class="office12"><h3>12</h3></div>
                            <div class="office13"><h3>13</h3></div>
                            <div class="office14"><h3>14</h3></div>
                            <div class="office15"><h3>15</h3></div>
                            <div class="office16"><h3>16</h3></div>
                            <div class="office17"><h3>17</h3></div>
                            <div class="office18"><h3>18</h3></div>
                            <div class="office19"><h3>19</h3></div>
                            <div class="office20"><h3>20</h3></div>
                            <div class="office21"><h3>21</h3></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>


            <form id="planRequestForm">
            <%



                //container class
                class Reservation{
                    String date;
                    String roomId;
                    String timeSlot;

                    public Reservation(String inp_date, String inp_roomId, String inp_timeSlot){
                        date = inp_date;
                        roomId = inp_roomId;
                        timeSlot = inp_timeSlot;
                    }

                    @Override
                    public String toString() {
                        return date + ", " + roomId + ", " + timeSlot;
                    }
                }
                HashMap<String, Reservation> dateMap = new HashMap<>();


                //container class
                class Employee{
                    String eFirstname;
                    String eLastname;
                    String eEmail;

                    public Employee(String fName, String lName, String email){
                        eFirstname = fName;
                        eLastname = lName;
                        eEmail = email;
                    }

                    @Override
                    public String toString() {
                        return eFirstname + " " + eLastname;
                    }
                }
                ArrayList<Employee> employeeList = new ArrayList<>();




                //ResultSet employeeResultSet = null;
                // get reservations based on email adress
                try {
                    System.out.println("\t\t planHTMLfile JSP/JAVA code");




                    //<editor-fold desc="database setup">
                    String email = request.getParameter("email");
                    Connection database = null;
                    Statement st = null;
                    Class.forName("org.postgresql.Driver");
                    database = DriverManager
                            .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                    "BaseFramePC", "none");
                    st = database.createStatement();
                    //</editor-fold>

                    String sql = "select date, roomid, timeslot from reservationtable where emailaddress='" + email + "'";
                    ResultSet plannedDates = st.executeQuery(sql);
                    //store all planned dates in a HashMap
                    while (plannedDates.next()){
                        Reservation currentReservation =
                                new Reservation(plannedDates.getString(1),
                                plannedDates.getString(2),
                                plannedDates.getString(3));
                        //System.out.println("reservation: " + currentReservation);
                        dateMap.put(plannedDates.getString(1), currentReservation);
                    }

                    sql = "select firstname, lastname, emailaddress from employeetable where emailaddress !='" + email + "'";
                    ResultSet employeeResultSet = st.executeQuery(sql);
                    //store all emplyees in a HashMap
                    while (employeeResultSet.next()){
                        Employee currentEmployee =
                                new Employee(employeeResultSet.getString(1),
                                        employeeResultSet.getString(2),
                                        employeeResultSet.getString(3));
                        //System.out.println("employee: " + currentEmployee);
                        employeeList.add(currentEmployee);
                    }

//                    sql = "select invitee, inviteeaccepted from invitationtable where emailaddress ='" + email + "'";
//                    ResultSet inviteResultSet = st.executeQuery(sql);
//                    //store all invites in a HashMap
//                    while (inviteResultSet.next()){
//                        PreviousInvitees currentPrevInv =
//                                new PreviousInvitees((String[])inviteResultSet.getArray(1).getArray(),
//                                        (String[])inviteResultSet.getArray(2).getArray());
//                        prevInviteesList.add(currentPrevInv);
//                    }



                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } catch (SQLException e) {
                    e.printStackTrace();
                }


                //for loop adding days to page
                for (int i = 0; i < 14; i++) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(Date.from(new Date().toInstant().plus(i, ChronoUnit.DAYS)));
                    int dayNum = cal.get(Calendar.DAY_OF_WEEK);
                    int weeknum = cal.get(Calendar.WEEK_OF_YEAR) +1;
                    if (!(dayNum == 1 || dayNum == 7)){

                        String dateString = new SimpleDateFormat("EEE dd MMM yyyy").format(Date.from(new Date().toInstant().plus(i, ChronoUnit.DAYS)));
                        Reservation currentReservation;
                        if (dateMap.containsKey(dateString)){
                            currentReservation = dateMap.get(dateString);
                        }else{
                            currentReservation = new Reservation("n.a.", "Flex", "Nothing planned");
                        }

                        %>
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <h3 class="dateHeader" style="margin-top: 1.2em" id="Date<%= ""+i %>"><%=dateString%></h3>
                                </div>
                                <div class="form-group col-md-3">
                                    <label>Timeslot</label>
                                    <select id="Timeslot<%= ""+i %>" class="form-control">
                                        <option selected><%= currentReservation.timeSlot%></option>
                                        <option value="morning">Morning</option>
                                        <option value="afternoon">Afternoon</option>
                                        <option value="day">Entire day</option>
                                        <option value="Nothing planned">Nothing planned</option>
                                    </select>
                                </div>



                                <div class="form-group col-md-3">
                                    <label>Room</label> <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#exampleModalCenter">?</button>
                                    <select id="Room<%= ""+i %>" class="form-control">
                                        <option selected><%= currentReservation.roomId%></option>
                                        <option value="Flex">Flex</option>
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
                                <div class="form-group col-md-3">
                                    <label>Invite</label>
                                    <select id="Invite<%= ""+i %>" class="form-control invites" multiple="multiple">


                                        <% for(Employee employee : employeeList) {
                                            String employeeNameString = employee.toString();
                                            String employeeEmail = employee.eEmail;

                                        %>
                                        <option value="<%=employeeNameString%>-<%=employeeEmail%>"><%=employeeNameString%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                        <%
                    }else if(dayNum == 1){ // not a workday
                        %>
                            <div class="Week-row">
                                <div class="form-group col-md-3">
                                    <h3 style="margin-top: 1.2em" id="DateW"> . . .</h3>
                                </div>
                            </div>
                        <%
                    }
                }

                //code after adding days to page
            %>
                <br>
                <button type="button" class="btn btn-primary" onclick="onPlan2()">Submit</button>
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


    //initialize invite library
    var inviteArray = []



    for (let i = 0; i < 14; i++) {
        console.log("Start of script")

        var curInvite = "#Invite" + i.toString()
        $(curInvite).select2({
            placeholder: 'Choose..',
        });
        console.log("Current invite "+ curInvite)
        $(curInvite).on("select2:select select2:unselect", function (e) {
            //this returns all the selected item
            inviteArray[i] = $(this).val();
        });
        //console.log(inviteArray[i])
    }
    console.log("Affter invite library load")




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
    function insertDate(dateFormat, index) {
        return new Promise((resolve, reject) => {
            var eventId = "";
            gapi.client.load('calendar', 'v3', function() {                    // load the calendar api (version 3)
                var request = gapi.client.calendar.events.insert({
                    'calendarId':        'primary',    // calendar ID
                    "sendNotifications": true,
                    "resource":            dateFormat        // pass event details with api call
                });

                // handle the response from our api call
                request.execute(function(resp) {
                    if(resp.status=='confirmed') {
                        eventId = resp.id
                        console.log("successfully inserted")
                        resolve(eventId+"num"+index)
                    } else {
                        console.log("failed to insert")
                        resolve(-1)
                    }
                    console.log(resp);
                });
            });
        });
    }


    var date = new Date();
    var dateArray = []
    var count = 0;


    function onPlan2() {
        var array = []
        var count = 0
        // var dateRows = document.getElementsByClassName("dateHeader");
        // for(var r  = 0; r < dateRows.length; r++){
        //     array[r] = dateRows[r].textContent
        // }
        //
        // console.log("Daterows: \n", dateRows);
        //
        // // for(var i = 0; i < 10; i++) {
        // //     try {
        // //         if (document.getElementById('Date' + i).innerHTML != null) {
        // //             array[count++] = [document.getElementById('Date' + i).innerHTML]
        // //             console.log(array[i])
        // //         }
        // //     } catch (e) {
        // //
        // //     }
        // // }
        //
        // console.log("Invite: " + Invite1)
        // var arrayInvites = inviteArray;
        // console.log("main array: " + arrayInvites[0], arrayInvites[1], arrayInvites[2], arrayInvites[3], arrayInvites[4], arrayInvites[5], arrayInvites[6], arrayInvites[7], arrayInvites[8])
        // var arrayInvitesSplit1 = [[], [], [], [], [], [], [], [], [], []];
        // var arrayInvitesSplit2 = [[], [], [], [], [], [], [], [], [], []];
        // console.log("first split array: " + arrayInvitesSplit1)
        // console.log("second split array: " + arrayInvitesSplit2)
        // console.log("lengte array " + arrayInvites.length)
        // for(let k = 0; k < arrayInvites.length; k++) {
        //     console.log("in de eerste loop" + k + arrayInvites[k])
        //     if(arrayInvites[k] !== undefined) {
        //         for (let j = 0; j < arrayInvites[k].length; j++) {
        //             console.log(arrayInvites[k][j].split('-')[0] + "data")
        //             console.log(arrayInvites[k][j].split('-')[1] + "data2")
        //             arrayInvitesSplit1[k][j] = arrayInvites[k][j].split('-')[0]
        //             arrayInvitesSplit2[k][j] = arrayInvites[k][j].split('-')[1]
        //             console.log("first split array in loop: " + arrayInvitesSplit1[k][j])
        //             console.log("second split array in loop: " + arrayInvitesSplit2[k][j])
        //             console.log("---------------------------------------------------------")
        //         }
        //     }
        //     else {
        //         arrayInvitesSplit1[k] = []
        //         arrayInvitesSplit2[k] = []
        //     }
        // }
        // console.log("Split voor streep: " + arrayInvitesSplit1)
        // console.log("Split na streep: " + arrayInvitesSplit2)
        //
        // for(var i = 1; i < 11; i++) {
        //     if(document.getElementById('Room'+i).value !== null && document.getElementById('Room'+i).value !== "Choose...") {
        //         console.log(document.getElementById('Room'+i).value)
        //         var startTime;
        //         var endTime;
        //
        //         if(document.getElementById('Timeslot'+i).value === "Morning") {
        //             startTime = "08:00";
        //             endTime = "12:00";
        //         }
        //         else if(document.getElementById('Timeslot'+i).value === "Afternoon") {
        //             startTime = "13:00";
        //             endTime = "17:00";
        //         }
        //         else {
        //             startTime = "08:00";
        //             endTime = "17:00";
        //         }
        //
        //         var startDate = new Date(array[i-1] + " " + startTime);
        //         let startDateString = startDate.toISOString();
        //
        //         var endDate = new Date(array[i-1] + " " + endTime);
        //         let endDateString = endDate.toISOString();
        //
        //         console.log(array[i-1])
        //         console.log(document.getElementById('Timeslot'+i).value)
        //
        //         var dateFormat = {
        //             "summary": "NGTI Reservation - " + document.getElementById('Room'+i).value,
        //             "start": {
        //                 "dateTime": startDateString
        //             },
        //             "end": {
        //                 "dateTime": endDateString
        //             },
        //             "attendees": [
        //                 //{"email": "example@gmail.com"},
        //             ]
        //         };
        //
        //         console.log("arrayInvitesSplit2[i-1]: " + arrayInvitesSplit2[i-1] + " length" + arrayInvitesSplit2[i-1].length)
        //         for(var j = 0; arrayInvitesSplit2[i-1] !== [] && j < arrayInvitesSplit2[i-1].length; j++) {
        //             dateFormat.attendees.push(
        //                 {
        //                     "email": arrayInvitesSplit2[i-1][j].toString()
        //                     // "responseStatus": 'accepted'
        //                 }
        //             )
        //         }
        //         console.log("dateFormat attendees: " + dateFormat.attendees)
        //
        //         var eventIdArray = [];
        //         var promises = [];
        //         var value = "";
        //
        //         promises.push(insertDate(dateFormat, i));
        //
        //         Promise.allSettled(promises).then(function (results) {
        //             // 'results' is an array containing all the event IDs
        //             console.log(results[0].value);
        //             eventIdArray[results[0].value.split('num')[1]-1] = results[0].value.split('num')[0];
        //             console.log("eventIdArray: " + eventIdArray[results[0].value.split('num')[1]-1] + " index: " + (results[0].value.split('num')[1]-1));
        //         });
        //     }
        // }


        for (let i = 0; i < 14; i++) {
            console.log("loop invite log" + i + ": " + inviteArray[i])
        }

        //send user details to server
        var redirectUrl = 'planSubmit';
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();


        //load email from google
        var form = $('<form action="' + redirectUrl + '" method="post">' +
            '<input type="text" name="email" value="' + profile.getEmail() + '" />' +

            '</form>');
        $('body').append(form);



        // add submit days to json
        var submitList = [];
        var elements = document.getElementById("planRequestForm").elements;
        var amountOFElements = elements.length;
        for(i = 0; i < amountOFElements; i++){
            console.log("current i: " + i.toString());
            element = elements[i];
            try {
                if (document.getElementById('Timeslot' + i.toString()).value) {

                    console.log("\tentry creation started for day:" + i.toString());
                    var entry = {
                        date: document.getElementById("Date" + i.toString()).innerText,
                        timeSlot: document.getElementById('Timeslot' + i.toString()).value,
                        room: document.getElementById('Room' + i.toString()).value,
                        invites: inviteArray[i]
                    };
                    console.log("\tentry creation complete for day:" + i.toString());
                    console.log("\t\tdate: " + entry["date"]);
                    console.log("\t\ttimeslot: " + entry["timeSlot"]);
                    console.log("\t\troom: " + entry["room"]);
                    console.log("\t\tinvites: " + entry["invites"]);
                    console.log("\tentry: " + JSON.stringify(entry))
                    submitList.push(JSON.stringify(entry));
                }
            } catch (e) {
                console.log("error in adding day at pos" + i.toString())
            }
        }

        //actually post data
        var sub = submitList.toString().replaceAll("\"", "'");
        console.log("submitList:" + sub);
        form.append('<input type="text" name="submission" value="' + sub + '" />');
        form.submit();

    }
</script>
</html>