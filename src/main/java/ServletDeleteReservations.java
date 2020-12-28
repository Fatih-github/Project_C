import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class ServletDeleteReservations extends HttpServlet{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String invitedby = req.getParameter("invitedby");
        String email = req.getParameter("email");
        String reservationId = req.getParameter("reservationId");
        String workspaceId = req.getParameter("workspaceId");
        String hostId = req.getParameter("employeeId");
        String inviteeAccepted = req.getParameter("inviteeaccepted");

        ResultSet resultSetId = DatabaseManager.getResultsFromQuery("select firstname, lastname, employeeID from employeeTable where emailAddress='"+email+"'");

        String firstName = "";
        String lastName = "";
        String id = "";

        try {
            if(resultSetId.next()) {
                firstName = resultSetId.getString(1);
                lastName = resultSetId.getString(2);
                req.setAttribute("Id", resultSetId.getString(3));
                id = resultSetId.getString(3);
                System.out.println(firstName+" "+lastName);
            }
        } catch (SQLException throwables) {
            System.out.println("employee name is missing");
            throwables.printStackTrace();
        }

        if (id.equals(hostId)) {
            DatabaseManager.executeSQLstatement("delete from invitationtable where reservationid='" + reservationId + "'");
            DatabaseManager.executeSQLstatement("delete from reservationtable where reservationid='" + reservationId + "'");
            DatabaseManager.executeSQLstatement("delete from workspacetable where workspaceid='" + workspaceId + "'");
        }
        else {
            DatabaseManager.executeSQLstatement("update invitationtable set inviteeaccepted = array_remove(inviteeaccepted, '" + firstName+" "+lastName + "')" + "where '" + firstName+" "+lastName + "' = any(inviteeaccepted) and reservationid='"+reservationId+"'");
        }

        System.out.println(invitedby + " invitedby");
        System.out.println(email + " email");
        System.out.println(reservationId + " reservationid");

        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
