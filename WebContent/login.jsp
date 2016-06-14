<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강신청 로그인</title>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<style>

body {
  background: #ffffff;
  font-family: 'Hanna';
  margin:auto;
}

.login {
  width: 400px;
  margin: auto;
  font-size: 15px;
}

.login-header,
.login p {
  margin-top: 0;
  margin-bottom: 0;
}

.login-triangle {
  width: 0;
  margin-right: auto;
  margin-left: auto;
  border: 12px solid transparent;
  border-bottom-color: #28d;
}

.login-header {
  background: #28d;
  padding: 20px;
  font-size: 1.4em;
  font-weight: normal;
  text-align: center;
  text-transform: uppercase;
  color: #fff;
}

.login-container {
  background: #ebebeb;
  padding: 12px;
}

.login p {
  padding: 10px;
  font-size: 20px;
}

 .login input[type="text"],
.login input[type="password"]{
  box-sizing: border-box;
  width: 100%;
  border-width: 1px;
  border-style: solid;
  padding: 16px;
  outline: 0;
  font-family: inherit;
  font-size: 20px;
}

.login input[type="text"],
.login input[type="password"] {
  background: #fff;
  border-color: #bbb;
  color: #555;
}

.login input[type="text"]:focus,
.login input[type="password"]:focus {
  border-color: #888;
}

.login input[type="submit"]{
  background: #28d;
  border-color: transparent;
  color: #fff;
  cursor: pointer;
  width:45%;
  font-sisze:15px;
   box-sizing: border-box;

  border-width: 1px;
  border-style: solid;
  padding: 16px;
  outline: 0;
  font-family: inherit;
  font-size: 20px;
}

.login input[type="radio"]{
	font-size:13pt;
}
.login input[type="reset"]{
  background: #ffffff;
   box-sizing: border-box;

  border-width: 1px;
  border-style: solid;
  padding: 16px;
  outline: 0;
  font-family: inherit;
  font-size: 20px;
  border-color: black;
  color: #000000;
  cursor: pointer;
  width:45%;
  font-sisze:15px;
}

.login input[type="submit"]:hover {
  background: #17c;
}

.login input[type="submit"]:focus {
  border-color: #05a;
}

</style>
</head>
  <body>
     <br> <br> <br> <br> <br>
  <div class="login">
  <center>&nbsp;&nbsp;<img src="images/snow.jpg" width="45%" height="45%"/></center>
  <div class="login-triangle"></div>
  <h2 class="login-header">Log in</h2>
  <form class="login-container" method="post" action="login_verify.jsp">
  <p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="RADIO" name="access" value="student" checked> 학생&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="RADIO" name="access" value="professor"> 교수</p>
    <p><b>사용자 ID</b><br><input type="text" name="userID"></p>
    <p><b>비 밀 번 호</b><br><input type="password" name="userPassword"></p>
        
   <p><input type="submit" value="로그인">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="다시작성">
    
    
             
             
  </form>
  </div>



</body>
</html>
