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
<td align="center"><b><a href="/Course_Registeration/userInfo/updatenew.jsp">�����������ȸ</b></td>
<td align="center"><b><a href="/Course_Registeration/enroll/enroll_page.jsp?year=<%=validYear%>&semester=<%=validSemester%>&type=selectAll&value=">������û</b></td>
<td align="center"><b><a href="/Course_Registeration/timeTable/student_time_table.jsp?year=<%=validYear%>&semester=<%=validSemester%>">�ð�ǥ</a></b></td>
<td align="center"><b><a href="/Course_Registeration/search/professor_search.jsp?type=selectAll&value=">�����˻�</b></td>
</tr>
</table>