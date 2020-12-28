import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ServletAdmin extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        System.out.println("\n\n ServletAdmin JAVA code");


        RequestDispatcher view = req.getRequestDispatcher("AdminPage/adminHTMLfile.jsp");
        view.forward(req, res);
    }
}
