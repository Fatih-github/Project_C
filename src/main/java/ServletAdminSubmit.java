import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

public class ServletAdminSubmit extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        System.out.println("\n\n ServletAdminSubmit JAVA code");

        String Data = req.getParameter("Data");
        System.out.println("Data in servlet: " + Data);

        String employeeAmount = req.getParameter("employeeAmount");
        System.out.println("Data in servlet: " + employeeAmount);

        //Users admin page
        if(Data != null) {
            String[] DataSplit = Data.split("-");
            for (int i = 0; i < DataSplit.length; i++) {
                System.out.println("Data in array: " + DataSplit[i]);
                try {
                    DatabaseManager.executeSQLstatement("update employeetable set isadmin='" + DataSplit[i].split(",")[2] + "', isbhv='" + DataSplit[i].split(",")[3] + "' where emailaddress='" + DataSplit[i].split(",")[0] + "'");
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
        }

        //Create array with days of the week
        Date[] datesArray = new Date[10];
        int count = 0;
        for (int i = 1; i < 15; i++) {
            Calendar c = Calendar.getInstance();
            c.add(Calendar.DATE, i);
            if(c.get(Calendar.DAY_OF_WEEK) == 1 || c.get(Calendar.DAY_OF_WEEK) == 7) {
                count++; }
            if(c.get(Calendar.DAY_OF_WEEK) != 1 && c.get(Calendar.DAY_OF_WEEK) != 7) {
                Date date = c.getTime();
                datesArray[i - count - 1] = date;
            }
        }

        //Max Reservations admin page
        if(employeeAmount != null) {
            String[] AmountSplit = employeeAmount.split(",");

            for (int i = 0; i < AmountSplit.length; i++) {
                ResultSet rs = DatabaseManager.getResultsFromQuery("select date from maxreservationtable where date='" + datesArray[i] + "'");
                try {
                    if(!rs.next()) {
                        if (!AmountSplit[i].equals("-1"))
                            DatabaseManager.maxReservationTable.insertValues(datesArray[i], AmountSplit[i]);
                    }
                    else {
                        if (!AmountSplit[i].equals("-1")) {
                            DatabaseManager.executeSQLstatement("update maxreservationtable set date='" + datesArray[i] + "', maxreservations='" + AmountSplit[i] + "' where date='" + datesArray[i] + "'");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        RequestDispatcher view = req.getRequestDispatcher("AdminPage/adminHTMLfile.jsp");
        view.forward(req, res);
    }
}
