import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

public class ServletPlanSubmit extends HttpServlet{

    String dateStringToDateValue(String inp){
        String[] tokens = inp.split(" ");
        String out = tokens[1] + "/";
        switch (tokens[2]){
            case "jan.": out += "01/"; break;
            case "feb.": out += "02/"; break;
            case "mar.": out += "03/"; break;
            case "apr.": out += "04/"; break;
            case "may.": out += "05/"; break;
            case "jun.": out += "06/"; break;
            case "jul.": out += "07/"; break;
            case "aug.": out += "08/"; break;
            case "sep.": out += "09/"; break;
            case "oct.": out += "10/"; break;
            case "nov.": out += "11/"; break;
            case "dec.": out += "12/"; break;
        }
        out += tokens[3];
        return out;
    }



    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {


        System.out.println("\n\n ServletPlanSubmit JAVA code");

        String submission = req.getParameter("submission");
        System.out.println("submission: " + submission);

        ArrayList<HashMap<String, String>> submissionMaps = DataHelper.getHashmapsFromJsonString(submission);
        String email = req.getParameter("email");

        //get inviter
        ResultSet userId = DatabaseManager.getResultsFromQuery("select firstname, lastname, emailaddress from employeetable where emailaddress = '"+email+"'");

        String userEmailString = "";
        String userNameString = "";
        String userSurnameString = "";
        try {
            if(userId.next()) {
                userNameString = userId.getString(1);
                userSurnameString = userId.getString(2);
                userEmailString = userId.getString(3);
                System.out.println("userName: " + userId.getString(2));
                System.out.println("userSurname: " + userId.getString(3));
            }
        } catch (Exception throwables) {
            System.out.println("userId is missing");
            throwables.printStackTrace();
        }




        //loop over all submitted day
        for(HashMap<String, String> subMap: submissionMaps){
            String date = subMap.get("date");
            String timeslot = subMap.get("timeSlot");
            String room = subMap.get("room");
            String invites = subMap.get("invites");
            String eventId = subMap.get("eventId");
            System.out.println("date " +date);
            System.out.println("timeSlot " + timeslot);
            System.out.println("room " + room);
            System.out.println("invites " + invites);
            System.out.println("eventId " + eventId);

            //get next ID number for insertion
            int nextId = 0;
            try {
                ResultSet reservationIds = DatabaseManager.getResultsFromQuery("select reservationid from reservationtable order by reservationid desc limit 1");
                if (reservationIds.next()){
                    nextId = reservationIds.getInt(1) + 1;
                }

            } catch (SQLException e) {
                //e.printStackTrace();
            }




            // if there is no reservation at time
            if(!DatabaseManager.reservationExist(email, date)){
                //insert invitations
                if(!timeslot.equals("Nothing planned")) {
                    DatabaseManager.reservationTable.insertValues(nextId, room, email, "NULL", date, timeslot, eventId, dateStringToDateValue(date));
                    DatabaseManager.invitationTable.insertValues(userNameString + " " + userSurnameString, DataHelper.getAsDbArrayString(invites), "{}", email, nextId);
                }
            //if there is a standing reservation
            }else{

                try {
                    int Id = 0;
                    //update reservation variables
                    ResultSet rs = DatabaseManager.getResultsFromQuery("select * from reservationTable where emailAddress='" + email + "' and date='" + date + "'");
                    if (rs.next()) {
                        Id = rs.getInt("reservationId");
                        DatabaseManager.executeSQLstatement("update reservationTable set timeSlot='" + timeslot + "', roomid='" + room + "' where reservationId='" + Id + "'");
                        if(!rs.getString("timeSlot").equals(timeslot)){
                            DatabaseManager.executeSQLstatement("update invitationtable " + "set inviteeaccepted = '{}'::text[] " + "where reservationid='" + Id + "'");
                            DatabaseManager.executeSQLstatement("update invitationtable set invitee='" + DataHelper.getAsDbArrayString(invites) + "' where reservationid='" + Id +"'");
                        }
                    }

//                    //Find difference in invitee's and update invations
//                    boolean updateInvites = false;
//                    ResultSet inviteeSet = DatabaseManager.getResultsFromQuery("select invitee, inviteeaccepted from invitationTable where reservationId=" + Id);
//                    if (inviteeSet.next()) {
//                        HashMap<String, Boolean> containsMap = new HashMap<>();
//
//                        try {
//                            String[] a = (String[])rs.getArray(1).getArray();
//                            for(String entry : a ){
//                                containsMap.put(entry, false);
//                            }
//                        } catch (SQLException e) {
//                            e.printStackTrace();
//                        }
//
//                        try {
//                            String[] b = (String[])rs.getArray(1).getArray();
//                            for(String entry : b){
//                                containsMap.put(entry, false);
//                            }
//                        } catch (SQLException e) {
//                            e.printStackTrace();
//                        }
//
//                        //get list of strings of new invitees
//                        String invitesString = invites;
//                        if(invites.equals("null")){
//                            System.out.println("no invites found");
//                        }else{
//                            String[] invitesAsArray = invitesString.replace("[","").replace("]","").split(",");
//                            for(String inv : invitesAsArray) {
//                                if (containsMap.containsKey(inv)) {
//                                    containsMap.put(inv, true);
//                                }else{
//                                    updateInvites = true;
//                                }
//                            }
//                            if(containsMap.containsValue(false)){
//                                updateInvites = true;
//                            }
//                        }
//                    }



//                    ResultSet arrayEqualsResult = DatabaseManager.getResultsFromQuery("select array_length(array" + DataHelper.getAsQueryString(invites) + " , 1) = array_length(inviteeaccepted || array['1'], 1) - 1 + array_length(invitee || array['1'], 1) - 1 and invitee || inviteeaccepted = array" + DataHelper.getAsQueryString(invites) + " from invitationtable where reservationid=" + Id + "");
//
//
//                    if (arrayEqualsResult.next()){
//                        if (arrayEqualsResult.getString(1).equals("f")){
//                            DatabaseManager.executeSQLstatement("update invitationtable " + "set inviteeaccepted = '{}'::text[] " + "where reservationid='" + Id + "'");
//                            DatabaseManager.executeSQLstatement("update invitationtable set invitee='" + DataHelper.getAsDbArrayString(invites) + "' where reservationid='" + Id +"'");
//                        }
//                    }

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }




        }

        RequestDispatcher view = req.getRequestDispatcher("LoginPage/loginHTMLfile.jsp");
        view.forward(req, res);
    }
}
