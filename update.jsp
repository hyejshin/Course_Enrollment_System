<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>������û ����� ���� ����</title></head>
<body>
<%@ include file="top.jsp" %>
��
if (session_id==null) response.sendRedirect("login.jsp");
��
mySQL = "select s_addr,s_pwd from student where s_id='" + session_id + "'" ;
��
<form method="post" action="update_verify.jsp">
��
</form>
</body>
</html> 