<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="java.sql.*"%>
<html>
<head>
<title>������û ����� ���� ���� Ȯ��</title></head>
<%
         String p_id = request.getParameter("p_id");

         String p_pwd = new String(request.getParameter("p_pwd"));
         String p_name = new String(request.getParameter("p_name"));
         String p_email = new String(request.getParameter("p_email"));
         String p_college = new String(request.getParameter("p_college"));
         String p_room = new String(request.getParameter("p_room"));
         String p_major = new String(request.getParameter("p_major"));

         Connection myConn = null;
         Statement stmt = null;
         String mySQL = "";
      
         String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
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
 
          mySQL = "update professor";
          mySQL = mySQL+ "SET p_pwd = '" + p_pwd +"',";
          mySQL = mySQL + "p_email = '"+ p_email + "',";
          mySQL = mySQL + "p_name = '"+ p_name + "',";
          mySQL = mySQL + "p_major = '"+ p_major + "',";
          mySQL = mySQL + "p_room = '"+ p_room + "',";
          mySQL = mySQL + "s_college = '"+ p_college +"' WHERE p_id = '" + p_id + "'";

          try {
	stmt.executeQuery(mySQL);
%>
<script>
   alert("������ �����Ǿ����ϴ�." );
   location.href = "professor_update.jsp";
</script>
<%
  }
  catch(SQLException ex) {
     	String sMessage;
	if(ex.getErrorCode() == 20002)
		sMessage = "��ȣ�� 4�ڸ� �̻��̾�� �մϴ�.";
	else if(ex.getErrorCode() == 20003)
		sMessage = "��ȣ�� ������ �Էµ��� �ʽ��ϴ�.";
	else
		sMessage = "��� �� �ٽ� �õ��Ͻʽÿ�" ;
%>
<script>
    alert("<%=sMessage%>" );
    location.href = "professor_update.jsp";
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


         	