<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�л��˻�</title>
<style>
table {
	width: 850px;
	margin-left: auto;
	margin-right: auto;
}

.margin-top {margin-top: 20px; }
	
.text-align-center { text-align: center; }

button { width: 80px; height: 25px; }
</style>
</head>
<body>
<%@ include file="../top.jsp" %>
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

String searchType = request.getParameter("type");
String value = new String(request.getParameter("value").getBytes("8859_1"), "EUC-KR");

%>
<table class="margin-top">
	<tr><td>
	<form method="post" id="search" action="student_search.jsp" >
 		<select name="type" id="typeSelect">
 			<option value="selectAll">��ü</option>
			<option value="s_name">�л��̸�</option>
			<option value="s_major">�а�</option>
			<option value="myClass">�����������л�</option></select>
		<input name="value" id="valueInput" size="30">
	    <button>�л��˻�</button></form></td></tr>
</table>
<script>
	document.getElementById("valueInput").value = "<%=value%>";
	document.getElementById("typeSelect").value = "<%=searchType%>";
</script>
<%
mySQL = "select * from student";
if(searchType.equals("s_name")) {
	mySQL = "select * from student where s_name = '" + value + "'";
} else if(searchType.equals("s_major")){
	mySQL = "select * from student where s_major = '" + value + "'";
} else if(searchType.equals("myClass")){
	
}
ResultSet myResultSet = stmt.executeQuery(mySQL);
%>
<table border= "1" class="text-align-center">
	<tr><td>�й�</td><td>�л��̸�</td><td>�а�</td><td>�г�</td><td>����ȣ</td></tr>
<%
	while(myResultSet.next() != false){
		String s_id = myResultSet.getString("s_id");
		String s_name = myResultSet.getString("s_name");
		String s_major = myResultSet.getString("s_major");
		String s_grade =  myResultSet.getString("s_grade");
		String s_phone =  myResultSet.getString("s_phone");
%>
		
		<tr><td><%=s_id%></td><td><%=s_name%></td><td><%=s_major%></td><td><%=s_grade%></td><td><%=s_phone%></td></tr>
<%}
%> 
</table>
</body>
</html>