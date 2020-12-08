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
        String time = req.getParameter("time");
        String email = req.getParameter("email");
        String name = req.getParameter("name");

        boolean rs = DatabaseManager.executeSQLstatement("delete from loginattempts where attime='" + time + "' and email='"+ email +"' and loginname='" + name + "'");

        System.out.println(time + " sent reservations request to ReservationServletasdasdsdasda");
        System.out.println(email + " sent reservations request to ReservationServletasdasdsdasda");
        System.out.println(name + " sent reservations request to ReservationServletasdasdsdasda");

        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
