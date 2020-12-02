import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class ServletUpdateReservations extends HttpServlet{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String time = req.getParameter("time");
        String email2 = req.getParameter("email2");
        String name = req.getParameter("name");

        String oldTime = req.getParameter("oldTime");
        String oldEmail = req.getParameter("oldEmail");
        String oldName = req.getParameter("oldName");

        if (time != null && email2 != null && name != null)
        {
            System.out.println("ik zit in time != null && email2 != null && name != null");
            System.out.println("----------------------------------------------------------");
            if (time.isEmpty() && email2.isEmpty() && name.isEmpty()) {
                System.out.println("ik zit in time.isEmpty() && email2.isEmpty() && name.isEmpty()");
                System.out.println("----------------------------------------------------------");
                time = oldTime;
                email2 = oldEmail;
                name = oldName;
            }
        }

        System.out.println("nieuwe gegevens");
        System.out.println(time + " sent reservations request to UpdateReservationServlet");
        System.out.println(email2 + " sent reservations request to UpdateReservationServlet");
        System.out.println(name + " sent reservations request to UpdateReservationServlet");

        System.out.println("oude gegevens");
        System.out.println(oldTime + " sent reservations request to UpdateReservationServlet");
        System.out.println(oldEmail + " sent reservations request to UpdateReservationServlet");
        System.out.println(oldName + " sent reservations request to UpdateReservationServlet");
        System.out.println("--------------------");

        if (time != null && !time.isEmpty() && email2 != null && !email2.isEmpty() && name != null && !name.isEmpty() && oldTime != null && oldEmail != null && oldName != null && !oldTime.isEmpty() && !oldEmail.isEmpty() && !oldName.isEmpty()) {
            boolean rs = DatabaseManager.executeSQLstatement("update loginattempts set attime='" + time.trim() + "', email='" + email2.trim() + "', loginname='" + name.trim() + "' where attime='" + oldTime.trim() +"' and email='" + oldEmail.trim() + "' and loginname='" + oldName.trim() + "'");
            System.out.println("ik zit in big if statement");
            System.out.println("----------------------------------------------------------");
            RequestDispatcher view = req.getRequestDispatcher("ReservationsTemplate/templateHTMLfile.jsp");
            view.forward(req, res);
        }
        else {
            System.out.println("ik zit in de else");
            System.out.println("----------------------------------------------------------");
            RequestDispatcher view = req.getRequestDispatcher("ReservationsTemplate/updateReservations.jsp");
            view.forward(req, res);
        }
    }
}
