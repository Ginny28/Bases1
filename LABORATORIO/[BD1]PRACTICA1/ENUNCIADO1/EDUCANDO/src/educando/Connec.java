package educando;

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
import java.sql.*;

public class Connec {

    
 
    private Connection connection;
    Statement st;

    public Connection getConnection() {
        return connection;
    }

    
   
    public void conect() 
    {
       String url = "jdbc:mysql://localhost/educando";
        try {
            connection = DriverManager.getConnection(url, "root", "1234");
            st=connection.createStatement();
            System.out.println(" SE CONECTO");
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


