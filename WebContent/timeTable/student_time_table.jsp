<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ð�ǥ</title>
<style>
table {
	width: 850px;
	margin-left: auto;
	margin-right: auto;
}
#day{width: 620px;}
.margin-top {margin-top: 20px; }
.text-align-center { text-align: center; }

button { width: 80px; height: 25px; }

div{
	border: 1px solid;
}
.schedule {
	position: relative; 
	width: 620px; 
	height: 700px;
	margin-left: auto;
	margin-right: auto;
}
.time{
	width:20px;
	height:80px;
}
.course{
	width: 120px;
	position: absolute;
}
</style>
</head>
<body>
<%@ include file="../top.jsp" %>
<%!
public int getDayValue(String str){
	if(str.equals("��"))
		return 0;
	else if(str.equals("ȭ"))
		return 1;
	else if(str.equals("��"))
		return 2;
	else if(str.equals("��"))
		return 3;
	else if(str.equals("��"))
		return 4;
	else return -1;
}
%>
<% 
//String yearStr = request.getParameter("year");
//String semesterStr = request.getParameter("semester");
String yearStr = "2016";
String semesterStr = "1";

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
<table><form method="post" action="student_time_table.jsp">
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
<table border= "1" id="day" class="text-align-center, margin-top">
	<tr><td width="20px"></td><td>��</td><td>ȭ</td><td>��</td><td>��</td><td>��</td></tr>
</table>
<div class="schedule">
<%
	int y = 0;
	for(int i=9; i<=20; i++){%>
		<div class="time" style="top:<%=y%>; left:0;"><%=i%></div><%
		y += 80;
	}
	while(myResultSet.next() != false){
		String c_id = myResultSet.getString("c_id");
		String c_id_no = myResultSet.getString("c_id_no");

		Statement stmt2 = myConn.createStatement();
		String mySQL2 = "select * from course where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "'";
		ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String c_name =  myResultSet2.getString("c_name");
		int c_unit =  myResultSet2.getInt("c_unit");
		
		mySQL2 = "select * from teach where c_id='" + c_id + "' and c_id_no = '" + c_id_no + "' and t_year = " + year + " and t_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String p_id =  myResultSet2.getString("p_id");
		String t_day =  myResultSet2.getString("t_day");
		String t_time =  myResultSet2.getString("t_time");
		String t_room =  myResultSet2.getString("t_room");
		
		int hr = Integer.parseInt(t_time.substring(0, 2));
		int min = Integer.parseInt(t_time.substring(3, 5));
		int startTime = hr*4+min/15;
		hr = Integer.parseInt(t_time.substring(6, 8));
		min = Integer.parseInt(t_time.substring(9, 11));
		int endTime = hr*4+min/15;
		int startPos = (startTime - 36)*20;
		int height = (endTime - startTime)*20;
		
		mySQL2 = "select * from professor where p_id='" + p_id + "'";
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		String p_name =  myResultSet2.getString("p_name");
		
		totalEnrolledClass += 1;
		totalEnrolledUnit += c_unit;
		
		mySQL2 = "select COUNT(*) from enroll where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "' and e_year = " + year + " and e_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		int studentNum = myResultSet2.getInt(1);
		
		int len = t_day.length();
		for(int i=0; i<len; i+=2){
			int dayPos = 20 + 120*getDayValue(t_day.substring(i, i+1));
			%><div class="course" style="top:<%=startPos%>px; left:<%=dayPos%>px; height:<%=height%>px">
				<%=c_name%></br><%=p_name%></br><%=t_room%></br><%=t_time%>
			</div><%
		}
}
%> 
</div>
<table>
	<tr><td width= "65%"></td><td>�Ѽ�������: <%= totalEnrolledClass %></td><td>�Ѽ�������: <%= totalEnrolledUnit %></td></tr>
</table>

</body>
</html>