import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ServletAdminSubmit extends HttpServlet{

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        System.out.println("\n\n ServletAdminSubmit JAVA code");

        String Data = req.getParameter("Data");
        System.out.println("Data in servlet: " + Data);

        String[] DataSplit = Data.split("-");

        for(int i = 0; i < DataSplit.length; i++) {
            System.out.println("Data in array: " + DataSplit[i]);
            DatabaseManager.executeSQLstatement("update employeetable set isadmin='" + DataSplit[i].split(",")[2] + "', isbhv='" + DataSplit[i].split(",")[3] + "' where emailaddress='" + DataSplit[i].split(",")[0] +"'");
        }

        RequestDispatcher view = req.getRequestDispatcher("AdminPage/adminHTMLfile.jsp");
        view.forward(req, res);
    }
}
