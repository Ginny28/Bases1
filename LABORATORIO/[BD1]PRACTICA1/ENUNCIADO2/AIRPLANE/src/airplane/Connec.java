package airplane;

/**
 * Created by andy on 5/12/15.
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import oracle.jdbc.driver.OracleDriver;

public class Connec {

    
 
    private Connection connection;
    Statement st;

    public Connection getConnection() {
        return connection;
    }

    
   
    public void conect() 
    {
       String url = "jdbc:oracle:thin:@localhost:1522:ORACLEDB";
        try {
            connection = DriverManager.getConnection(url, "c##enunciado1", "1234");
            st=connection.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(Connec.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("NO SE CONECTO");
        }
       
       
       
    }

    /*
     * Con este metodo cerramos la conexion una vez hayamos terminado de usar la
     * base de datos
     */
    public void cerrar() throws SQLException {
        if (connection != null && connection.isClosed() == false) {
            connection.close();
        }
    }

}


