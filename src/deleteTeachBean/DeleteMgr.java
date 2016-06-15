package deleteTeachBean;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.sql.PooledConnection;

import deleteTeachBean.DeleteTeach;
import oracle.jdbc.pool.OracleConnectionPoolDataSource;

public class DeleteMgr {
	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;
	
	public DeleteMgr() {
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
	
	public String deleteTeachlist(String p_id, String c_id, int c_id_no) {
		Connection conn = null;
		String result = null;
		CallableStatement cstmt1 = null;
		
		try { 
			conn = pool.getConnection();
			cstmt1 = conn.prepareCall("{call  DeleteTeach(?,?,?,?)}"); 
			cstmt1.setString(1, p_id); 
			cstmt1.setString(2, c_id); 
			cstmt1.setInt(3, c_id_no);
			cstmt1.registerOutParameter(4, java.sql.Types.VARCHAR); 
			cstmt1.execute(); 
			
			result = cstmt1.getString(4);
		} catch(SQLException ex) { 
			System.err.println("SQLException: " + ex.getMessage()); 
		} finally { 
			if (cstmt1 != null) 
				try { conn.commit(); cstmt1.close(); conn.close(); 
				} catch(SQLException ex) { } 
			}
		return result;
		}
	}