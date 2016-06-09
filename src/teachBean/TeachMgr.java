package teachBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.sql.PooledConnection;

import enrollBean.Enroll;
import oracle.jdbc.pool.OracleConnectionPoolDataSource;

public class TeachMgr {
	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;
	
	public TeachMgr() {
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
	
	public Vector getTeachlist(String s_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
//		CallableStatement cstmt1 = null;
		ResultSet rs = null;
		Vector vecList = new Vector();
		
		try{
			conn = pool.getConnection();
/*			cstmt1 = conn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
			cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt1.execute();
	*/		
			String mySQL = "select * from teach";
			
			pstmt = conn.prepareStatement(mySQL);
	//		pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
				while (rs.next()) {
				Teach th = new Teach();
				th.setP_id(rs.getString("p_id"));
				th.setC_id(rs.getString("c_id"));
				th.setC_id_no(rs.getInt("c_id_no"));
				th.setT_year(rs.getInt("t_year"));
				th.setT_semester(rs.getInt("t_semester"));
				th.setT_day(rs.getString("t_day"));
				th.setT_time(rs.getString("t_time"));
				th.setT_room(rs.getString("t_room"));
				th.setT_max(rs.getInt("t_max"));  
				vecList.addElement(th);
			}   
//		cstmt1.close();
		pstmt.close();
		conn.close();
		
		}catch (Exception ex) {
			System.out.println("Error:  " + ex);
		}
		
		return vecList;
	}
}
