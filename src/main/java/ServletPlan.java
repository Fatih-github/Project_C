import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServletPlan extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        System.out.println("\n\n ServletPlan JAVA code");


        String Day1 = "Mon";
        String Session1 = req.getParameter("Session1");
        String Seat1 = req.getParameter("Seat1");

        String Day2 = "Tue";
        String Session2 = req.getParameter("Session2");
        String Seat2 = req.getParameter("Seat2");

        String Day3 = "Wed";
        String Session3 = req.getParameter("Session3");
        String Seat3 = req.getParameter("Seat3");

        String Day4 = "Thu";
        String Session4 = req.getParameter("Session4");
        String Seat4 = req.getParameter("Seat4");

        String Day5 = "Fri";
        String Session5 = req.getParameter("Session5");
        String Seat5 = req.getParameter("Seat5");

        String email = req.getParameter("email");


        DatabaseManager.getResultsFromQuery("select logintable_employeeid from logintable where logintable_emailaddress = '"+email+"'");

        if (Day1.equals(null) && Session1.equals(null) && Seat1.equals(null)){
            DatabaseManager.executeSQLstatement("insert into reservationtable values (1,1,"+Day1+", "+Session1+", "+Seat1+",1) ");
            System.out.println("Day 1 test");
        }

        if (Day2.equals(null) && Session2.equals(null) && Seat2.equals(null)){
            DatabaseManager.executeSQLstatement("insert into reservationtable values (1,1,"+Day2+", "+Session2+", "+Seat2+",1) ");
            System.out.println("Day 2 test");
        }

        if (Day3.equals(null) && Session3.equals(null) && Seat3.equals(null)){
            DatabaseManager.executeSQLstatement("insert into reservationtable values (1,1,"+Day3+", "+Session3+", "+Seat3+",1) ");
            System.out.println("Day 3 test");
        }

        if (Day4.equals(null) && Session4.equals(null) && Seat4.equals(null)){
            DatabaseManager.executeSQLstatement("insert into reservationtable values (1,1,"+Day4+", "+Session4+", "+Seat4+",1) ");
            System.out.println("Day 4 test");
        }

        if (Day5.equals(null) && Session5.equals(null) && Seat5.equals(null)){
            DatabaseManager.executeSQLstatement("insert into reservationtable values (1,1,"+Day5+", 1,1,1) ");
            System.out.println("Day 5 test");
        }

        RequestDispatcher view = req.getRequestDispatcher("PlanPage/planHTMLfile.html");
        view.forward(req, res);

    }
}
