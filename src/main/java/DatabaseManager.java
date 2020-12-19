import org.postgresql.util.PSQLException;

import java.sql.*;


class DatabaseManager {

    private static Connection database = null;

    static Table loginTable;
    static Table employeeTable;
    static Table roomTable;
    //static Table groupIDTable;
    //static Table memberTable;
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

        //For creating an employee in our database
        employeeTable = new Table("employeeTable",
                "employeeID SERIAL PRIMARY KEY, " +
                "emailAddress varchar(35) UNIQUE, " +
                "lastName varchar(35), " +
                "firstName varchar(35), " +
                "isAdmin bool, " +
                "isBHV bool");

        //For logging logins
        loginTable = new Table("loginTable",
                "emailAddress varchar(35), " +
                "loginName varchar(35), " +
                "timeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "FOREIGN KEY(employeeID) REFERENCES employeeTable(employeeID)");

        //For data of the workspaces
        roomTable = new Table("roomTable",
                "roomID varchar(10) PRIMARY KEY, " +
                "slotAmount INT");

        //For creating a reservation
        reservationTable = new Table("reservationTable",
                "reservationID SERIAL PRIMARY KEY, " +
                "roomID varchar(10), " +
                "invitationID INT, " +
                "employeeID INT, " +
                "date date, " +
                "timeSlot varchar(20), " +
                "FOREIGN KEY(roomID) REFERENCES roomTable(roomID), " +
                "FOREIGN KEY(employeeID) REFERENCES employeeTable(employeeID)");

        //*Can still be changed, work in progress*
        invitationTable = new Table("invitationTable",
                "invitationID SERIAL PRIMARY KEY, " +
                "invitedBy varchar(35), " +
                "invitee text[], " +
                "reservationID INT, " +
                "FOREIGN KEY(reservationID) REFERENCES reservationTable(reservationID)");


//        //maybe add column?
//        //For creating a team number which can apply to all team members
//        groupIDTable = new Table("groupIDTable",
//                "groupID SERIAL PRIMARY KEY");
//
//        //For referencing a member from a team (tussentabel)
//        memberTable = new Table("memberTable",
//                "groupID INT, " +
//                "employeeID INT, " +
//                "FOREIGN KEY(groupID) REFERENCES groupTable(groupID), " +
//                "FOREIGN KEY(employeeID) REFERENCES employeeTable(employeeID)");


        //setting up tables
        //setupLoginTable();
        //note2


        //Creating mockdata to test
        int roomAmount = 6;
        int roomSlotAmount = 5;
        System.out.println("Putting room mock data into the database");
        for(int i = 0; i < roomAmount; i++) {
            ResultSet rs = getResultsFromQuery("select roomID from roomTable where roomID= 'Room " + (i+1) + "'");
            try {
                if (!rs.next())
                    roomTable.insertValues("Room " + (i+1), roomSlotAmount);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }

        System.out.println("Putting employee mock data into the database");
        createAccountIfNotExists("John", "Doe", "Johndoe@hr.nl");
        createAccountIfNotExists("Jane", "Smith", "Janesmith@hr.nl");
        createAccountIfNotExists("Mary", "Major", "Marymajor@hr.nl");
        createAccountIfNotExists("Mark", "Moe", "Markmoe@hr.nl");
        createAccountIfNotExists("Richard", "Miles", "Richardmiles@hr.nl");

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

    static ResultSet getResultsFromQuery(String sql){
        try {
            Statement st = database.createStatement();
            ResultSet rs = st.executeQuery(sql);
            System.out.println("successfully executed: " + sql);
            return rs;
        } catch (SQLException e) {
            System.out.println("failed while executing: " + sql);
            e.printStackTrace();
            return null;
        }
    }

    //Still gives an error, rs.next() always executed
    static void createAccountIfNotExists(String name, String lastname, String email) {
        ResultSet rs = getResultsFromQuery("select emailAddress from employeeTable where emailAddress=lower('" + email + "')");
        try {
            if(!rs.next()) {
                employeeTable.insertValues("DEFAULT", email.toLowerCase(), lastname, name, false, false);
                System.out.println("A new user is being created, name: " + name + " " + lastname);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }


    static class Table{

        private final String _tableName;

        public Table(String tableName, String createTableArguments){
            _tableName = tableName;
            if (!executeSQLstatement("CREATE TABLE IF NOT EXISTS " + tableName + "(" + createTableArguments + ")")){
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
            executeSQLstatement(sql);

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
}



