<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>수강신청</title>
</head>
<body>
<%@ include file="../top.jsp" %>
<% 
String studentID = "1315842"; 
int year = 2016;
int semester = 1;


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

mySQL = "select * from enroll where s_id='" + studentID + "' and year = " + year + " and semester = " + semester;
ResultSet myResultSet = stmt.executeQuery(mySQL);

%>
<table border= '1' width='600' align='center'>
	<tr><td>과목번호</td><td>과목명</td><td>분반</td><td>주관학과</td><td>학점</td><td>교수</td><td>강의시간</td><td>강의장소</td></tr>
<%
	while(myResultSet.next() != false){
		String c_id = myResultSet.getString("c_id");
		String c_id_no = myResultSet.getString("c_id_no");

		String mySQL2 = "select * from course where c_id='" + c_id + "' and c_id_no = '" + c_id_no + "'";
		ResultSet myResultSet2 = stmt.executeQuery(mySQL);
		myResultSet2.next();
		String c_name =  myResultSet2.getString("c_name");
		String c_unit =  myResultSet2.getString("c_unit");
		String c_major =  myResultSet2.getString("c_major");
		
		mySQL2 = "select * from teach where c_id='" + c_id + "' and c_id_no = '" + c_id_no + "' and year = " + year + " and semester = " + semester;
		myResultSet2 = stmt.executeQuery(mySQL);
		myResultSet2.next();
		String p_id =  myResultSet2.getString("p_id");
		String t_day =  myResultSet2.getString("t_day");
		String t_time =  myResultSet2.getString("t_time");
		String t_room =  myResultSet2.getString("t_room"); 
		
		mySQL2 = "select * from professor where p_id='" + p_id + "'";
		myResultSet2 = stmt.executeQuery(mySQL);
		myResultSet2.next();
		String p_name =  myResultSet2.getString("p_name");%>
		
		<tr><td><%=c_id%></td><td><%=c_name%></td><td><%=c_id_no%></td><td><%=c_major%></td><td><%=c_unit%></td><td><%=p_name%></td><td><%=t_day%><%=t_time%></td><td><%=t_room%></td></tr>
<%}
%> 

</table>

<table>
	<tr><td>과목번호</td><td>과목명</td><td>분반</td><td>주관학과</td><td>학점</td><td>교수</td><td>강의시간</td><td>강의장소</td></tr>
</table>
</body>
</html>