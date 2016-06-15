<%@ page contentType="text/html; charset=EUC-KR" %>
<%
String session_id = (String)session.getAttribute("userID");
String session_name = (String)session.getAttribute("userName");
String log;
if (session_id==null) log="<a href='/Course_Registeration/login.jsp'>로그인</a>";
else log="<a href='/Course_Registeration/logout.jsp'>로그아웃</a>";

String validYear = "2016";
String validSemester = "2";
%>
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
<table width="850px" align="center">
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="/Course_Registeration/userInfo/updatenew.jsp">사용자정보조회</a></b></td>
<td align="center"><b><a href="/Course_Registeration/enroll/enroll_page.jsp?year=<%=validYear%>&semester=<%=validSemester%>&type=selectAll&value=">수강신청</a></b></td>
<td align="center"><b><a href="/Course_Registeration/timeTable/student_time_table.jsp?year=<%=validYear%>&semester=<%=validSemester%>">시간표</a></b></td>
<td align="center"><b><a href="/Course_Registeration/search/professor_search.jsp?type=selectAll&value=">교수검색</a></b></td>
</tr>
</table>