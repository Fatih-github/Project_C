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

        for(HashMap<String, String> subMap: submissionMaps){
            String date = subMap.get("date");
            String timeslot = subMap.get("timeslot");
            String room = subMap.get("room");
            DatabaseManager.reservationTable.insertValues("DEFAULT", room, email, "NULL", date, timeslot);
        }


//        String DateOne = req.getParameter("DateOne");
//        String Timeslot1 = req.getParameter("Timeslot1");
//        String Room1 = req.getParameter("Room1");
//
//        String DateTwo = req.getParameter("DateTwo");
//        String Timeslot2 = req.getParameter("Timeslot2");
//        String Room2 = req.getParameter("Room2");
//        String Invite2 = req.getParameter("Invite2");
//
//        System.out.println("Invite2: " + Invite2);
//        String[] Invite2V2 = Invite2.split(",");
//        System.out.println("Invite2V2: " + Arrays.toString(Invite2V2));
//
//
//        String DateThree = req.getParameter("DateThree");
//        String Timeslot3 = req.getParameter("Timeslot3");
//        String Room3 = req.getParameter("Room3");
//
//        String DateFour = req.getParameter("DateFour");
//        String Timeslot4 = req.getParameter("Timeslot4");
//        String Room4 = req.getParameter("Room4");
//
//        String DateFive = req.getParameter("DateFive");
//        String Timeslot5 = req.getParameter("Timeslot5");
//        String Room5 = req.getParameter("Room5");
//
//        String DateSix = req.getParameter("DateSix");
//        String Timeslot6 = req.getParameter("Timeslot6");
//        String Room6 = req.getParameter("Room6");
//
//        String DateSeven = req.getParameter("DateSeven");
//        String Timeslot7 = req.getParameter("Timeslot7");
//        String Room7 = req.getParameter("Room7");
//
//        String DateEight = req.getParameter("DateEight");
//        String Timeslot8 = req.getParameter("Timeslot8");
//        String Room8 = req.getParameter("Room8");
//
//        String DateNine = req.getParameter("DateNine");
//        String Timeslot9 = req.getParameter("Timeslot9");
//        String Room9 = req.getParameter("Room9");
//
//        String DateTen = req.getParameter("DateTen");
//        String Timeslot10 = req.getParameter("Timeslot10");
//        String Room10 = req.getParameter("Room10");
//
//        String email = req.getParameter("email");
//
//
//        //DatabaseManager.getResultsFromQuery("select logintable_employeeid from logintable where logintable_emailaddress = '"+email+"'");
//
//        if (!DateOne.equals(null) && !Timeslot1.equals(null) && !Timeslot1.equals("Choose...") && !Room1.equals(null)){
//            DatabaseManager.reservationTable.insertValues("3", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 1 test");
//        }
//
//        if (!DateTwo.equals(null) && !Timeslot2.equals(null) && !Timeslot2.equals("Choose...") && !Room2.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 2 test");
//        }
//
//        if (!DateThree.equals(null) && !Timeslot3.equals(null) && !Timeslot3.equals("Choose...") && !Room3.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 3 test");
//        }
//
//        if (!DateFour.equals(null) && !Timeslot4.equals(null) && !Timeslot4.equals("Choose...") && !Room4.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 4 test");
//        }
//
//        if (!DateFive.equals(null) && !Timeslot5.equals(null) && !Timeslot5.equals("Choose...") && !Room5.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 5 test");
//        }
//
//        if (!DateSix.equals(null) && !Timeslot6.equals(null) && !Timeslot6.equals("Choose...") && !Room6.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 1 test");
//        }
//
//        if (!DateSeven.equals(null) && !Timeslot7.equals(null) && !Timeslot7.equals("Choose...") && !Room7.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 2 test");
//        }
//
//        if (!DateEight.equals(null) && !Timeslot8.equals(null) && !Timeslot8.equals("Choose...") && !Room8.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 3 test");
//        }
//
//        if (!DateNine.equals(null) && !Timeslot9.equals(null) && !Timeslot9.equals("Choose...") && !Room9.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 4 test");
//        }
//
//        if (!DateTen.equals(null) && !Timeslot10.equals(null) && !Timeslot10.equals("Choose...") && !Room10.equals(null)){
//            DatabaseManager.reservationTable.insertValues("1", "2", DateOne, "5", "4", "3");
//            System.out.println("Day 5 test");
//        }

        RequestDispatcher view = req.getRequestDispatcher("LoginPage/loginHTMLfile.jsp");
        view.forward(req, res);
    }
}
