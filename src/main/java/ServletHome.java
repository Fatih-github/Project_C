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
import java.sql.*;

public class ServletHome extends HttpServlet{


    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        DatabaseManager.setup();

        System.out.println("\n\n ServletLogin JAVA code");

        try {

            String name = req.getParameter("name");
            String lastname = req.getParameter("lastname");
            String id_token = req.getParameter("id_token");
            String email = req.getParameter("email");

            Connection database = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                Class.forName("org.postgresql.Driver");
                database = DriverManager
                        .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                                "BaseFramePC", "none");
                st = database.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                String sql = "select * from employeetable where emailAddress = '" + email + "'";
                rs = st.executeQuery(sql);
                rs.next();

            } catch (Exception ex) {
                System.out.println("Error: " + ex);
            }

        } catch (Exception e) {
            System.out.println("TEST_ServletHome_TEST encountered failed login attempt");
        }

        RequestDispatcher view = req.getRequestDispatcher("HomePage/HomeHTMLfile.jsp");
        view.forward(req, res);
    }
}