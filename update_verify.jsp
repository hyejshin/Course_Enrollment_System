<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html>
<head><title> 수강신청 사용자 정보 수정 </title></head>
<body>
…..
<%
} catch(SQLException ex) {
String sMessage;
if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다";
else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지
않습니다.";
else sMessage="잠시 후 다시 시도하십시오";
%>
…
</body>
</html>