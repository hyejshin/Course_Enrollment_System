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
<td align="center"><b><a href="userinfo.jsp">�����������ȸ</b></td>
<td align="center"><b><a href="professor/manage_course_prof.jsp?year=2016&semester=1&type=selectAll&value=''">���� ����</b></td>
<td align="center"><b><a href="/Course_Registeration/timeTable/professor_time_table.jsp">�ð�ǥ</a></b></td>
<td align="center"><b><a href="/Course_Registeration/search/student_search.jsp?type=selectAll&value=">�л��˻�</b></td>
</tr>
</table>