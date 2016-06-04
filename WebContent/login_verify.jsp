<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*"%>

<%
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");

Connection myConn = null;
Statement stmt = null;
String mySQL = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:oracle";
String user = "db01";
String passwd = "ss2";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();

mySQL = "select s_name from students where s_id='" + userID + "' and s_pwd='"
+ userPassword + "'";
ResultSet myResultSet = stmt.executeQuery(mySQL);

if(myResultSet.next() != false){
	String urserID = myResultSet.getString("userID");
	session.setAttribute("user", userID);
	response.sendRedirect("main.jsp");
}else{
	response.sendRedirect("login.jsp");
}


stmt.close();
myConn.close();
%>



