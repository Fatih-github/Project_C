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


        System.out.println("\n\n ServletReservations JAVA code");
        System.out.println("cleanup merge function found");

        String email = req.getParameter("email");

        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
