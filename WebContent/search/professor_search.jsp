<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>교수검색</title>
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
if(session_id == null)
	response.sendRedirect("/Course_Registeration/login.jsp");

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
	<form method="post" id="search" action="professor_search.jsp" >
 		<select name="type" id="typeSelect">
 			<option value="selectAll">전체</option>
			<option value="p_name">교수이름</option>
			<option value="p_major">학과</option></select>
		<input name="value" id="valueInput" size="30">
	    <button>교수검색</button></form></td></tr>
</table>
<script>
	document.getElementById("valueInput").value = "<%=value%>";
	document.getElementById("typeSelect").value = "<%=searchType%>";
</script>
<%
mySQL = "select * from professor";
if(searchType.equals("p_name")) {
	mySQL = "select * from professor where p_name LIKE '%" + value + "%'";
} else if(searchType.equals("p_major")){
	mySQL = "select * from professor where p_major LIKE '%" + value + "%'";
}
ResultSet myResultSet = stmt.executeQuery(mySQL);
%>
<table border= "1" class="text-align-center">
	<tr><td>교번</td><td>교수이름</td><td>학과</td><td>연구실</td><td>이메일</td></tr>
<%
	while(myResultSet.next() != false){
		String p_id = myResultSet.getString("p_id");
		String p_name = myResultSet.getString("p_name");
		String p_major = myResultSet.getString("p_major");
		String p_room =  myResultSet.getString("p_room");
		String p_email =  myResultSet.getString("p_email");
%>
		
		<tr><td><%=p_id%></td><td><%=p_name%></td><td><%=p_major%></td><td><%=p_room%></td><td><%=p_email%></td></tr>
<%}
%> 
</table>
</body>
</html>