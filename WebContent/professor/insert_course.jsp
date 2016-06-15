<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> 강좌 개설</title>
</head>
<body>
<% 
String c_name = new String(request.getParameter("c_name").getBytes("8859_1"), "EUC-KR");

String c_id = null;
String c_id_noStr = request.getParameter("c_id_no");
String t_yearStr = request.getParameter("t_year");
String t_semesterStr = request.getParameter("t_semester");

String t_day = new String(request.getParameter("t_day").getBytes("8859_1"), "EUC-KR");
String t_time = request.getParameter("t_time");
String t_room = new String(request.getParameter("t_room").getBytes("8859_1"), "EUC-KR");
String t_maxStr = request.getParameter("t_max");

String session_id = (String)session.getAttribute("userID");
String professorID = session_id; //세션 아이디부여

int c_id_no = Integer.parseInt(c_id_noStr);
int t_year = Integer.parseInt(t_yearStr);
int t_semester = Integer.parseInt(t_semesterStr);
int t_max = Integer.parseInt(t_maxStr);
String result = null;

Connection myConn = null;
Statement stmt = null;
String mySQL = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db01";
String passwd = "ss2";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);

	stmt = myConn.createStatement();
	mySQL = "select c_id from course where c_name = '" + c_name + "' and c_id_no = " + c_id_no;
	
	ResultSet myResultSet = stmt.executeQuery(mySQL);
	
	while(myResultSet.next() != false){
		c_id = myResultSet.getString("c_id");
		result = c_id;
	}  
	
	stmt.close();
	
	if(c_id == null){
		System.out.println("해당 과목이 존재하지 않습니다.");
	}
	else {
		CallableStatement cstmt = myConn.prepareCall("{call InsertTeach(?,?,?,?,?,?,?,?)}"); 
		cstmt.setString(1, professorID); 
		cstmt.setString(2, c_id);
		cstmt.setInt(3, c_id_no);
		cstmt.setString(4, t_day); 
		cstmt.setString(5, t_time); 
		cstmt.setString(6, t_room); 
		cstmt.setInt(7, t_max);
		cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); 
	try  {  
		cstmt.execute(); 
		result = cstmt.getString(8);
	%>
<script>
	alert("<%= result %>"); 
	location.href="./manage_course_prof.jsp?year="+<%=t_year%>+"&semester="+<%=t_semester%>+"&type=selectAll&value=";
</script>
<% 
	} catch(SQLException ex) { 
	System.err.println("SQLException: " + ex.getMessage()); 
} finally { 
	if (cstmt != null) 
		try { myConn.commit(); cstmt.close(); myConn.close(); 
		} catch(SQLException ex) { } 
}
	} %>
</body>
</html>