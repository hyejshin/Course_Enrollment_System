<%@ page contentType="text/html; charset=EUC-KR" %>
<%
String session_id = (String)session.getAttribute("userID");
String session_name = (String)session.getAttribute("userName");
String log;
if (session_id==null) log="<a href='/Course_Registeration/login.jsp'>�α���</a>";
else log="<a href='/Course_Registeration/logout.jsp'>�α׾ƿ�</a>";

String validYear = "2016";
String validSemester = "2";
%>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<style type="text/css">
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<style type="text/css">
body{
	
	
}
table {
font-size: 18px;
	font-family: 'Hanna';
	border-left-width: 5px;4
	border-right-width: 5px;
	border-bottom: 3px solid #6bd;
	border-top: 3px solid #6bd;
	border-right: 3px solid #DDD;border-left: 2px solid #DDD;
	text-transform: uppercase;
}


table td a {
	border-right: 1px solid #DDD;
	display: block;
	line-height: 30px;
	text-align: center;
	text-decoration: none;
	padding-left: 15px;
	padding-right: 15px;
	margin: 0;
}

table td a:hover {
	background: #6bd;
	color: #222;
	text-decoration: none;
}
table td a #top:active {
	background: #6bd;
	color: #222;
	text-decoration: none;
}

table td #top:hover {
	display: block;
}
</style>
<table width="850px" align="center">
<tr>
<td id ="top" align="center"><b><%=log%></b></td>
<td id ="top" align="center"><b><a href="/Course_Registeration/userInfo/updatenew.jsp">�����������ȸ</a></b></td>
<td id ="top" align="center"><b><a href="/Course_Registeration/enroll/enroll_page.jsp?year=<%=validYear%>&semester=<%=validSemester%>&type=selectAll&value=">������û</a></b></td>
<td id ="top" align="center"><b><a href="/Course_Registeration/timeTable/student_time_table.jsp?year=<%=validYear%>&semester=<%=validSemester%>">�ð�ǥ</a></b></td>
<td id ="top" align="center"><b><a href="/Course_Registeration/search/professor_search.jsp?type=selectAll&value=">�����˻�</a></b></td>
</tr>
</table>