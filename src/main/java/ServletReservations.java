import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class ServletReservations extends HttpServlet{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String email = req.getParameter("email");
        ResultSet rs = DatabaseManager.getResultsFromQuery("select * from logintable where logintable_emailaddress='"+ email +"' limit 10");
        req.setAttribute("results", rs);

        try {
            while (rs.next()) {
                for (int i = 1; i <= 3; i++) {
                    if (i > 1) System.out.print(",  ");
                    String columnValue = rs.getString(i);
                    System.out.print(columnValue + " ");
                }
                System.out.println("");
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        System.out.println(email + " sent reservations request to ReservationServlet");

        RequestDispatcher view = req.getRequestDispatcher("ReservationsTemplate/templateHTMLfile.jsp");
        view.forward(req, res);
    }
}
