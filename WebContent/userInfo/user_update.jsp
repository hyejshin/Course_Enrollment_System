<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="java.sql.*"%>
<html>
<head>
<title>수강신청 사용자 정보</title></head>
<%
    if(session_id==null)
	resoponse.sendRedirect("login.jsp");

    Connection myConn = null;
    Statement stmt = null;
    ResultSet myResultSet = null;
    String mySQL = "";

    String dburl = "jdbc:oracle:thin;@db.   //db주소 넣어주기
    String user = "db01";
    String passwd = "ss2";
    String dbdriver = "oracle.jdbc.driver.OracleDriver";

    try{
 	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
    } catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
       }

   mySQL = "select s_id, s_pwd, s_addr, s_email, s_phone from student where s_id =' " + session_id + " ' ";
    myResultSet = stmt.executeQuery(mySQL);
    if(myResulySet.next()) {
	String s_id = myResultSet.getString("s_id");
	String s_pwd = myResultSet.getString("s_pwd"); 
	String s_addr = myResultSet.getString("s_addr"); 
	String s_email = myResultSet.getString("s_email"); 
	String s_phone = myResultSet.getString("s_phone");
%>

<form method="post" action="user_update_verify.jsp">
  <input type="hidden" name="s_id" size="30" value="<%=session_id%>">
  <table width="75%" align="center" border="1">
     <tr><th>비밀번호</th>
            <td><input type="password" name="s_pwd" size="20" value="<%=s_pwd%>">
            </td></tr>
     <tr><th>주소</th>
            <td><input type="text" name="s_addr" size="50" value="<%=s_addr%>">
            </td></tr>
     <tr><th>E-mail</th>
            <td><input type="text" name="s_email" size="80" value="<%=s_email%>">
            </td></tr>
     <tr><th>연락처</th>
            <td><input type="text" name="s_phone" size="80" value="<%=s_phone%>">
            </td></tr>

<%
    }
    stmt.close();
    myConn.close();
%>
<tr>
<td colspan="2" align="center"><input type="submit" value="수정"></td></tr>
</table></form>
</body>
</html>
