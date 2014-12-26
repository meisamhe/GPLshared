package jdbcMySql;

import java.sql.Connection;

public class Stationaries {
    private Connection mySql = null;

    private MySqlConnector msc = null;

    public Stationaries(Connection mySql) {
        this.mySql = mySql;
        msc = new MySqlConnector();
    }

    /**
     * @param name
     * @param manufacturedBY
     * @param price
     * @param quantity
     * @param description
     * @return 0 if no rows inserted or row counter that means number of inserted rows.
     */
    public int insert(String name, String manufacturedBY,
                         double price, double quantity, String description) {
        String sql = "INSERT INTO STATIONARIES VALUES(NULL,'" + name + "','" +
                     manufacturedBY;
        sql += "','" + price + "','" + quantity + "','" + description + "')";
        int test = msc.runSqlDDL(sql, mySql);
        return test;
    }

    /**
     * @param id : record id(primary key) that you want to be updated.
     * @param setClause : fields that you want to be updated with related values.
     * @see UPDATE users SET NAME='Mani',USERNAME='MBH' WHERE (ID=1);
     * @return number of updated rows.
     */
    public int update(int id, String setClause) {
        //UPDATE `users` SET `NAME`='Mani',`USERNAME`='MBH' WHERE (`ID`='1')
        String sql = "UPDATE STATIONARIES SET " + setClause + " WHERE (ID=" +
                     id + ")";
        int test = msc.runSqlDDL(sql, mySql);
        return test;
    }

    /**
     * @param clause : only the where clause of delete statement like "ID=1 AND NAME='MANI'".
     * @return number of deleted rows.
     */
    public int delete(String clause) {
        //DELETE FROM USERS WHERE (ID=1)
        String sql = "DELETE FROM STATIONARIES WHERE (" + clause + ")";
        int test = msc.runSqlDDL(sql, mySql);
        return test;
    }
}
