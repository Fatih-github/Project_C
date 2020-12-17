import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

public class ServletPlanSubmit extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {


        System.out.println("\n\n ServletPlanSubmit JAVA code");

        String submission = req.getParameter("submission");
        System.out.println("submission: " + submission);

        ArrayList<HashMap<String, String>> submissionMaps = DataHelper.getHashmapsFromJsonString(submission);
        String email = req.getParameter("email");

        //loop over all submitted day
        for(HashMap<String, String> subMap: submissionMaps){
            String date = subMap.get("date");
            String timeslot = subMap.get("timeSlot");
            String room = subMap.get("room");
            System.out.println("date " +date);
            System.out.println("timeSlot " + timeslot);
            System.out.println("room " + room);
            DatabaseManager.reservationTable.insertValues("DEFAULT", room, email, "NULL", date, timeslot);
        }

        RequestDispatcher view = req.getRequestDispatcher("LoginPage/loginHTMLfile.jsp");
        view.forward(req, res);
    }
}
