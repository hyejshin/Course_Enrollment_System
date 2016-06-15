<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*,java.util.*, deleteTeachBean.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>강좌 삭제 Delete</title>
</head>
<body>
<jsp:useBean id ="DeleteMgr" class="deleteTeachBean.DeleteMgr"/>
<%
String yearStr = request.getParameter("year");
String semesterStr = request.getParameter("semester");
String c_id = request.getParameter("c_id");
String c_id_no_str = request.getParameter("c_id_no");

int year = Integer.parseInt(yearStr);
int semester = Integer.parseInt(semesterStr);
int c_id_no = Integer.parseInt(c_id_no_str);

String session_id = (String)session.getAttribute("userID");
String p_id = session_id; //세션 아이디부여

String result = null;

result = DeleteMgr.deleteTeachlist(p_id, c_id, c_id_no);

%>
<script>
	alert("<%= result %>"); 
	location.href="./manage_course_prof.jsp?year="+<%=year%>+"&semester="+<%=semester%>+"&type=selectAll&value=";
</script>

</body>
</html>