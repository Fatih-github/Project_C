<%@ page import="java.util.Date" %>
<%@ page import="java.time.temporal.TemporalUnit" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
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
                        System.out.println("reservation: " + currentReservation);
                        dateMap.put(plannedDates.getString(1), currentReservation);
                    }

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
                    int weeknum = cal.get(Calendar.WEEK_OF_YEAR);
                    if (!(dayNum == 1 || dayNum == 7)){

                        String dateString = new SimpleDateFormat("EEE dd MMM yyyy").format(Date.from(new Date().toInstant().plus(i, ChronoUnit.DAYS)));
                        Reservation currentReservation;
                        if (dateMap.containsKey(dateString)){
                            currentReservation = dateMap.get(dateString);
                        }else{
                            currentReservation = new Reservation("n.a.", "Nothing planned", "Nothing planned");
                        }

                        %>
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                    <h3 style="margin-top: 1.2em" id="Date<%= ""+i %>"><%=dateString%></h3>
                                </div>
                                <div class="form-group col-md-3">
                                    <label>Timeslot</label>
                                    <select id="Timeslot<%= ""+i %>" class="form-control">
                                        <option selected><%= currentReservation.timeSlot%></option>
                                        <option value="morning">Morning</option>
                                        <option value="afternoon">Afternoon</option>
                                        <option value="day">Entire day</option>
                                    </select>
                                </div>

                                <div class="form-group col-md-3">
                                    <label>Room</label>
                                    <select id="Room<%= ""+i %>" class="form-control">
                                        <option selected><%= currentReservation.roomId%></option>
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
                    }else if(dayNum == 1){ // not a workday
                        %>
                            <div class="Week-row">
                                <div class="form-group col-md-3">
                                    <h3 style="margin-top: 1.2em" id="DateW"><%=  "Week: " + weeknum%></h3>
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



<script>
    var date = new Date();
    var dateArray = []
    var count = 0;

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

        var elements = document.getElementById("planRequestForm").elements;
        var amountOFElements = elements.length;

        for(i = 0; i < amountOFElements; i++){
            console.log("current i: " + i.toString());
            element = elements[i];
            try {
                if (document.getElementById('Timeslot' + i.toString()).value !== "Nothing planned") {
                    var entry = {
                        date: document.getElementById("Date" + i.toString()).innerText,
                        timeSlot: document.getElementById('Timeslot' + i.toString()).value,
                        room: document.getElementById('Room' + i.toString()).value

                    };
                    console.log("\tentry creation complete for day:" + i.toString());
                    console.log("\t\tdate: " + entry["date"]);
                    console.log("\t\ttimeslot: " + entry["timeSlot"]);
                    console.log("\t\troom: " + entry["room"]);
                    console.log("\tentry: " + JSON.stringify(entry))
                    submitList.push(JSON.stringify(entry));
                }
            } catch (e) {
                console.log("error in adding day at pos" + i.toString())
            }
        }

        var sub = submitList.toString().replaceAll("\"", "'");
        console.log("submitList:" + sub);
        form.append('<input type="text" name="submission" value="' + sub + '" />');
        form.submit();

    }
</script>
</html>