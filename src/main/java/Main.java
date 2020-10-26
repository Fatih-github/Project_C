
import java.sql.Connection;
import java.sql.DriverManager;

public class Main {

    //note
    private static class DataBase {

        Connection c = null;
        String user;
        String password;
        String dataBaseName;


        public DataBase(String user, String password, String dataBaseName){
            System.out.println("started DataBase constructor");
            try{
                Class.forName("org.postgresql.Driver");
                c = DriverManager
                        .getConnection("jdbc:postgresql://localhost:5432/" + dataBaseName,
                                user, password);
                System.out.println("succesfull DataBase constructor");
                user = user;
                password = password;
                dataBaseName = dataBaseName;
            } catch (Exception e) {
                e.printStackTrace();
                System.err.println(e.getClass().getName()+": "+e.getMessage());
                System.exit(0);
            }
            System.out.println("Opened database successfully");
        }

    }

    //static variables
    static DataBase dataBase;


    public static void main(String[] args) {


        System.out.println("Hello from kevin!");
        dataBase = new DataBase("postgres", "none", "testdb");



    }
}
