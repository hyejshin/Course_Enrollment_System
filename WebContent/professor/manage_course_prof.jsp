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
<%@ include file="../top_prof.jsp" %>
<% 
String yearStr = request.getParameter("year");
String semesterStr = request.getParameter("semester");

String validCancel = "";

if(validYear.equals(yearStr) && validSemester.equals(semesterStr)){
	validCancel = "���»���";
}

String searchType = request.getParameter("type");
String typeValue = request.getParameter("value");

String professorID = session_id;

int year = Integer.parseInt(yearStr);  %><%= year %> <%
int semester = Integer.parseInt(semesterStr);   %><%= semester %> <%



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

%><%= professorID %> <%
mySQL = "select * from teach where p_id = '" + professorID + "' and t_year = " + year + " and t_semester = " + semester;

ResultSet myResultSet = stmt.executeQuery(mySQL);

%>
<table><form method="post" action="manage_course_prof.jsp?type=<%=searchType%>&value=<%=typeValue%>">
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
		String p_id =  myResultSet.getString("p_id");
		String c_id = myResultSet.getString("c_id");  
		String c_id_no = myResultSet.getString("c_id_no"); 
	
		String t_day =  myResultSet.getString("t_day");
		String t_time =  myResultSet.getString("t_time");
		String t_room =  myResultSet.getString("t_room"); 
		int t_max = myResultSet.getInt("t_max"); 
		
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
		
		totalEnrolledClass += 1;
		totalEnrolledUnit += c_unit;
		
		mySQL2 = "select COUNT(*) from enroll where c_id = '" + c_id + "' and c_id_no = '" + c_id_no + "' and e_year = " + year + " and e_semester = " + semester;
		myResultSet2 = stmt2.executeQuery(mySQL2);
		myResultSet2.next();
		int studentNum = myResultSet2.getInt(1);   %>
			
		<tr><td><%=c_id%></td><td><%=c_name%></td><td><%=c_id_no%></td><td><%=c_major%></td><td><%=c_unit%></td>
		<td><%=p_name%></td><td><%=t_day%> <%=t_time%></td><td><%=t_room%></td><td><%= studentNum %>/<%= t_max %></td>
		<td><a href="./delete_teach.jsp?year=<%=yearStr%>&semester=<%=semesterStr%>&c_id=<%=c_id%>&c_id_no=<%=c_id_no%>"><%=validCancel%></a></td></tr> 
 
<%}
%>  
</table> 
<table>
	<tr><td width= "65%"></td><td>�Ѽ�������: <%= totalEnrolledClass %></td><td>�Ѽ�������: <%= totalEnrolledUnit %></td></tr>
</table> 


<!-- http://seinarin.tistory.com/5 ���� �����ϱ� -->

<table border= "1" class="margin-top">
	<tr><td>
	���°���:<form method="post" action="insert_course.jsp" >
	 	�����:	<select name="c_name">
	 	
<%
	mySQL = "select c_name from course";

	myResultSet = stmt.executeQuery(mySQL);
 	while(myResultSet.next() != false){
		String c_name =  myResultSet.getString("c_name");
%>	
		<option value="<%= c_name %>"><%= c_name %></option>
<%}
%>  </select>
		�й�:<select name="c_id_no">
		 		<option value="1">1</option>
				<option value="2">2</option></select>
		
		 �г⵵:<%-- <select name="t_year">
		 		<option value=""></option>
				<option value="2017">2017</option></select> --%>
			<input type=text name="t_year" size="4" value="<%=validYear%>" readOnly/>
		�б�:<%-- <select name="t_semester">
	 			<option value="1">1</option>
				<option value="2">2</option></select>  --%>
		<input type=text name="t_semester" size="1" value="<%=validSemester%>" readOnly/>
		����:<select name="t_day">
	 			<option value="��,��">��,��</option>
	 			<option value="ȭ,��">ȭ,��</option>
				<option value="��,��">��,��</option></select>	
				
		�ð�:<select name="t_time">
	 			<option value="9:00-10:15">9:00-10:15</option>
	 			<option value="10:30-11:45">10:30-11:45</option>
				<option value="12:00-13:15">12:00-13:15</option>
				<option value="13:30-14:45">13:30-14:45</option>
				<option value="15:00-16:15">15:00-16:15</option>
				<option value="16:30-17:45">16:30-17:45</option>
				<option value="18:00-19:15">18:00-19:15</option></select>	
		
		���:<input type=text name="t_room" size="7"/>
		
		����:<input type=text name="t_max" onKeyPress="return digit_check(event)" size="3"/>
						
		    <button>���°���</button></form>
		    </td></tr>
</table>  


<table class="margin-top">
	<tr><td>
	<form method="post" action="manage_course_prof.jsp?year=<%=year%>&semester=<%=semester%>" >
	 <input name="value" id="typeValue" size="30">
	 		<select name="type" id="searchType">
	 			<option value="selectAll">��ü</option>
	 			<option value="c_id">�����ȣ</option>
				<option value="c_name">�����</option>
				<option value="c_major">��������</option>
				<option value="p_name">����</option></select>
		    <button>���ǰ˻�</button></form></td></tr>
</table>  
searchType: <%=searchType%>, typeValue: <%=typeValue%>
<script>
	alert(<%=searchType%>); //���� �ݿ����� �ʰ� ����
	document.getElementById("typeValue").value = <%=typeValue%>;
	document.getElementById("searchType").value = <%=searchType%>;
	
</script>  
<%
mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + "and p_id != '"+ professorID+"'" ;

if(searchType.equals("selectAll")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester +
			"and p_id != '"+ professorID +"'" ;
}else if(searchType.equals("p_name")){
	typeValue = "â����"; // typeValue�� �ݿ��ǰ� �ؾ���
	
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester +
			"and p_id != '"+ professorID +"' and p_name = '" + typeValue + "'" ;
}/* else if(searchType.equals("c_id")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			"and p_id != '"+ professorID + " and c_id = '"+ typeValue+"'" ;
}else if(searchType.equals("c_name")){
	typeValue = "�Ӻ����"; // typeValue�� �ݿ��ǰ� �ؾ���	
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			"and p_id != '"+ professorID + " and c_name = '"+ typeValue+"'" ;
}else if(searchType.equals("c_major")){
	typeValue = "����"; //typeValue�� �ݿ��ǰ� �ؾ���
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			"and p_id != '"+ professorID + " and c_major = '"+ typeValue+"'" ;
}*/

myResultSet = stmt.executeQuery(mySQL);
%>
<table border= "1" class="text-align-center">
	<tr><td>�����ȣ</td><td>�����</td><td>�й�</td><td>��������</td><td>����</td><td>����</td><td>���ǽð�</td><td>�������</td><td>�ο�</td></tr>
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
		<td><%=p_name%></td><td><%=t_day%> <%=t_time%></td><td><%=t_room%></td><td><%= studentNum %>/<%= t_max %></td></tr>
<%}
%> 
</table>
</body>
</html>