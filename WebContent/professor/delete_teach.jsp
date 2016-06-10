<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%><%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>수강신청</title>
</head>
<body>
<% 
String yearStr = request.getParameter("year");
String semesterStr = request.getParameter("semester");
String c_id = request.getParameter("c_id");
String c_id_no_str = request.getParameter("c_id_no");

int year = Integer.parseInt(yearStr);
int semester = Integer.parseInt(semesterStr);
int c_id_no = Integer.parseInt(c_id_no_str);
String p_id = "cs4590"; //세션아이디부여
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
/*stmt = myConn.createStatement();

mySQL = "DELETE FROM teach WHERE p_id='"+p_id+"' and c_id='"+c_id+"' and c_id_no='"+c_id_no+
"' and t_year= "+ year + " and t_semester = " + semester ;
ResultSet myResultSet = stmt.executeQuery(mySQL); */

CallableStatement cstmt = myConn.prepareCall("{call  DeleteTeach(?,?,?,?)}"); 
cstmt.setString(1, p_id); 
cstmt.setString(2, c_id); 
cstmt.setInt(3, c_id_no);
cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); 
try  {  
	cstmt.execute(); 
	result = cstmt.getString(4);
%>
<script>
	alert("<%= result %>"); 
	location.href="./manage_course_prof.jsp?year="+<%=year%>+"&semester="+<%=semester%>+"&type=selectAll&value=";
</script>
<%
} catch(SQLException ex) { 
	System.err.println("SQLException: " + ex.getMessage()); 
} finally { 
	if (cstmt != null) 
		try { myConn.commit(); cstmt.close(); myConn.close(); 
		} catch(SQLException ex) { } 
} %>
</body>
</html>