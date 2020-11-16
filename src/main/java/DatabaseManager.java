import java.sql.*;
import java.util.Properties;
import java.util.logging.Logger;


class DatabaseManager {

    private static java.sql.Connection database = null;

    static Table loginTable;
    static Table employeeTable;
    static Table workspaceTable;
    static Table reservationTable;
    static Table invitationTable;

    public static void setup(){
        if (database != null){return;}

        System.out.println("started DataBase setup v15");

        // making connection with the database
        try{

            Class.forName("org.postgresql.Driver");
            database = DriverManager
                    .getConnection("jdbc:postgresql://localhost:5432/officePlanagerData",
                            "BaseFramePC", "none");

            System.out.println("Database sucessfully connected");

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e.getClass().getName()+": "+e.getMessage());
            System.out.println("Couldn't open database connection, are the username and password correct?");
            System.exit(0);
        }

        employeeTable = new Table("employeeTable",
                "employeeTable_employeeID SERIAL PRIMARY KEY, " +
                "loginTable_lastName varchar(35), " +
                "loginTable_firstName varchar(35), " +
                "loginTable_emailAddress varchar(35)");

        loginTable = new Table("loginTable",
                "loginTable_emailAddress varchar(35), " +
                        "loginTable_timeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                        "loginTable_loginName varchar(35), " +
                        "loginTable_employeeID INT, " +
                        "FOREIGN KEY(loginTable_employeeID) REFERENCES employeeTable(employeeTable_employeeID)");

        workspaceTable = new Table("workspaceTable",
                "workspaceTable_workspaceID INT PRIMARY KEY, " +
                        "workspaceTable_blockNumber INT");

        reservationTable = new Table("reservationTable",
                "reservationTable_reservationTableID INT PRIMARY KEY, " +
                        "reservationTable_workspaceID INT, " +
                        "reservationTable_date varchar(20), " +
                        "reservationTable_slots INT, " +
                        "reservationTable_state INT, " +
                        "reservationTable_employeeID INT, " +
                        "FOREIGN KEY(reservationTable_employeeID) REFERENCES employeeTable(employeeTable_employeeID), " +
                        "FOREIGN KEY(reservationTable_workspaceID) REFERENCES workspaceTable(workspaceTable_workspaceID)");

        invitationTable = new Table("invitationTable",
                "invitationTable_invitedBy varchar(35), " +
                        "invitationTable_invitee varchar(35), " +
                        "invitationTable_employeeID INT, " +
                        "invitationTable_reservationID INT, " +
                        "FOREIGN KEY(invitationTable_employeeID) REFERENCES employeeTable(employeeTable_employeeID), " +
                        "FOREIGN KEY(invitationTable_reservationID) REFERENCES reservationTable(reservationTable_reservationTableID), " +
                        "PRIMARY KEY(invitationTable_employeeID, invitationTable_reservationID)");

        // setting up tables
        //setupLoginTable();
        //note2
    }

    private static void setupLoginTable(){
        Statement st = null;

        /*
        try {
            st = database.createStatement();
            st.executeQuery("CREATE TABLE IF NOT EXISTS loginAttempts(              atTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, " +
                    "email VARCHAR(20)," +
                    "loginName VARCHAR(20))");

            System.out.println("successful query for setup of Login Table");
        } catch (SQLException e) {
            System.out.println("maybe failed to query the setup for Login Table check pgAdmin if table exists");
            //e.printStackTrace();
        }
        */
        //comment
    }

    public static void logLoginAttempt(String name, String email){
        Statement st = null;
        System.out.println("try to log attempt");
        try {
            st = database.createStatement();
            st.execute("INSERT INTO loginAttempts (email, loginName) VALUES ('" + email + "', '" + name + "')");
            System.out.println("successful query for inserting login record");
        } catch (SQLException e) {
            System.out.println("maybe failed to query the setup for Login Table check pgAdmin if record is added");
            e.printStackTrace();
        }
    }

    static boolean executeSQLstatement(String sql){
        try {
            Statement st = database.createStatement();
            st.execute(sql);
            System.out.println("successfully executed: " + sql);
            return true;
        } catch (SQLException e) {
            System.out.println("failed while executing: " + sql);
            e.printStackTrace();
            return false;
        }
    }



}



class Table{

    private String _tableName;

    public Table(String tableName, String createTableArguments){
        _tableName = tableName;
        if (!DatabaseManager.executeSQLstatement("CREATE TABLE IF NOT EXISTS " + tableName + "(" + createTableArguments + ")")){
            System.out.println("Creating table " + tableName + " failed");
        }
    }

    private void insertValueList(String... values) {

        // generate insertion SQL
        String sql = "INSERT INTO " + _tableName + " VALUES(";
        for (String value : values) {
            try {//add single quotes to value if it represents a string
                double d = Double.parseDouble(value);
                sql += value;
            } catch (Exception e) {
                if (value.toLowerCase().contains("default")) {
                    sql += "DEFAULT";
                }else if (value.toLowerCase().contains("null")) {
                    sql += "NULL";
                }  else {
                    sql += "'" + value + "'";
                }
            }
            sql += ", ";
        }
        sql = sql.substring(0, sql.length() - 2) + ")"; // remove last comma before adding closing parenthesis
        //System.out.println("generated SQL: " + sql);

        //execute sql in database
        DatabaseManager.executeSQLstatement(sql);

    }

    //<editor-fold desc="insertValues overloaded functions">
    public <A> void insertValues( A a) {
        insertValueList( "" + a);
    }

    public <A, B> void insertValues(A a, B b){
        insertValueList("" + a, "" + b);
    }

    public <A, B, C> void insertValues(A a, B b, C c){
        insertValueList("" + a, "" + b, "" + c);
    }

    public <A, B, C, D> void insertValues(A a, B b, C c, D d){
        insertValueList("" + a, "" + b, "" + c, "" + d);
    }

    public <A, B, C, D, E> void insertValues(A a, B b, C c, D d, E e){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e);
    }

    public <A, B, C, D, E, F> void insertValues(A a, B b, C c, D d, E e, F f){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f);
    }

    public <A, B, C, D, E, F, G> void insertValues(A a, B b, C c, D d, E e, F f, G g){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g);
    }

    public <A, B, C, D, E, F, G, H> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h);
    }

    public <A, B, C, D, E, F, G, H, I> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i);
    }

    public <A, B, C, D, E, F, G, H, I, J> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j);
    }

    public <A, B, C, D, E, F, G, H, I, J, K> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M, N> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m, "" + n);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M, N, O> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m, "" + n, "" + o);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m, "" + n, "" + o, "" + p);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m, "" + n, "" + o, "" + p, "" + q);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m, "" + n, "" + o, "" + p, "" + q, "" + r);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m, "" + n, "" + o, "" + p, "" + q, "" + r, "" + s);
    }

    public <A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T> void insertValues(A a, B b, C c, D d, E e, F f, G g, H h, I i, J j, K k, L l, M m, N n, O o, P p, Q q, R r, S s, T t){
        insertValueList("" + a, "" + b, "" + c, "" + d, "" + e, "" + f, "" + g, "" + h, "" + i, "" + j, "" + k, "" + l, "" + m, "" + n, "" + o, "" + p, "" + q, "" + r, "" + s, "" + t);
    }
    //</editor-fold>

}


