<%@ page import="java.util.Date" %>
<%@ page import="java.time.temporal.TemporalUnit" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
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

                    public Employee(String fName, String lName){
                        eFirstname = fName;
                        eLastname = lName;
                    }

                    @Override
                    public String toString() {
                        return eFirstname + " " + eLastname;
                    }
                }
                ArrayList<String> employeeList = new ArrayList<>();

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

                    sql = "select firstname, lastname from employeetable where emailaddress !='" + email + "'";
                    ResultSet employeeResultSet = st.executeQuery(sql);
                    //store all emplyees in a HashMap
                    while (employeeResultSet.next()){
                        Employee currentEmployee =
                                new Employee(employeeResultSet.getString(1),
                                        employeeResultSet.getString(2));
                        //System.out.println("employee: " + currentEmployee);
                        employeeList.add(currentEmployee.toString());
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
                                    <h3 style="margin-top: 1.2em" id="Date<%= ""+i %>"><%=dateString%></h3>
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
                                        <% for(String employeeNameString : employeeList) {%>
                                        <option value="<%=employeeNameString%>"><%=employeeNameString%></option>
                                        <%
                                            //System.out.println("Made id: Invite" + i);
                                            }
                                        %>

<%--                                        <% while (employeeResultSet.next()) { %>--%>
<%--                                        <option value="<%=employeeResultSet.getString("firstname")%> <%=employeeResultSet.getString("lastname")%>"><%=employeeResultSet.getString("firstname")%> <%=employeeResultSet.getString("lastname")%></option>--%>
<%--                                        <%--%>
<%--                                            }--%>
<%--                                        %>--%>
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







    var date = new Date();
    var dateArray = []
    var count = 0;


    function onPlan2() {


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