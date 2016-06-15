<%@ page contentType="text/html; charset=EUC-KR" %>

<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<style type="text/css">
body{
	font-family: 'Hanna';
	font-size: 15px;
}
table {
	
	/*border-bottom: 3px solid #6bd;
	border-top: 3px solid #6bd;
	margin: 0 0 7px 7px;
	padding: 0;*/
	border-left-width: 15px;
	border-right-width: 15px;
	border-bottom: 3px solid #6bd;
	border-top: 3px solid #6bd;
	border-right: 3px solid #DDD;border-left: 3px solid #DDD;
	/*outline: 3px solid #DDD;
	outline-offset: 5px;*/
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
table td a:active {
	background: #6bd;
	color: #222;
	text-decoration: none;
}

table td:hover {
	display: block;
}
</style>

<%
String session_id= (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a href=login.jsp>�α���</a>";
else log="<a href=logout.jsp>�α׾ƿ�</a>";

String validYear = "2016";
String validSemester = "2";
%>
<table width="850px" align="center">
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="/Course_Registeration/userInfo/professor_update.jsp">�����������ȸ</a></td>
<td align="center"><b><a href="/Course_Registeration/professor/manage_course_prof.jsp?year=2016&semester=1&type=selectAll&value=''">���� ����</b></td>
<td align="center"><b><a href="/Course_Registeration/timeTable/professor_time_table.jsp?year=<%=validYear%>&semester=<%=validSemester%>">�ð�ǥ</a></b></td>
<td align="center"><b><a href="/Course_Registeration/search/student_search.jsp?type=selectAll&value=">�л��˻�</b></td>
</tr>
</table>