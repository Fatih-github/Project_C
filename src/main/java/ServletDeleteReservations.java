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

        ResultSet resultSetId = DatabaseManager.getResultsFromQuery("select firstname, lastname from employeeTable where emailAddress='"+email+"'");

        String resultNameString = "";
        String resultSurnameString = "";

        try {
            if(resultSetId.next()) {
                resultNameString = resultSetId.getString(1);
                resultSurnameString = resultSetId.getString(2);
                System.out.println(resultNameString+" "+resultSurnameString);
            }
        } catch (SQLException throwables) {
            System.out.println("employee name is missing");
            throwables.printStackTrace();
        }

        DatabaseManager.executeSQLstatement("delete from invitationtable where reservationid='" + reservationId + "'");
        DatabaseManager.executeSQLstatement("delete from reservationtable where reservationid='" + reservationId + "'");
        DatabaseManager.executeSQLstatement("delete from workspacetable where workspaceid='" + workspaceId + "'");

        System.out.println(invitedby + " invitedby");
        System.out.println(email + " email");
        System.out.println(reservationId + " reservationid");

        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
