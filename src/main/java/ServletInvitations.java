import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServletInvitations extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        System.out.println("\n\n ServletInvitations JAVA code");

        String email = req.getParameter("email");
        String name = req.getParameter("name");

        System.out.println("invitation email" + email);
        System.out.println("invitation name" + name);

        RequestDispatcher view = req.getRequestDispatcher("InvitationsPage/invitationsHTMLfile.jsp");
        view.forward(req, res);

    }
}
