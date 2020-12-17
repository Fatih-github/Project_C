import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.concurrent.ThreadLocalRandom;

public class ServletPlanSubmit extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        String DateOne = req.getParameter("DateOne");
        String Timeslot1 = req.getParameter("Timeslot1");
        String Room1 = req.getParameter("Room1");
        String Invite1 = req.getParameter("Invite1");

        String DateTwo = req.getParameter("DateTwo");
        String Timeslot2 = req.getParameter("Timeslot2");
        String Room2 = req.getParameter("Room2");
        String Invite2 = req.getParameter("Invite2");

        String DateThree = req.getParameter("DateThree");
        String Timeslot3 = req.getParameter("Timeslot3");
        String Room3 = req.getParameter("Room3");
        String Invite3 = req.getParameter("Invite3");

        String DateFour = req.getParameter("DateFour");
        String Timeslot4 = req.getParameter("Timeslot4");
        String Room4 = req.getParameter("Room4");
        String Invite4 = req.getParameter("Invite4");

        String DateFive = req.getParameter("DateFive");
        String Timeslot5 = req.getParameter("Timeslot5");
        String Room5 = req.getParameter("Room5");
        String Invite5 = req.getParameter("Invite5");

        String DateSix = req.getParameter("DateSix");
        String Timeslot6 = req.getParameter("Timeslot6");
        String Room6 = req.getParameter("Room6");
        String Invite6 = req.getParameter("Invite6");

        String DateSeven = req.getParameter("DateSeven");
        String Timeslot7 = req.getParameter("Timeslot7");
        String Room7 = req.getParameter("Room7");
        String Invite7 = req.getParameter("Invite7");

        String DateEight = req.getParameter("DateEight");
        String Timeslot8 = req.getParameter("Timeslot8");
        String Room8 = req.getParameter("Room8");
        String Invite8 = req.getParameter("Invite8");

        String DateNine = req.getParameter("DateNine");
        String Timeslot9 = req.getParameter("Timeslot9");
        String Room9 = req.getParameter("Room9");
        String Invite9 = req.getParameter("Invite9");

        String DateTen = req.getParameter("DateTen");
        String Timeslot10 = req.getParameter("Timeslot10");
        String Room10 = req.getParameter("Room10");
        String Invite10 = req.getParameter("Invite10");

        String email = req.getParameter("email");

        System.out.println("Invite1: " + Invite1);
        String[] arrInvite1 = Invite1.split(",");
        System.out.println("arrInvite1: " + Arrays.toString(arrInvite1));

        System.out.println("Invite2: " + Invite2);
        String[] arrInvite2 = Invite2.split(",");
        System.out.println("arrInvite2: " + Arrays.toString(arrInvite2));

        System.out.println("Invite3: " + Invite3);
        String[] arrInvite3 = Invite3.split(",");
        System.out.println("arrInvite3: " + Arrays.toString(arrInvite3));

        System.out.println("Invite4: " + Invite4);
        String[] arrInvite4 = Invite4.split(",");
        System.out.println("arrInvite4: " + Arrays.toString(arrInvite4));

        System.out.println("Invite5: " + Invite5);
        String[] arrInvite5 = Invite5.split(",");
        System.out.println("arrInvite5: " + Arrays.toString(arrInvite5));

        System.out.println("Invite6: " + Invite6);
        String[] arrInvite6 = Invite6.split(",");
        System.out.println("arrInvite6: " + Arrays.toString(arrInvite6));

        System.out.println("Invite7: " + Invite7);
        String[] arrInvite7 = Invite7.split(",");
        System.out.println("arrInvite7: " + Arrays.toString(arrInvite7));

        System.out.println("Invite8: " + Invite8);
        String[] arrInvite8 = Invite8.split(",");
        System.out.println("arrInvite8: " + Arrays.toString(arrInvite8));

        System.out.println("Invite9: " + Invite9);
        String[] arrInvite9 = Invite9.split(",");
        System.out.println("arrInvite9: " + Arrays.toString(arrInvite9));

        System.out.println("Invite10: " + Invite10);
        String[] arrInvite10 = Invite10.split(",");
        System.out.println("arrInvite10: " + Arrays.toString(arrInvite10));

        ResultSet userId = DatabaseManager.getResultsFromQuery("select employeeid, firstname, lastname from employeetable where emailaddress = '"+email+"'");

        String userIdString = "";
        String userNameString = "";
        String userSurnameString = "";

        try {
            if(userId.next()) {
                userIdString = userId.getString(1);
                userNameString = userId.getString(2);
                userSurnameString = userId.getString(3);
                System.out.println("userId: " + userId.getString(1));
                System.out.println("userName: " + userId.getString(2));
                System.out.println("userSurname: " + userId.getString(3));
            }
        } catch (SQLException throwables) {
            System.out.println("userId is missing");
            throwables.printStackTrace();
        }

        if (!DateOne.equals(null) && !Timeslot1.equals(null) && !Timeslot1.equals("Choose...") && !Room1.equals(null) && !Room1.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room1, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateOne, Timeslot1);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite1).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 1 test");
        }

        if (!DateTwo.equals(null) && !Timeslot2.equals(null) && !Timeslot2.equals("Choose...") && !Room2.equals(null) && !Room2.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room2, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateTwo, Timeslot2);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite2).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 2 test");
        }

        if (!DateThree.equals(null) && !Timeslot3.equals(null) && !Timeslot3.equals("Choose...") && !Room3.equals(null) && !Room3.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room3, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateThree, Timeslot3);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite3).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 3 test");
        }

        if (!DateFour.equals(null) && !Timeslot4.equals(null) && !Timeslot4.equals("Choose...") && !Room4.equals(null) && !Room4.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room4, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateFour, Timeslot4);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite4).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 4 test");
        }

        if (!DateFive.equals(null) && !Timeslot5.equals(null) && !Timeslot5.equals("Choose...") && !Room5.equals(null) && !Room5.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room5, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateFive, Timeslot5);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite5).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 5 test");
        }

        if (!DateSix.equals(null) && !Timeslot6.equals(null) && !Timeslot6.equals("Choose...") && !Room6.equals(null) && !Room6.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room6, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateSix, Timeslot6);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite6).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 6 test");
        }

        if (!DateSeven.equals(null) && !Timeslot7.equals(null) && !Timeslot7.equals("Choose...") && !Room7.equals(null) && !Room7.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room7, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateSeven, Timeslot7);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite7).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 7 test");
        }

        if (!DateEight.equals(null) && !Timeslot8.equals(null) && !Timeslot8.equals("Choose...") && !Room8.equals(null) && !Room8.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room8, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateEight, Timeslot8);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite8).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 8 test");
        }

        if (!DateNine.equals(null) && !Timeslot9.equals(null) && !Timeslot9.equals("Choose...") && !Room9.equals(null) && !Room9.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room9, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateNine, Timeslot9);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite9).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 9 test");
        }

        if (!DateTen.equals(null) && !Timeslot10.equals(null) && !Timeslot10.equals("Choose...") && !Room10.equals(null) && !Room10.equals("Choose...")){
            int reservationId = ThreadLocalRandom.current().nextInt(10000, 99999);
            int workspaceId = ThreadLocalRandom.current().nextInt(10000, 99999);
            DatabaseManager.workspaceTable.insertValues(workspaceId, Room10, 10);
            DatabaseManager.reservationTable.insertValues(reservationId, workspaceId, userIdString, DateTen, Timeslot10);
            DatabaseManager.invitationTable.insertValues(userNameString+" "+userSurnameString, Arrays.toString(arrInvite10).replace("[", "{").replace("]", "}"), userIdString, reservationId);
            System.out.println("Day 10 test");
        }

        ResultSet resultSetId = DatabaseManager.getResultsFromQuery("select employeeID from employeeTable where emailAddress='"+email+"'");

        try {
            if(resultSetId.next()) {
                req.setAttribute("Id", resultSetId.getString(1));
                System.out.println("reservation id: " + resultSetId.getString(1));
            }
        } catch (SQLException throwables) {
            System.out.println("reservation id is missing");
            throwables.printStackTrace();
        }

        RequestDispatcher view = req.getRequestDispatcher("ReservationsPage/reservationsHTMLfile.jsp");
        view.forward(req, res);
    }
}
