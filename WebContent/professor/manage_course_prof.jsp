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

String yalidYear2 = "2016";
String validSemester2 = "2";

String validCancel = "";

if(validYear.equals(yearStr) && validSemester.equals(semesterStr)){
	validCancel = "���»���";
}

if(session_id == null)
	response.sendRedirect("/Course_Registeration/login.jsp");

String searchType = request.getParameter("type");
String typeValue = new String(request.getParameter("value").getBytes("8859_1"), "EUC-KR");
String professorID = session_id;  //���� ���̵�ο�

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
		int studentNum = 0;
		
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
		if(myResultSet2.next()){
			studentNum = myResultSet2.getInt(1);
		}%>
			
		<tr><td><%=c_id%></td><td><%=c_name%></td><td><%=c_id_no%></td><td><%=c_major%></td><td><%=c_unit%></td>
		<td><%=p_name%></td><td><%=t_day%> <%=t_time%></td><td><%=t_room%></td>
		<td><a target="popup" onclick="window.open('../search/student_list.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>&year=<%=year%>&semester=<%=semester%>','�л����','width=800,height=400')" style="color:#0174DF;"><%= studentNum %>/<%= t_max %></a></td>
		<td> <a href="./delete_teach.jsp?year=<%=yearStr%>&semester=<%=semesterStr%>&c_id=<%=c_id%>&c_id_no=<%=c_id_no%>"><%=validCancel%></a></td></tr> 
 
<%}
%>  
</table> 
<table>
	<tr><td width= "65%"></td><td>�Ѽ�������: <%= totalEnrolledClass %></td><td>�Ѽ�������: <%= totalEnrolledUnit %></td></tr>
</table> 

<!-- http://seinarin.tistory.com/5 ���� �����ϱ� -->


<table border= "1" class="margin-top">
	<tr><td>
	���°���:<form method="post" action="insert_course.jsp" id="addTeach">
	 	<select name="c_name">
	 	
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
		
		 �г⵵:<input type=text name="t_year" size="2" value="<%=validYear%>" readOnly/>
		�б�:<input type=text name="t_semester" size="1" value="<%=validSemester%>" readOnly/>
		����:<select name="t_day">
	 			<option value="��,��">��,��</option>
	 			<option value="ȭ,��">ȭ,��</option>
				<option value="��,��">��,��</option></select>	
				
		�ð�:<select name="t_time">
	 			<option value="09:00-10:15">09:00-10:15</option>
	 			<option value="10:30-11:45">10:30-11:45</option>
				<option value="12:00-13:15">12:00-13:15</option>
				<option value="13:30-14:45">13:30-14:45</option>
				<option value="15:00-16:15">15:00-16:15</option>
				<option value="16:30-17:45">16:30-17:45</option>
				<option value="18:00-19:15">18:00-19:15</option></select>	
		
		���:<select name="t_room">
	 			<option value="���305">���305</option>
	 			<option value="���308">���308</option>
				<option value="���309">���309</option>
				<option value="���408">���408</option>
				<option value="���409">���409</option>
				<option value="���413">���413</option>
				<option value="���416">���416</option>
				<option value="���509">���509</option>
				<option value="���514">���514</option>
				<option value="���516">���516</option></select>	
		
		����:<input type=text name="t_max" onKeyPress="return digit_check(event)" size="2"/>
						
			<input type="submit" value="���°���" onclick="return blanck_check()"/> </form>
		    </td></tr>
</table>  
	<script>
	function digit_check(event) {
	 if ((event.keyCode >= 48 && event.keyCode <= 57)) {//number
	        return true;
	    } else {
	        event.returnValue = false;
	    }
	}

	function blanck_check(){
		var fr = document.getElementById("addTeach");
		if (fr.t_max.value.length < 1) {
			alert("�����ο��� �Է����ּ���");
			fr.t_max.focus();
			return false;
		}else
			{return true;}
	}
	</script>

<table class="margin-top">
	<tr><td>
	<form method="post" id="search" action="manage_course_prof.jsp?year=<%=year%>&semester=<%=semester%>" >
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
	alert(<%=searchType%>); //���� �ݿ����� �ʰ� ����
	document.getElementById("typeValue").value = <%=typeValue%>;
	document.getElementById("searchType").value = <%=searchType%>;
	
</script>  
<%
mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + " and p_id != '"+ professorID+"'" ;

if(searchType.equals("selectAll")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester
			+ " and p_id != '"+ professorID +"'" ;
}else if(searchType.equals("p_name")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			" and p_id in (select p_id from professor where p_name = '" + typeValue + "')" 
			+ " and p_id != '"+ professorID +"'" ;
} else if(searchType.equals("c_id")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + " and c_id = '" + typeValue
			+ "' and p_id != '"+ professorID +"'" ;
}else if(searchType.equals("c_name")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			" and c_id in (select c_id from course where c_name LIKE '%" + typeValue + "%')" 
			+ " and p_id != '"+ professorID +"'" ;
}else if(searchType.equals("c_major")){
	mySQL = "select * from teach where t_year = " + year + " and t_semester = " + semester + 
			" and c_id in (select c_id from course where c_major LIKE '%" + typeValue + "%')" 
			+ " and p_id != '"+ professorID +"'" ;
}
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