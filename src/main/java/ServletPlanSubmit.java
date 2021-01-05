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
            System.out.println("date " +date);
            System.out.println("timeSlot " + timeslot);
            System.out.println("room " + room);
            System.out.println("invites " + invites);

            //get next ID number for insertion
            int nextId = 0;
            try {
                ResultSet reservationIds = DatabaseManager.getResultsFromQuery("select reservationid from reservationtable order by reservationid desc limit 1");
                if (reservationIds.next()){
                    nextId = reservationIds.getInt(1) + 1;
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }


            //Find difference in invitee's



            if(!DatabaseManager.reservationExist(email, date)){
                DatabaseManager.reservationTable.insertValues(nextId, room, email, "NULL", date, timeslot);
            }else{

                try {

                    //update invation
                    ResultSet arrayEqualsResult = DatabaseManager.getResultsFromQuery("select array_length(array" + DataHelper.getAsDbArrayString(invites) + " , 1) = array_length(inviteeaccepted || array['1'], 1) - 1 + array_length(invitee || array['1'], 1) - 1 and invitee || inviteeaccepted = array" + DataHelper.getAsDbArrayString(invites) + " from invitationtable" + "where reservationid='" +reservationId.trim()+ "'");
                    if (arrayEqualsResult.next()){
                        if (result.getString(1).equals("f")){

                        }
                    }

                    //update reservation variables
                    ResultSet rs = DatabaseManager.getResultsFromQuery("select * from reservationTable where emailAddress='" + email + "' and date='" + date + "'");
                    if (rs.next()) {
                        int Id = rs.getInt("reservationId");
                        DatabaseManager.executeSQLstatement("update reservationTable set timeSlot='" + timeslot + "' where reservationId='" + Id + "'");
                        DatabaseManager.executeSQLstatement("update reservationTable set reservationId='" + nextId + "'");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }




            //insert invitations
            if(!timeslot.equals("Nothing planned")) {
                DatabaseManager.invitationTable.insertValues(userNameString + " " + userSurnameString, DataHelper.getAsDbArrayString(invites), "{}", email, nextId);
            }

        }

        RequestDispatcher view = req.getRequestDispatcher("LoginPage/loginHTMLfile.jsp");
        view.forward(req, res);
    }
}
