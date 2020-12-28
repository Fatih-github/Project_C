import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ServletPlan extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        System.out.println("\n\n ServletPlan JAVA code");

        String email = req.getParameter("email");

        ResultSet resultSetId = DatabaseManager.getResultsFromQuery("select employeeID from employeeTable where emailAddress='"+email+"'");

        try {
            if(resultSetId.next()) {
                req.setAttribute("Id", resultSetId.getString(1));
                System.out.println("id: " + resultSetId.getString(1));
            }
        } catch (SQLException throwables) {
            System.out.println("reservation id is missing");
            throwables.printStackTrace();
        }

        RequestDispatcher view = req.getRequestDispatcher("PlanPage/planHTMLfile.jsp");
        view.forward(req, res);
    }
}
