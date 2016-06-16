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

String yearStr = request.getParameter("year");
String semesterStr = request.getParameter("semester");
String searchType = request.getParameter("type");
String typeValue = new String(request.getParameter("value").getBytes("8859_1"), "EUC-KR");
String studentID = session_id;

String validEnroll = "";
String validCancel = "";

if(validYear.equals(yearStr) && validSemester.equals(semesterStr)){
	validEnroll = "������û";
	validCancel = "�������";
}

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
<table><form method="post" id="year_semester" action="enroll_page.jsp?type=<%=searchType%>&value=<%=typeValue%>">
	<tr>
	<td>�г⵵: <select name="year" id="yearSelect"><option value="2014">2014�г⵵</option>
					<option value="2015">2015�г⵵</option>
					<option value="2016">2016�г⵵</option>
					<option value="2017">2017�г⵵</option>
					<option value="2018">2018�г⵵</option></select></td>
		<td>�б�:	<select name="semester" id="semesterSelect" style="width:80px;"><option value="1">1�б�</option>
							<option value="2">2�б�</option></select></td>
		<td>  <button>�˻�</button></td><td width="50%"></td></tr></form></table>
<script>
	document.getElementById("yearSelect").value = <%= yearStr %>;
	document.getElementById("semesterSelect").value = <%= semesterStr %>;
</script>
<table border= "1" class="text-align-center">
	<tr><td>�����ȣ</td><td>�����</td><td>�й�</td><td>��������</td><td>����</td><td>����</td><td>���ǽð�</td><td>�������</td><td>�ο�</td><td>����</td></tr>
<%
	while(myResultSet.next() != false){
		String c_id="", c_id_no="", c_name="", c_major="", p_id="", p_name="";
		String t_day="", t_time="", t_room="";
		int t_max=0, c_unit=0, studentNum=0;
		
		c_id = myResultSet.getString("c_id");
		c_id_no = myResultSet.getString("c_id_no");
		Statement stmt2 = myConn.createStatement();
		String mySQL2 = "select * from course where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "'";
		ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		c_name =  myResultSet2.getString("c_name");
		c_unit =  myResultSet2.getInt("c_unit");
		c_major =  myResultSet2.getString("c_major");
		
		mySQL2 = "select * from teach where c_id='" + c_id + "' and c_id_no = '" + c_id_no + "' and t_year = " + year + " and t_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		if(myResultSet2.next()){
			p_id =  myResultSet2.getString("p_id");
			t_day =  myResultSet2.getString("t_day");
			t_time =  myResultSet2.getString("t_time");
			t_room =  myResultSet2.getString("t_room"); 
			t_max = myResultSet2.getInt("t_max"); 
		}
		
		mySQL2 = "select * from professor where p_id='" + p_id + "'";
		myResultSet2 = stmt2.executeQuery(mySQL2);
		if(myResultSet2.next()){
			p_name =  myResultSet2.getString("p_name");
		}
	
		totalEnrolledClass += 1;
		totalEnrolledUnit += c_unit;
		
		mySQL2 = "select COUNT(*) from enroll where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "' and e_year = " + year + " and e_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		if(myResultSet2.next()){
			studentNum = myResultSet2.getInt(1);
		}%>
		
		<tr><td><%=c_id%></td><td><%=c_name%></td><td><%=c_id_no%></td><td><%=c_major%></td><td><%=c_unit%></td>
		<td><%=p_name%></td><td><%=t_day%> <%=t_time%></td><td><%=t_room%></td>
		<td><a target="popup" onclick="window.open('../search/student_list.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>&year=<%=year%>&semester=<%=semester%>','�л����','width=800,height=400')" style="color:#0174DF;"><%= studentNum %>/<%= t_max %></a></td>
		<td><a href="./delete.jsp?year=<%=yearStr%>&semester=<%=semesterStr%>&c_id=<%=c_id%>&c_id_no=<%=c_id_no%>"><%=validCancel%></a></td></tr>
<%}
%> 
</table>
<table>
	<tr><td width= "65%"></td><td>�Ѽ�������: <%= totalEnrolledClass %></td><td>�Ѽ�������: <%= totalEnrolledUnit %></td></tr>
</table>
<table class="margin-top">
	<tr><td>
	<form method="post" id="search" action="enroll_page.jsp?year=<%=year%>&semester=<%=semester%>" >
 		<select name="type" id="typeSelect">
 			<option value="selectAll">��ü</option>
			<option value="c_name">�����</option>
			<option value="p_name">����</option>
			<option value="c_id">�����ȣ</option>
			<option value="c_major">��������</option></select>
		<input name="value" id="valueInput" size="30">
	    <button>���ǰ˻�</button></form></td></tr>
</table>
<script>
	document.getElementById("valueInput").value = "<%=typeValue%>";
	document.getElementById("typeSelect").value = "<%=searchType%>";
</script>
<%
if(searchType.equals("selectAll")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester
			+ " and c_id not in (select c_id from enroll where s_id = '" + studentID + 
			"' and e_year = " + year + " and e_semester = " + semester + ")";
}else if(searchType.equals("p_name")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			" and p_id in (select p_id from professor where p_name = '" + typeValue + "')" 
			+ " and c_id not in (select c_id from enroll where s_id = '" + studentID + 
			"' and e_year = " + year + " and e_semester = " + semester + ")";
} else if(searchType.equals("c_id")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + " and c_id = '" + typeValue
			+ "' and c_id not in (select c_id from enroll where s_id = '" + studentID + 
			"' and e_year = " + year + " and e_semester = " + semester + ")";
}else if(searchType.equals("c_name")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			" and c_id in (select c_id from course where c_name LIKE '%" + typeValue + "%')" 
			+ " and c_id not in (select c_id from enroll where s_id = '" + studentID + 
			"' and e_year = " + year + " and e_semester = " + semester + ")";
}else if(searchType.equals("c_major")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			" and c_id in (select c_id from course where c_major LIKE '%" + typeValue + "%')" 
			+ " and c_id not in (select c_id from enroll where s_id = '" + studentID + 
			"' and e_year = " + year + " and e_semester = " + semester + ")";
}
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
		<td><%=p_name%></td><td><%=t_day%> <%=t_time%></td><td><%=t_room%></td>
		<td><a target="popup" onclick="window.open('../search/student_list.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>&year=<%=year%>&semester=<%=semester%>','�л����','width=800,height=400')" style="color:#0174DF;"><%= studentNum %>/<%= t_max %></a></td>
		<td><a href="./insert.jsp?year=<%=yearStr%>&semester=<%=semesterStr%>&c_id=<%=c_id%>&c_id_no=<%=c_id_no%>"><%=validEnroll%></a></td></tr>
<%}
%> 
</table>
</body>
</html>