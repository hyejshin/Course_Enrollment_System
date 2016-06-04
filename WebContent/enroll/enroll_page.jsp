<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>������û</title>
<style>
table {
	width: 90%;
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
String yearStr = request.getParameter("year");
String semesterStr = request.getParameter("semester");

String searchType = request.getParameter("type");
String typeValue = request.getParameter("value");

String studentID = "1315842";  //���� ���̵�ο�
int year = Integer.parseInt(yearStr);
int semester = Integer.parseInt(semesterStr);

int totalEnrolledClass = 0;
int totalEnrolledUnit = 0;

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

mySQL = "select * from enroll where s_id = '" + studentID + "' and e_year = " + year + " and e_semester = " + semester;
ResultSet myResultSet = stmt.executeQuery(mySQL);

%>
<table><form method="post" action="enroll_page.jsp?type=<%=searchType%>&value=<%=typeValue%>">
	<tr>
	<td>�г⵵: <select name="year" id="yearSelect"><option value="2014">2014�г⵵</option>
					<option value="2015">2015�г⵵</option>
					<option value="2016">2016�г⵵</option>
					<option value="2017">2017�г⵵</option>
					<option value="2018">2018�г⵵</option></select></td>
		<td>�б�:	<select name="semester" id="semesterSelect" style="width:80px;"><option value="1">1�б�</option>
							<option value="2">2�б�</option></select></td>
		<td>  <button width="60">�˻�</button></td><td width="50%"></td></tr></form></table>
<script>
	document.getElementById("yearSelect").value = <%= yearStr %>;
	document.getElementById("semesterSelect").value = <%= semesterStr %>;
</script>
<table border= "1" class="text-align-center">
	<tr><td>�����ȣ</td><td>�����</td><td>�й�</td><td>��������</td><td>����</td><td>����</td><td>���ǽð�</td><td>�������</td><td>�ο�</td><td>����</td></tr>
<%
	while(myResultSet.next() != false){
		String c_id = myResultSet.getString("c_id");
		String c_id_no = myResultSet.getString("c_id_no");

		Statement stmt2 = myConn.createStatement();
		String mySQL2 = "select * from course where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "'";
		ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String c_name =  myResultSet2.getString("c_name");
		int c_unit =  myResultSet2.getInt("c_unit");
		String c_major =  myResultSet2.getString("c_major");
		
		mySQL2 = "select * from teach where c_id='" + c_id + "' and c_id_no = '" + c_id_no + "' and t_year = " + year + " and t_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String p_id =  myResultSet2.getString("p_id");
		String t_day =  myResultSet2.getString("t_day");
		String t_time =  myResultSet2.getString("t_time");
		String t_room =  myResultSet2.getString("t_room"); 
		int t_max = myResultSet2.getInt("t_max"); 
		
		mySQL2 = "select * from professor where p_id='" + p_id + "'";
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String p_name =  myResultSet2.getString("p_name");
		
		totalEnrolledClass += 1;
		totalEnrolledUnit += c_unit;
		
		mySQL2 = "select COUNT(*) from enroll where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "' and e_year = " + year + " and e_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		int studentNum = myResultSet2.getInt(1);%>
		
		<tr><td><%=c_id%></td><td><%=c_name%></td><td><%=c_id_no%></td><td><%=c_major%></td><td><%=c_unit%></td>
		<td><%=p_name%></td><td><%=t_day%> <%=t_time%></td><td><%=t_room%></td><td><%= studentNum %>/<%= t_max %></td><td>�������</td></tr>
<%}
%> 
</table>
<table>
	<tr><td width= "65%"></td><td>�Ѽ�������: <%= totalEnrolledClass %></td><td>�Ѽ�������: <%= totalEnrolledUnit %></td></tr>
</table>
<table class="margin-top">
	<form method="post" action="enroll_page.jsp?year=<%=year%>&semester=<%=semester%>" >
	<tr><td> <input name="value" id="typeValue" size="30"></input>
		    <select name="type" id="searchType">
	    		<option value="selectAll">��ü</option>
				<option value="className">�����</option>
				<option value="classType">��������</option>
				<option value="professor">����</option></select> <button type="submit">���ǰ˻�</button></td></tr>
	</form>
</table><%= typeValue %><%= searchType %>
<script>
	document.getElementById("typeValue").value = <%= searchType %>;
	document.getElementById("searchType").value = <%= searchType %>;
</script>
<%
mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester;
myResultSet = stmt.executeQuery(mySQL);
%>
<table border= "1" class="text-align-center">
	<tr><td>�����ȣ</td><td>�����</td><td>�й�</td><td>��������</td><td>����</td><td>����</td><td>���ǽð�</td><td>�������</td><td>�ο�</td><td>����</td></tr>
<%
	while(myResultSet.next() != false){
		String c_id = myResultSet.getString("c_id");
		String c_id_no = myResultSet.getString("c_id_no");
		String p_id =  myResultSet.getString("p_id");
		String t_day =  myResultSet.getString("t_day");
		String t_time =  myResultSet.getString("t_time");
		String t_room =  myResultSet.getString("t_room"); 
		int t_max =  myResultSet.getInt("t_max"); 

		Statement stmt2 = myConn.createStatement();
		String mySQL2 = "select * from course where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "'";
		ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String c_name =  myResultSet2.getString("c_name");
		int c_unit =  myResultSet2.getInt("c_unit");
		String c_major =  myResultSet2.getString("c_major");
		
		mySQL2 = "select * from professor where p_id='" + p_id + "'";
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String p_name =  myResultSet2.getString("p_name");
		
		mySQL2 = "select COUNT(*) from enroll where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "' and e_year = " + year + " and e_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		int studentNum = myResultSet2.getInt(1);%>
		
		<tr><td><%=c_id%></td><td><%=c_name%></td><td><%=c_id_no%></td><td><%=c_major%></td><td><%=c_unit%></td>
		<td><%=p_name%></td><td><%=t_day%> <%=t_time%></td><td><%=t_room%></td><td><%= studentNum %>/<%= t_max %></td><td>������û</td></tr>
<%}
%> 
</table>
</body>
</html>