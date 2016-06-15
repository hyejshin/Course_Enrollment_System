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
int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));

int year = Integer.parseInt(yearStr);
int semester = Integer.parseInt(semesterStr);
String session_id = (String)session.getAttribute("userID");
String s_id = session_id;
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
mySQL = "INSERT INTO enroll(s_id, c_id, c_id_no, e_year, e_semester) VALUES ('"+s_id+"', '"+c_id+"', '"+c_id_no+"', "+year+", "+semester+")";
ResultSet myResultSet = stmt.executeQuery(mySQL);*/

CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}"); 
cstmt.setString(1, s_id); 
cstmt.setString(2, c_id); 
cstmt.setInt(3, c_id_no);
cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); 
try  {  
	cstmt.execute(); 
	result = cstmt.getString(4);
%>
<script>
	alert("<%= result %>"); 
	location.href="./enroll_page.jsp?year="+<%=year%>+"&semester="+<%=semester%>+"&type=selectAll&value=";
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