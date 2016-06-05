<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="java.sql.*"%>
<html>
<head>
<title>수강신청 사용자 정보 수정 확인</title></head>
<%
         String s_id = request.getParameter("s_id");

         String s_pwd = new String(request.getParameter("s_pwd"));
         String s_addr = new String(request.getParameter("s_addr").getBytes("Cp1252"), "euc-kr");
         String s_email = new String(request.getParameter("s_email"));
         String s_phone = new String(request.getParameter("s_phone"));

         Connection myConn = null;
         Statement stmt = null;
         String mySQL = "";
      
         String dburl = "";                           //db주소 입력하기
         String user = "db01";   String passwd = "ss2";
         String dbdriver = "oracle.jdbc.driver.OracleDriver";

         try{
 	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();
          } 
          catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage());
          }
 
          mySQL = "update student";
          mySQL = mySQL+ "SET s_pwd = '" + s_pwd +"' , ";
          mySQL = mySQL + "s_addr = '"+ s_addr + "' , ";
          mySQL = mySQL + "s_email = '"+ s_email + "' , ";
          mySQL = mySQL + "s_phone = '"+ s_phone +"' WHERE s_id = '" + s_id + "' "";

          try {
	stmt.executeQuery(mySQL);
%>
<script>
   alert("학생정보가 수정되었습니다." );
   location.href = "user_update.jsp";
</script>
<%
  }
  catch(SQLException ex) {
     	String sMessage;
	if(ex.getErrorCode() == 20002)
		sMessage = "암호는 4자리 이상이어야 합니다.";
	else if(ex.getErrorcode() == 20003)
		sMessage = "암호에 공란은 입력되지 않습니다.";
	else
		sMessage = "잠시 후 다시 시도하십시오" ;
%>
<script>
    alert("<%=sMessage%>" );
    location.href = "user_update.jsp";
</script>
<% } finally {
	if(stmt != null) {
	      try { 
                          stmt.close(); 
                          myConn.close();
                      }
                      catch(SQLException ex) { }
                }
         }
%>
</body>
</html>


         	
