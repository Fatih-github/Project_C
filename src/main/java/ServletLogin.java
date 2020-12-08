import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson.JacksonFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ServletLogin extends HttpServlet{


    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        DatabaseManager.setup();

        System.out.println("\n\n ServletLogin JAVA code");

        try {

            String name = req.getParameter("name");
            String lastname = req.getParameter("lastname");
            String id_token = req.getParameter("id_token");
            String email = req.getParameter("email");

            System.out.println(email + " logged in with token " + id_token);
            DatabaseManager.loginTable.insertValues(email, "DEFAULT", name, "NULL");

            DatabaseManager.createAccountIfNotExists(name, lastname, email);

        } catch (Exception e) {
            System.out.println("ServletLogin encountered failed login attempt");
        }

        RequestDispatcher view = req.getRequestDispatcher("LoginPage/loginHTMLfile.jsp");
        view.forward(req, res);
    }
}
