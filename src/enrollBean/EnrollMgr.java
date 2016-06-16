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
	
	public Vector getEnrollList(String s_id, int year, int semester){
		Connection conn = null;
		Statement stmt = null;
		ResultSet myResultSet = null;
		Vector vecList = new Vector();
		
		try { 
			conn = pool.getConnection();
			stmt = conn.createStatement();
			String mySQL = "select * from enroll where s_id = '" + s_id + "' and e_year = " + year + " and e_semester = " + semester;
			myResultSet = stmt.executeQuery(mySQL);

			while(myResultSet.next()){
				Enroll en = new Enroll();
				en.setC_id(myResultSet.getString("c_id"));
				en.setC_id_no(myResultSet.getString("c_id_no"));

				Statement stmt2 = conn.createStatement();
				String mySQL2 = "select * from course where c_id = '" + en.getC_id() + "' and c_id_no = '" + en.getC_id_no() + "'";
				ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
				myResultSet2.next();
				en.setC_name(myResultSet2.getString("c_name"));
				en.setC_unit(myResultSet2.getInt("c_unit"));
				en.setC_major(myResultSet2.getString("c_major"));
				
				mySQL2 = "select * from teach where c_id='" + en.getC_id() + "' and c_id_no = '" + en.getC_id_no() + "' and t_year = " + year + " and t_semester = " + semester;
				myResultSet2 = stmt2.executeQuery(mySQL2);
				if(myResultSet2.next()){
					en.setP_id(myResultSet2.getString("p_id"));
					en.setT_day(myResultSet2.getString("t_day"));
					en.setT_time(myResultSet2.getString("t_time"));
					en.setT_room(myResultSet2.getString("t_room"));
					en.setT_max(myResultSet2.getInt("t_max"));
				}
				
				mySQL2 = "select * from professor where p_id='" + en.getP_id() + "'";
				myResultSet2 = stmt2.executeQuery(mySQL2);
				if(myResultSet2.next()){
					en.setP_name(myResultSet2.getString("p_name"));
				}
			
				Enroll.totalEnrolledClass += 1;
				Enroll.totalEnrolledUnit += en.getC_unit();
				
				mySQL2 = "select COUNT(*) from enroll where c_id = '" + en.getC_id() + "' and c_id_no = '" + en.getC_id_no() + "' and e_year = " + year + " and e_semester = " + semester;
				myResultSet2 = stmt2.executeQuery(mySQL2);
				if(myResultSet2.next()){
					en.setStudentNum(myResultSet2.getInt(1));
				}
				vecList.add(en);
			}
		} catch(SQLException ex) { 
			System.err.println("SQLException: " + ex.getMessage()); 
		} finally { 
			if (stmt != null) 
				try { 
					conn.commit(); stmt.close(); conn.close(); 
				} catch(SQLException ex) { } 
		}
		return vecList;
	}
}
