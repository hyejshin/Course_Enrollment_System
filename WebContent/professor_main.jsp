<%@ page contentType="text/html; charset=EUC-KR" %>
<html><head>
<title>�����ͺ��̽��� Ȱ���� ������û�ý����Դϴ�.</title></head>
<body>
 <%@ include file="top_prof.jsp" %>

<table width="850px" align="center" height="100%">
<% if (session_id!= null) { %>
<tr>
<td align="center"><%=session_name%>������ �湮�� ȯ���մϴ�.</td>
</tr>
<% } else { %>
<tr>
<td align="center">�α����� �� ����ϼ���.</td>
</tr>
<%
}
%>  
</table>
</body>
</html>