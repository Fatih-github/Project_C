import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class ServletAcceptInvites extends HttpServlet{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String Date = req.getParameter("Date");
        String TimeSlot = req.getParameter("TimeSlot");
        String Room = req.getParameter("Room");
        String ReservationId = req.getParameter("ReservationId");

        //boolean rs = DatabaseManager.executeSQLstatement("delete from loginattempts where attime='" + time + "' and email='"+ email +"' and loginname='" + name + "'");

        System.out.println(Date + " Date accepted");
        System.out.println(TimeSlot + " Timeslot accepted");
        System.out.println(Room + " room accepted");
        System.out.println(ReservationId + " ReservationId accepted");

        String email = req.getParameter("email");

        ResultSet resultSetId = DatabaseManager.getResultsFromQuery("select  firstname, lastname from employeeTable where emailAddress='"+email+"'");

        String firstName = null;
        String lastName = null;

        try {
            if(resultSetId.next()) {
                firstName = resultSetId.getString(1);
                lastName = resultSetId.getString(2);
            }
        } catch (SQLException throwables) {
            System.out.println("reservation id is missing");
            throwables.printStackTrace();
        }

        DatabaseManager.executeSQLstatement("update invitationtable set invitee = array_remove(invitee, '" + firstName+" "+lastName + "')" + "where '" + firstName+" "+lastName + "' = any(invitee) and reservationid='"+ReservationId+"'");
        DatabaseManager.executeSQLstatement("update invitationtable set inviteeaccepted = array_append(inviteeaccepted, '" + firstName+" "+lastName + "') where reservationid='" + ReservationId + "'");


        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
