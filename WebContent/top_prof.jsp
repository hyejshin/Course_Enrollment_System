<%@ page contentType="text/html; charset=EUC-KR" %>
<%
String session_id= (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a href=login.jsp>�α���</a>";
else log="<a href=logout.jsp>�α׾ƿ�</a>";

String validYear = "2016";
String validSemester = "2";
%>
<table width="850px" align="center" bgcolor="#FFFF99" border>
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="/Course_Registeration/userInfo/professor_update.jsp">�����������ȸ</a></td>
<td align="center"><b><a href="professor/manage_course_prof.jsp?year=2016&semester=1&type=selectAll&value=''">���� ����</b></td>
<td align="center"><b><a href="/Course_Registeration/timeTable/professor_time_table.jsp?year=<%=validYear%>&semester=<%=validSemester%>">�ð�ǥ</a></b></td>
<td align="center"><b><a href="/Course_Registeration/search/student_search.jsp?type=selectAll&value=">�л��˻�</b></td>
</tr>
</table>