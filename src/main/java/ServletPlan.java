import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServletPlan extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        System.out.println("\n\n ServletPlan JAVA code");



        RequestDispatcher view = req.getRequestDispatcher("PlanPage/planHTMLfile.html");
        view.forward(req, res);

    }
}
