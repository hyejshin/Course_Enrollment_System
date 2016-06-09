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
String c_id_no = request.getParameter("c_id_no");

int year = Integer.parseInt(yearStr);
int semester = Integer.parseInt(semesterStr);
String s_id = "1315842";

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

mySQL = "DELETE FROM enroll WHERE s_id='"+s_id+"' and c_id='"+c_id+"' and c_id_no='"+c_id_no+"'";
ResultSet myResultSet = stmt.executeQuery(mySQL);
%>

<script>
	alert("수강취소가 완료 되었습니다.");
	window.location.href="./enroll_page.jsp?year="+<%=year%>+"&semester="+<%=semester%>+"&type=selectAll&value=";
</script>

</body>
</html>