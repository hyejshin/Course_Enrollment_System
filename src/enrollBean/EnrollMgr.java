package enrollBean;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.sql.PooledConnection;

import enrollBean.Enroll;
import oracle.jdbc.pool.OracleConnectionPoolDataSource;

public class EnrollMgr {
	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;
	
	public EnrollMgr() {
		try{
			ocpds = new OracleConnectionPoolDataSource();
			ocpds.setURL("jdbc:oracle:thin:@localhost:1521:orcl");
			ocpds.setUser("db01");
			ocpds.setPassword("ss2");
			pool = ocpds.getPooledConnection();
		} catch(Exception e) {
			System.out.println("Error: 커넥션 얻어오기 실패");
		}
	}
	
	public int getCurrentYear(){
		Connection conn = null;
		Statement stmt = null;
		ResultSet myResultSet = null;
		int year = 0;
		
		try { 
			conn = pool.getConnection();
			stmt = conn.createStatement();
			String mySQL = "select Date2EnrollYear(sysdate) from dual";
			myResultSet = stmt.executeQuery(mySQL);
			myResultSet.next();
			year = myResultSet.getInt(1);
		} catch(SQLException ex) { 
			System.err.println("SQLException: " + ex.getMessage()); 
		} finally { 
			if (stmt != null) 
				try { 
					conn.commit(); stmt.close(); conn.close(); 
				} catch(SQLException ex) { } 
		}
		return year;
	}
	
	public int getCurrentSemester(){
		Connection conn = null;
		Statement stmt = null;
		ResultSet myResultSet = null;
		int semester = 0;
		
		try { 
			conn = pool.getConnection();
			stmt = conn.createStatement();
			String mySQL = "select Date2EnrollSemester(sysdate) from dual";
			myResultSet = stmt.executeQuery(mySQL);
			myResultSet.next();
			semester = myResultSet.getInt(1);
		} catch(SQLException ex) { 
			System.err.println("SQLException: " + ex.getMessage()); 
		} finally { 
			if (stmt != null) 
				try { 
					conn.commit(); stmt.close(); conn.close(); 
				} catch(SQLException ex) { } 
		}
		return semester;
	}
}
