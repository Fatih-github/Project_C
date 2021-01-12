import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class ServletDeclineInvites extends HttpServlet{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String Date = req.getParameter("Date");
        String TimeSlot = req.getParameter("TimeSlot");
        String Room = req.getParameter("Room");
        String ReservationId = req.getParameter("ReservationId");
        String WorkspaceId = req.getParameter("WorkspaceId");

        //boolean rs = DatabaseManager.executeSQLstatement("delete from loginattempts where attime='" + time + "' and email='"+ email +"' and loginname='" + name + "'");

        System.out.println(Date + " Date declined");
        System.out.println(TimeSlot + " Timeslot declined");
        System.out.println(Room + " room declined");
        System.out.println(ReservationId + " ReservationId declined");
        System.out.println(WorkspaceId + " WorkspaceId declined");

        String email = req.getParameter("email");

        ResultSet resultSetId = DatabaseManager.getResultsFromQuery("select  firstname, lastname from employeeTable where emailAddress='"+email+"'");

        String firstName = "";
        String lastName = "";

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

        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
