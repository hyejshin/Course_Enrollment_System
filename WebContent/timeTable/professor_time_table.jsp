<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>시간표</title>
<style>
table {
	width: 750px;
	margin-left: auto;
	margin-right: auto;
}
.table_style1{
	width: 620px;
	margin-top: 20px;
	text-align: center;
}


button { width: 80px; height: 25px; }

div{
	border: 1px solid;
	text-align: center;
}
.schedule {
	position: relative; 
	width: 620px; 
	margin-left: auto;
	margin-right: auto;
	border-color: #D8D8D8;
}
.time{
	width:20px;
	height:80px;
	border-color: #D8D8D8;
}
.course{
	width: 120px;
	position: absolute;
	border-color: #D8D8D8;
}
</style>
</head>
<body>
<%@ include file="../top.jsp" %>
<%!
public int getDayValue(String str){
	if(str.equals("월"))
		return 0;
	else if(str.equals("화"))
		return 1;
	else if(str.equals("수"))
		return 2;
	else if(str.equals("목"))
		return 3;
	else if(str.equals("금"))
		return 4;
	else return -1;
}
%>
<% 
//String yearStr = request.getParameter("year");
//String semesterStr = request.getParameter("semester");
String yearStr = "2016";
String semesterStr = "1";

String p_id = "cs4555";  //세션 아이디부여
int year = Integer.parseInt(yearStr);
int semester = Integer.parseInt(semesterStr);

int totalEnrolledClass = 0;
int totalEnrolledUnit = 0;

String color[] = {"#58D3F7", "#AFF17F", "#FAAC58", "#F3F781", "#F78181", "#A9BCF5", "#5DADE2", "#BB8FCE"};

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

mySQL = "select * from teach where p_id = '" + p_id + "' and t_year = " + year + " and t_semester = " + semester;
ResultSet myResultSet = stmt.executeQuery(mySQL);

%>
<table align="center" class="table_style1">
	<tr><td><form method="post" action="student_time_table.jsp">
	학년도: <select name="year" id="yearSelect"><option value="2014">2014학년도</option>
					<option value="2015">2015학년도</option>
					<option value="2016">2016학년도</option>
					<option value="2017">2017학년도</option>
					<option value="2018">2018학년도</option></select>
		학기:	<select name="semester" id="semesterSelect" style="width:80px;"><option value="1">1학기</option>
							<option value="2">2학기</option></select>
		  <button>검색</button></form></td></tr></table>
<script>
	document.getElementById("yearSelect").value = <%= yearStr %>;
	document.getElementById("semesterSelect").value = <%= semesterStr %>;
</script>
<table border= "1" class="table_style1">
	<tr><td width="20px"></td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td></tr>
</table>
<div class="schedule">
<%
	int endHr = 14;
	int y = 0;
	while(myResultSet.next() != false){
		String c_id="", c_id_no="", c_name="", t_day="", t_time="", t_room="", p_name="";
		int c_unit=0;
		c_id = myResultSet.getString("c_id");
		c_id_no = myResultSet.getString("c_id_no");
		t_day =  myResultSet.getString("t_day");
		t_time =  myResultSet.getString("t_time");
		t_room =  myResultSet.getString("t_room");

		Statement stmt2 = myConn.createStatement();
		String mySQL2 = "select * from course where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "'";
		ResultSet myResultSet2 = stmt2.executeQuery(mySQL2);
		if(myResultSet2.next()){
			c_name =  myResultSet2.getString("c_name");
			c_unit =  myResultSet2.getInt("c_unit");
		}else{
			%>course table을 불러올 수 없음<%
			break;
		}
		
		int hr = Integer.parseInt(t_time.substring(0, 2));
		int min = Integer.parseInt(t_time.substring(3, 5));
		int startTime = hr*4+min/15;
		hr = Integer.parseInt(t_time.substring(6, 8));
		min = Integer.parseInt(t_time.substring(9, 11));
		if(endHr < hr)
			endHr = hr;
		int endTime = hr*4+min/15;
		int startPos = (startTime - 36)*20;
		int height = (endTime - startTime)*20;
		
		mySQL2 = "select * from professor where p_id='" + p_id + "'";
		myResultSet2 = stmt2.executeQuery(mySQL2);
		if(myResultSet2.next()){
			p_name =  myResultSet2.getString("p_name");
		}else{
			%>professor table을 불러올 수 없음<%
			break;
		}
		
		int len = t_day.length();
		for(int i=0; i<len; i+=2){
			int dayPos = 20 + 120*getDayValue(t_day.substring(i, i+1));
			%><div class="course" style="top:<%=startPos%>px; left:<%=dayPos%>px; height:<%=height%>px; 
			background-color:<%=color[totalEnrolledClass%8]%>">
				</br><%=c_name%></br><%=t_room%></br><%=t_time%>
			</div><%
		}
		totalEnrolledClass += 1;
		totalEnrolledUnit += c_unit;
	}
	for(int i=9; i<=endHr; i++){%>
	<div class="time" style="top:<%=y%>; left:0;"><%=i%></div><%
	y += 80;
}
%> 
</div>
<table>
	<tr><td width= "65%"></td><td>총수강과목: <%= totalEnrolledClass %></td><td>총수강학점: <%= totalEnrolledUnit %></td></tr>
</table>

</body>
</html>