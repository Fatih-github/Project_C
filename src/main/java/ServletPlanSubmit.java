import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServletPlanSubmit extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {


        for (int i = 0; i < 100; i++) {
            System.out.println("submit gelukt");
            System.out.println("day3: " + req.getParameter("day3"));
        }



        RequestDispatcher view = req.getRequestDispatcher("PlanTemplate/templateHTMLfile.html");
        view.forward(req, res);

    }
}
