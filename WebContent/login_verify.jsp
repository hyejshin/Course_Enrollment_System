<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*"%>

<%
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");


Connection myConn = null;
Statement stmt = null;
String mySQL = null;
String mySQL2 = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db01";
String passwd = "ss2";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();


if(userID.startsWith("1")) {
	mySQL = "select s_name from student where s_id='" + userID + "' and s_pwd='" + userPassword + "'";
	ResultSet  myResultSet = stmt.executeQuery(mySQL);
    if(myResultSet.next() != false){

		String name = myResultSet.getString("s_name");
		session.setAttribute("userName", name);
		session.setAttribute("userID", userID);  
		response.sendRedirect("main.jsp");
	}
    else { %>
    <script>
    	alert("로그인 실패.");
    	location.href="login.jsp";
    </script>
    <%
    }
}
else if(userID.startsWith("cs")) {
	mySQL2 = "select p_name from professor where p_id='" + userID + "' and p_pwd='" + userPassword + "'";
    ResultSet myResultSet2 = stmt.executeQuery(mySQL2);
    if(myResultSet2.next() != false){

		String name = myResultSet2.getString("p_name");
		session.setAttribute("userName", name);
		session.setAttribute("userID", userID); 
		response.sendRedirect("professor_main.jsp");
	}
    
    else { %>
    <script>
    	alert("로그인 실패.");
    	location.href="login.jsp";
    </script>
    <%
    }
}

else { %>
<script>
	alert("로그인 실패.");
	location.href="login.jsp";
</script>
<%
	//response.sendRedirect("login.jsp");
}
stmt.close();
myConn.close();
%>



