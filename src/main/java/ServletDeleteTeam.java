import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class ServletDeleteTeam extends HttpServlet{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String teamname = req.getParameter("teamname");
        String teaminvites = req.getParameter("teaminvites");
        String invitedbyemail = req.getParameter("invitedbyemail");

        boolean rs = DatabaseManager.executeSQLstatement("delete from teamtable where teamname='" + teamname + "' and teaminvites='"+ teaminvites +"' and invitedbyemail='" + invitedbyemail + "'");

        System.out.println(teamname);
        System.out.println(teaminvites);
        System.out.println(invitedbyemail);

        RequestDispatcher view = req.getRequestDispatcher("LoginPage/loginHTMLfile.jsp");
        view.forward(req, res);
    }
}
