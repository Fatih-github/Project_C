<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OfficePlanager - Overview</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.5.2/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <meta name="google-signin-client_id" content="621238999880-9rj10o12b4dvsi92ou1m74s8tmmblp3c.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
    <link rel = "stylesheet" type = "text/css" href="InvitationsPage/invitationsCSSfile.css"/>
</head>

<body>
    <div id="nav-placeholder"></div>

    <div class="container" style="min-height: 48em">
        <div class="card border-0 shadow my-5">
            <div class="card-body p-5" style="min-height: 46em">
                <input class="form-control" id="myInput" type="text" placeholder="Search for an user..">
                <br>
                <table id="adminTable" class="table table-bordered table-responsive-sm table-hover">
                    <thead>
                    <tr>
                        <th>Date</th>
                        <th>TimeSlot</th>
                        <th>Room</th>
                        <th>Attendees</th>
                        <th>Invitedby</th>
                    </tr>
                    </thead>

                    <%
                        System.out.println("\tOverview JSP");

                        Connection database = null;
                        Statement st = null;
                        try {

                            System.out.println("\t\t OverviewHTMLfile JAVA code");

                            Class.forName("org.postgresql.Driver");
                            database = DriverManager
                                    .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                            "BaseFramePC", "none");
                            st = database.createStatement();
                            String sql = "select to_char(date, 'Dy Mon DD YYYY') as date, timeslot, invitee, inviteeaccepted, roomid, res.reservationid, invitedby, res.workspaceid \n" +
                                    "from reservationtable res join workspacetable wrk on res.workspaceid=wrk.workspaceid join invitationtable inv on inv.reservationid=res.reservationid \n" +
                                    "order by res.date";
                            ResultSet rs = st.executeQuery(sql);
                            while (rs.next()) {
                    %>
                    <tbody id="myTable">
                        <tr class="table">
                            <td class="table"><%=rs.getString("date")%></td>
                            <td class="table"><%=rs.getString("timeslot")%></td>
                            <td class="table"><%=rs.getString("roomid")%></td>
                            <td class="table"><%=rs.getString("inviteeaccepted").replace("{", " ").replace("}", " ").replace("\"", "").replace(",", ", ")%></td>
                            <td class="table"><%=rs.getString("invitedby")%></td>
                        </tr>
                    </tbody>
                    <%
                            }
                        }
                        catch (Exception ex) {
                            System.out.println("Error: " + ex);
                        }
                    %>
                </table>
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
    $(document).ready(function(){
        $("#myInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>

</html>