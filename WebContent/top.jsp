<%@ page contentType="text/html; charset=EUC-KR" %>
<%
String session_id= (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a href=login.jsp>로그인</a>";
else log="<a href=logout.jsp>로그아웃</a>";
%>
<table width="850px" align="center" bgcolor="#FFFF99" border>
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="/Course_Registeration/userinfo/updatenew.jsp">사용자정보조회</b></td>
<td align="center"><b><a href="/Course_Registeration/enroll/enroll_page.jsp?year=2016&semester=1&type=selectAll&value=">수강신청</b></td>
<td align="center"><b><a href="/Course_Registeration/timeTable/student_time_table.jsp">시간표</a></b></td>
<td align="center"><b><a href="/Course_Registeration/search/professor_search.jsp?type=selectAll&value=">교수검색</b></td>
</tr>
</table>