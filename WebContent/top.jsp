<%@ page contentType="text/html; charset=EUC-KR" %>
<%
String session_id= (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a href=login.jsp>�α���</a>";
else log="<a href=logout.jsp>�α׾ƿ�</a>";
%>
<table width="90%" align="center" bgcolor="#FFFF99" border>
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="userinfo.jsp">�����������ȸ</b></td>
<td align="center"><b><a href="enroll/enroll_page.jsp?year=2016&semester=1&type=selectAll&value=''">������û</b></td>
<td align="center"><b><a href="timetable.jsp">�ð�ǥ</a></b></td>
<td align="center"><b><a href="checkScore.jsp">����Ȯ��</b></td>
</tr>
</table>