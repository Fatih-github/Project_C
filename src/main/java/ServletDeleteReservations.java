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
        String clientEmail = req.getParameter("email");
        String reservationId = req.getParameter("reservationId");
        String tableEmail = req.getParameter("tableEmail");

        ResultSet resultSetId = DatabaseManager.getResultsFromQuery("select firstname, lastname from employeeTable where emailaddress='"+clientEmail+"'");

        String firstName = "";
        String lastName = "";

        try {
            if(resultSetId.next()) {
                firstName = resultSetId.getString(1);
                lastName = resultSetId.getString(2);
                System.out.println(firstName+" "+lastName);
            }
        } catch (SQLException throwables) {
            System.out.println("employee name is missing");
            throwables.printStackTrace();
        }

        if (clientEmail.equals(tableEmail)) {
            DatabaseManager.executeSQLstatement("delete from invitationtable where reservationid='" + reservationId + "'");
            DatabaseManager.executeSQLstatement("delete from reservationtable where reservationid='" + reservationId + "'");
        }
        else {
            DatabaseManager.executeSQLstatement("update invitationtable set inviteeaccepted = array_remove(inviteeaccepted, '" + firstName+" "+lastName + "')" + "where '" + firstName+" "+lastName + "' = any(inviteeaccepted) and reservationid='"+reservationId+"'");
        }

        System.out.println(invitedby + " invitedby");
        System.out.println(clientEmail + " email");
        System.out.println(reservationId + " reservationid");
        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
