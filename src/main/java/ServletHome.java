import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ServletHome extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String image = req.getParameter("image");
        System.out.println("image url: " + image);
        RequestDispatcher view = req.getRequestDispatcher("LoginTemplate/templateHTMLfile.jsp");
        view.forward(req, res);
    }
}
