<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� ���� ����</title>
<style>

</style>
</head>
<body>
<%@ include file="../top_prof.jsp" %>
<%
//if(session_id == null)
	//response.sendRedirect("login.jsp");
String professorID = "cs4580";  //���� ���̵�ο�

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

mySQL = "select * from professor where p_id='" + professorID + "'";;
ResultSet myResultSet = stmt.executeQuery(mySQL);

%>
<table >
<tr> 
      <td colspan="2" height="39" align="center">
         
    </tr>
    </table>
<form method="post" action="professor_update_verify.jsp">
  <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
    <tr> 
      <td colspan="2" height="39" align="center">
         <font size="+1" ><b>���� ���� ����</b></font></td>
    </tr>
    <tr>
      <td colspan="2" align="center">���� ���� ���� ȭ���Դϴ�:)</td>
    </tr>
     <tr> 
      <td width="200" align="center"><b>���̵� Ȯ��</b></td>
      <td width="400">&nbsp;</td>
    </tr>  
    <tr> 
      <td  width="200" align="center"> ����� ID </td>
      <td  width="400"><%=professorID%><sup><font size="2" color="red">&nbsp; *���̵�� �������� �����Ұ�</font></sup></td>
    </tr>

	<%
	while(myResultSet.next() != false){ 
		String p_id = myResultSet.getString("p_id"); 
		String p_pwd = myResultSet.getString("p_pwd");
		String p_name = myResultSet.getString("p_name");
		String p_major = myResultSet.getString("p_major");
		String p_college = myResultSet.getString("p_college");
		String p_room = myResultSet.getString("p_room");
		String p_email = myResultSet.getString("p_email");
		%>
		
		<tr>
					<td width="200" align="center">�� &nbsp; ��</td>
					<td width="400"><input type="text" name="p_name" size="15"
						value="<%=p_name%>"></td>
		</tr>
		     <tr> 
      <td width="200" align="center"> ��й�ȣ</td>
      <td width="400"><input type="password" name="p_pwd"
						size="15" value="<%=p_pwd%>"></td>
				</tr>
<tr> 
      <td width="200" align="center"><b>��������</b></td>
      <td width="400">&nbsp;</td>
    </tr>  
    <tr>
				<td width="200" align="center">���� &nbsp;����</td>
				<td width="400"><input type="text" name="p_college" size="50"
					value="<%=p_college%>"></td>
			</tr>
			<tr>
				<td width="200" align="center">�� &nbsp; ��</td>
				<td width="400"><input type="text" name="p_major" size="50"
					value="<%=p_major%>"></td>
			</tr>
			<tr>
				<td width="200" align="center">��&nbsp; ��&nbsp; ��</td>
				<td width="400"><input type="text" name="p_room" size="50"
					value="<%=p_room%>"></td>
			</tr>
			<tr>
				<td width="200" align="center">E-mail</td>
				<td width="400"><input type="text" name="p_email" size="50"
					value="<%=p_email%>"></td>
			</tr>
			
<%}
%> 
			<tr> 
      <td colspan="2" align="center"> 
       <input type="submit" name="modify" value="��   ��" >
       <input type="button" value="��  ��" onclick="javascript:window.location='main.jsp'">      
      </td>
    </tr>
</table>
</form>
</body>
</html>