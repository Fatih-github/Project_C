import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Arrays;

public class ServletUpdateReservations extends HttpServlet{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String invitedby = req.getParameter("invitedby");
        String reservationId = req.getParameter("reservationId");
        String email = req.getParameter("email");

        String date = req.getParameter("date");
        String timeSlot = req.getParameter("timeSlot");
        String roomId = req.getParameter("roomId");
        String invitee = req.getParameter("invitee");
        String[] invitee2 = invitee.split(",");
        System.out.println("array to string: " + Arrays.toString(invitee2).replace("[", "{'").replace("]", "'}"));

        String oldDate = req.getParameter("oldDate");
        String oldTimeSlot = req.getParameter("oldTimeSlot");
        String oldRoomId = req.getParameter("oldRoomId");
        String oldInvitee = req.getParameter("oldInvitee");
        String calendarId = req.getParameter("calendarId");
        System.out.println("Calender in servlet: " + calendarId);

        if (date != null && timeSlot != null && roomId != null && invitee != null)
        {
            if (date.isEmpty()) {
                date = oldDate.trim();
            }
            if (timeSlot.isEmpty()) {
                timeSlot = oldTimeSlot;
            }
            if (roomId.isEmpty() ) {
                roomId = oldRoomId;
            }
            if (invitee.isEmpty() || invitee.equals("undefined")) {
                invitee2 = oldInvitee.split(",");
            }
        }

        System.out.println("nieuwe gegevens");
        System.out.println(date + " sent reservations request to UpdateReservationServlet");
        System.out.println(timeSlot + " sent reservations request to UpdateReservationServlet");
        System.out.println(roomId + " sent reservations request to UpdateReservationServlet");
        System.out.println(invitee + " sent reservations request to UpdateReservationServlet");

        System.out.println("oude gegevens");
        System.out.println(oldDate + " sent reservations request to UpdateReservationServlet");
        System.out.println(oldTimeSlot + " sent reservations request to UpdateReservationServlet");
        System.out.println(oldRoomId + " sent reservations request to UpdateReservationServlet");
        System.out.println(oldInvitee + " sent reservations request to UpdateReservationServlet");
        System.out.println("--------------------");



        if (date != null &&
                !date.isEmpty() &&
                timeSlot != null &&
                !timeSlot.isEmpty() && roomId != null && !roomId.isEmpty() && invitee != null && !invitee.isEmpty() && oldDate != null && !oldDate.isEmpty() && oldTimeSlot != null && !oldTimeSlot.isEmpty() && oldRoomId != null && !oldRoomId.isEmpty() && oldInvitee != null && !oldInvitee.isEmpty()) {
            ResultSet result = DatabaseManager.getResultsFromQuery("select array_length(array" + Arrays.toString(invitee2).replace(", ", "', '").replace("[", "['").replace("]", "']") + " , 1) = array_length(inviteeaccepted || array['1'], 1) - 1 + array_length(invitee || array['1'], 1) - 1 and invitee || inviteeaccepted = array" + Arrays.toString(invitee2).replace(", ", "', '").replace("[", "['").replace("]", "']") + " from invitationtable\n" +
                    "where reservationid='" +reservationId.trim()+ "'");
            try {
                if(result.next()) {
                    System.out.println("result from query: " + result.getString(1));
                    if (result.getString(1).equals("f")) {
                        System.out.println("in result.getString(1).equals(f)");
                        DatabaseManager.executeSQLstatement("update invitationtable \n" +
                                "set inviteeaccepted = '{}'::text[] \n" +
                                "where reservationid='" + reservationId + "'");
                        DatabaseManager.executeSQLstatement("update invitationtable set invitee='" + Arrays.toString(invitee2).replace("[", "{").replace("]", "}") + "' where reservationid='" + reservationId +"'");
                    }
                }
            } catch (SQLException throwables) {
                System.out.println("updatereservations catch");
                throwables.printStackTrace();
            }


            System.out.println("result from query: " + result);
            DatabaseManager.executeSQLstatement("update reservationtable set date='" + date + "', timeslot='" + timeSlot + "' where reservationid='" + reservationId +"'");
            System.out.println("ik zit in big if statement");
            System.out.println("----------------------------------------------------------");
            RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
            view.forward(req, res);
        }
        else {
            System.out.println("ik zit in de else");
            System.out.println("----------------------------------------------------------");
            RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/updateReservations.jsp");
            view.forward(req, res);
        }
    }
}
