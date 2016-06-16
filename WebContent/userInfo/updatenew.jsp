<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>학생 정보 수정</title>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/hanna.css">

<style>
body{
	font-family: 'Hanna';
}

</style>
</head>
<body>
<%@ include file="../top.jsp" %>
<%
if(session_id == null)
	response.sendRedirect("/Course_Registeration/login.jsp");

String studentID = session_id;  //세션 아이디부여

Connection myConn = null;
Statement stmt = null;
String mySQL = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db01";
String passwd = "ss2";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();

mySQL = "select * from student where s_id = '" + studentID + "'";;
ResultSet myResultSet = stmt.executeQuery(mySQL);

%>
<br>
<form method="post" action="user_update_verify.jsp">
  <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">

    <tr> 
      <td colspan="2" height="39" align="center">
         <font size="+1" ><b>학&nbsp; 생 정보 수정</b></font></td>
    </tr>
     <tr> 
      <td width="200" align="center"><b>아이디 확인 정보</b></td>
      <td width="400">&nbsp;</td>
    </tr>  
    <tr> 
      <td  width="200" align="center"> 사용자 ID </td>
      <td  width="400"><%=studentID%><sup><font size="2" color="red">&nbsp; *사용자 아이디는 학번으로 수정불가</font></sup></td>
    </tr>

	<%
	while(myResultSet.next() != false){ 
		String s_pwd = myResultSet.getString("s_pwd");
		String s_name = myResultSet.getString("s_name");
		String s_addr = myResultSet.getString("s_addr");
		String s_email = myResultSet.getString("s_email");
		String s_phone = myResultSet.getString("s_phone");%>
		<input type="hidden" name="s_id"
						size="15" value="<%=studentID%>">
		<tr>
					<td width="200" align="center"> 이&nbsp;름</td>
					<td width="400"><input type="text" name="s_name" size="15"
						value="<%=s_name%>"></td>
		</tr>
		     <tr> 
      <td width="200" align="center"> 비밀번호</td>
      <td width="400"><input type="password" name="s_pwd"
						size="15" value="<%=s_pwd%>"></td>
				</tr>
<tr> 
      <td width="200" align="center"><b>개인정보</b></td>
      <td width="400">&nbsp;</td>
    </tr>  
			<tr>
				<td width="200" align="center">주소</td>
				<td width="400"><input type="text" name="s_addr" size="50"
					value="<%=s_addr%>"></td>
			</tr>
			<tr>
				<td width="200" align="center">E-mail</td>
				<td width="400"><input type="text" name="s_email" size="50"
					value="<%=s_email%>"></td>
			</tr>
			<tr>
				<td width="200" align="center">연락처</td>
				<td width="400"><input type="text" name="s_phone" size="50"
					value="<%=s_phone%>"></td>
			</tr>
<%}
%> 
			<tr> 
      <td colspan="2" align="center"> 
       <input type="submit" name="modify" value="수   정" >
       <input type="button" value="취  소" onclick="javascript:window.location='main.jsp'">      
      </td>
    </tr>
</table>
</form>
</body>
</html>
