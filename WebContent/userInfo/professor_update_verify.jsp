<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="java.sql.*"%>
<html>
<head>
<title>������û ����� ���� ���� Ȯ��</title></head>
<%
String p_id = request.getParameter("p_id");
String p_pwd = new String(request.getParameter("p_pwd"));
String p_name= new String(request.getParameter("p_name").getBytes("8859_1"), "EUC-KR");
String p_email = new String(request.getParameter("p_email"));
String p_college = new String(request.getParameter("p_college").getBytes("8859_1"), "EUC-KR");
String p_room = new String(request.getParameter("p_room").getBytes("8859_1"), "EUC-KR");
String p_major = new String(request.getParameter("p_major").getBytes("8859_1"), "EUC-KR");

         Connection myConn = null;
         Statement stmt = null;
         String mySQL = ""; 
      
         String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
         String user = "db01";   String passwd = "ss2";
         String dbdriver = "oracle.jdbc.driver.OracleDriver";

 	Class.forName(dbdriver);
 	myConn = DriverManager.getConnection(dburl, user, passwd);
	PreparedStatement pstmt = null;
	stmt = myConn.createStatement();
	 mySQL = "UPDATE professor SET p_pwd=?, p_name=?, p_email=?, p_college=?, p_room=?, p_major=?  WHERE p_id=?";
     
     /*mySQL = mySQL+ "SET s_pwd='" + s_pwd +"',";
     mySQL = mySQL + "s_addr='"+ s_addr + "',";
     mySQL = mySQL + "s_name='"+ s_name + "',";
     mySQL = mySQL + "s_email='"+ s_email + "',";
     mySQL = mySQL + "s_phone='"+ s_phone +"'WHERE s_id='" + s_id + "'";*/
     try {
    	 pstmt = myConn.prepareStatement(mySQL);
    	 pstmt.setString(1, p_pwd);
    	 pstmt.setString(2, p_name);
    	 pstmt.setString(3, p_email);
    	 pstmt.setString(4, p_college);
    	 pstmt.setString(5, p_room);
    	 pstmt.setString(6, p_major);
    	 pstmt.setString(7, p_id);
    	ResultSet rs = pstmt.executeQuery();
    	 
           
  
	//stmt.executeUpdate(mySQL);
%>
<script>
   alert("���������� �����Ǿ����ϴ�." );
   location.href = "professor_update.jsp";
</script>
<%
}
  catch(SQLException ex) {
     	String sMessage;
	if(ex.getErrorCode() == 20008)
		sMessage = "��ȣ�� 4�ڸ� �̻��̾�� �մϴ�.";
	else if(ex.getErrorCode() == 20009)
		sMessage = "��ȣ�� ������ �Էµ��� �ʽ��ϴ�.";
	else
		sMessage = "��� �� �ٽ� �õ��Ͻʽÿ�" ;
%>
<script>
    alert("<%=sMessage%>" );
    location.href = "professor_update.jsp";
</script>
<% }%>

</body>
</html>


         	