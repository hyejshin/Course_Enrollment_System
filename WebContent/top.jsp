<%@ page contentType="text/html; charset=EUC-KR" %>
<%
String session_id= (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a href=login.jsp>�α���</a>";
else log="<a href=logout.jsp>�α׾ƿ�</a>";
%>
<table width="850px" align="center" bgcolor="#FFFF99" border>
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="/Course_Registeration/userinfo/updatenew.jsp">�����������ȸ</b></td>
<td align="center"><b><a href="/Course_Registeration/enroll/enroll_page.jsp?year=2016&semester=1&type=selectAll&value=">������û</b></td>
<td align="center"><b><a href="/Course_Registeration/timeTable/student_time_table.jsp">�ð�ǥ</a></b></td>
<td align="center"><b><a href="/Course_Registeration/search/professor_search.jsp?type=selectAll&value=">�����˻�</b></td>
</tr>
</table>