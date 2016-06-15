<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>학생검색</title>
<style>
body{
	font-family: 'Hanna';
	font-size: 15px;
}
table {
	width: 600px;
	margin-left: auto;
	margin-right: auto;
	border-left-width: 15px;
	border-right-width: 15px;
	border-bottom: 3px solid #6bd;
	border-top: 3px solid #6bd;
	border-right: 3px solid #DDD;border-left: 3px solid #DDD;
	text-transform: uppercase;
	border-collapse: collapse;
}
tr.header{ background-color: #6bd}
td{text-align: center;}
</style>
</head>
<body>
<%
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

String c_id = request.getParameter("c_id");
String c_id_no_str = request.getParameter("c_id_no");
String year_str = request.getParameter("year");
String semester_str = request.getParameter("semester");

int c_id_no = Integer.parseInt(c_id_no_str);
int year = Integer.parseInt(year_str);
int semester = Integer.parseInt(semester_str);

mySQL = "select * from enroll where c_id = '" + c_id + "' and c_id_no= " + c_id_no + " and e_year = " + year + " and e_semester = " + semester;
ResultSet myResultSet = stmt.executeQuery(mySQL);
%>
<table border= "1" class="text-align-center">
	<tr class="header"><th>학번</th><th>학생이름</th><th>학과</th><th>학년</th><th>폰번호</th></tr>
<%
	while(myResultSet.next() != false){
		String s_id = myResultSet.getString("s_id");
		
		Statement stmt2 = myConn.createStatement();
		String mySQL2 = "select * from student where s_id = '" + s_id + "'";
		ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		
		String s_name = myResultSet2.getString("s_name");
		String s_major = myResultSet2.getString("s_major");
		String s_grade =  myResultSet2.getString("s_grade");
		String s_phone =  myResultSet2.getString("s_phone");
%>
		
		<tr><td><%=s_id%></td><td><%=s_name%></td><td><%=s_major%></td><td><%=s_grade%></td><td><%=s_phone%></td></tr>
<%}
%> 
</table>
</body>
</html>