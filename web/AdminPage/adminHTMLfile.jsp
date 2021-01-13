<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>OfficePlanager - Admin</title>
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
    <link rel = "stylesheet" type = "text/css" href="InvitationsPage/invitationsCSSfile.css"/>
</head>

<body>
    <div id="nav-placeholder"></div>

    <div class="container" style="min-height: 48em">
        <div class="card border-0 shadow my-5">
            <div class="card-body p-5" style="min-height: 46em">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab1" data-toggle="tab"><button type="button" class="btn btn-primary">Max Reservations</button></a></li>
                    <li><a href="#tab2" data-toggle="tab"><button type="button" style="margin-left: 1em" class="btn btn-primary">Users</button></a></li>
                </ul>

                <br>

                <div class="tab-content">
                    <div class="tab-pane active" id="tab1">
                        <table id="adminTable2" class="table table-bordered table-responsive-sm table-hover">
                            <br>
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Max Reservations</th>
                            </tr>
                            </thead>


                            <%

                                System.out.println("\tAdminSubmit JSP");

                                String name2 = request.getParameter("name");
                                String email2 = request.getParameter("email");

                                System.out.println("\t\tuser: " + name2);
                                System.out.println("\t\temail: " + email2);
                                Connection database2 = null;
                                Statement st2 = null;
                                try {

                                    System.out.println("\t\t InvitationsHTMLfile JAVA code");

                                    Class.forName("org.postgresql.Driver");
                                    database2 = DriverManager
                                            .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                                    "BaseFramePC", "none");
                                    st2 = database2.createStatement();
                                    String sql2 = "select to_char(date, 'Dy Mon DD YYYY') as newdate, maxreservations from maxreservationtable where date > current_date order by date";
                                    ResultSet rs2 = st2.executeQuery(sql2);
                                    int i = 0;
                                    while (rs2.next()) {
                            %>

                            <tbody id="myTable2">
                            <tr class="table">
                                <td class="table">
                                    <h3><%=rs2.getString("newdate")%></h3>
                                </td>
                                <td class="table">
                                    <input class="form-control" Id="maxamount<%=i%>" type="number" style="text-align: center" placeholder="<%=rs2.getString("maxreservations")%>">
                                </td>
                            </tr>
                            </tbody>
                            <%
                                        i++;
                                    }
                                }
                                catch (Exception ex) {
                                    System.out.println("Error: " + ex);
                                }
                            %>
                        </table>

                        <table id="adminTable3" class="table table-bordered table-responsive-sm table-hover">
                            <thead>
                            <tr class="row">
                                <th class="col">Change all amounts:</th>
                                <th class="col"><input class="form-control" Id="totalamount" type="number" style="text-align: center"></th>
                            </tr>
                            </thead>
                        </table>
                        <button type="button" class="btn btn-primary" onclick="onSubmitMaxEmployees()">Submit</button>
                    </div>


                    <div class="tab-pane" id="tab2">
                        <input class="form-control" id="myInput" type="text" placeholder="Search for an user..">
                        <table id="adminTable" class="table table-bordered table-responsive-sm table-hover">
                            <br>
                            <thead>
                            <tr>
                                <th>Emailaddress</th>
                                <th>Name</th>
                                <th>Admin</th>
                                <th>BHV'er</th>
                            </tr>
                            </thead>

                            <%

                                System.out.println("\tInvitations JSP");

                                String name = request.getParameter("name");
                                String email = request.getParameter("email");

                                System.out.println("\t\tuser: " + name);
                                System.out.println("\t\temail: " + email);
                                Connection database = null;
                                Statement st = null;
                                try {

                                    System.out.println("\t\t InvitationsHTMLfile JAVA code");

                                    Class.forName("org.postgresql.Driver");
                                    database = DriverManager
                                            .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                                    "BaseFramePC", "none");
                                    st = database.createStatement();
                                    String sql = "select emailaddress, firstname||' '||lastname as name , isadmin::varchar, isbhv::varchar from employeetable \n" +
                                            "except select emailaddress, firstname||' '||lastname as name , isadmin::varchar, isbhv::varchar from employeetable where emailaddress='" + email + "' order by name ";
                                    ResultSet rs = st.executeQuery(sql);
                                    while (rs.next()) {
                            %>
                            <tbody id="myTable">
                                <tr class="table">
                                    <td class="table"><%=rs.getString("emailaddress")%></td>
                                    <td class="table"><%=rs.getString("name")%></td>
                                    <td class="table">
                                        <form>
                                            <select class="isAdmin" onchange="onSubmit()">
                                                <option disabled selected><%=rs.getString("isadmin")%></option>
                                                <option value="false">false</option>
                                                <option value="true">true</option>
                                            </select>
                                        </form>
                                    </td>
                                    <td class="table">
                                        <form>
                                            <select class="isBHV" onchange="onSubmit()">
                                                <option disabled selected><%=rs.getString("isbhv")%></option>
                                                <option value="false">false</option>
                                                <option value="true">true</option>
                                            </select>
                                        </form>
                                    </td>
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
        <%--                <button type="button" onclick="onSubmit()" class="btn btn-primary">Submit</button>--%>
                    </div>
                </div>
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

    $('.isAdmin').select2({
        width: '100%',
        placeholder: 'Choose..',
        minimumResultsForSearch: -1
    });

    $('.isBHV').select2({
        width: '100%',
        placeholder: 'Choose..',
        minimumResultsForSearch: -1
    });

    function onSubmit() {
        var auth2 = gapi.auth2.getAuthInstance();
        var profile = auth2.currentUser.get().getBasicProfile();

        var data = [...document.querySelectorAll("#adminTable tbody tr")]
            .map(tr=>[...tr.children].map(td=>{
                let s=td.querySelector('select');
                return s && s.value || td.textContent })
                .join(',')).join('-')
        console.log("data: " + data)
        console.log("type of alert: " + typeof data)

        $.confirm({
            title: 'user data',
            content: 'Are you sure you want to change the user data?',
            buttons: {
                confirm: function () {
                    var redirectUrl = 'linkAdminSubmit';
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="Data" value="' + data + '" />' +
                        '<input type="text" name="email" value="' + profile.getEmail() + '" />' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                },
                cancel: function () {

                }
            }
        });
    }

    function onSubmitMaxEmployees() {
        var array1 = []
        for (let i = 0; i < 10; i++) {
            if(document.getElementById("maxamount"+i).value.length > 0) {
                array1[i] = document.getElementById("maxamount"+i).value;
            }
            else if (document.getElementById("totalamount").value.length > 0) {
                array1[i] = document.getElementById("totalamount").value;
            }
            else {
                array1[i] = -1;
            }
        }


        $.confirm({
            title: 'max employees',
            content: 'Are you sure you want to change the max employees per day?',
            buttons: {
                confirm: function () {
                    var redirectUrl = 'linkAdminSubmit';
                    //using jquery to post data dynamically
                    var form = $('<form action="' + redirectUrl + '" method="post">' +
                        '<input type="text" name="employeeAmount" value="' + array1 + '" />' +
                        '</form>');
                    $('body').append(form);
                    form.submit();
                },
                cancel: function () {

                }
            }
        });
    }


</script>

</html>