import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

public class ServletTeamSubmit extends HttpServlet {

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {


        System.out.println("\n\n ServletTeamSubmit JAVA code");

        String teamname = req.getParameter("teamname");
        String teamselect = req.getParameter("teamselect");
        System.out.println("teamname: " + teamname);
        System.out.println("teamselect: " + teamselect);
        String email = req.getParameter("email");

        //get inviter
        ResultSet userId = DatabaseManager.getResultsFromQuery("select firstname, lastname, emailaddress from employeetable where emailaddress = '" + email + "'");

        String userEmailString = "";
        String userNameString = "";
        String userSurnameString = "";
        try {
            if (userId.next()) {
                userNameString = userId.getString(1);
                userSurnameString = userId.getString(2);
                userEmailString = userId.getString(3);
                System.out.println("userName: " + userId.getString(2));
                System.out.println("userSurname: " + userId.getString(3));
            }
        } catch (Exception throwables) {
            System.out.println("userId is missing");
            throwables.printStackTrace();
        }

        //get next ID number for insertion
        int nextId = 0;
        try {
            ResultSet teamIds = DatabaseManager.getResultsFromQuery("select teamid from teamtable order by teamid desc limit 1");
            if (teamIds.next()) {
                nextId = teamIds.getInt(1) + 1;
            }

        } catch (SQLException e) {
            //e.printStackTrace();
        }
        DatabaseManager.teamTable.insertValues(nextId, teamname, userEmailString);

        RequestDispatcher view = req.getRequestDispatcher("LoginPage/loginHTMLfile.jsp");
        view.forward(req, res);
    }
}

