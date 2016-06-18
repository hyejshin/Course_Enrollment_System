<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=EUC-KR"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link
	href="https://fonts.googleapis.com/css?family=Chelsea+Market|Londrina+Sketch"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<link rel="stylesheet" type="text/css" href="mainstyle.css">
</head>
<body>
	<div id="total">
		<div id="templatemo_header">
			<div id="site_title">
				<h2 id="yoyo">
					&nbsp;&nbsp;<img src="images/snow.jpg" width="45px" height="45px" />숙명여자대학교
					수강신청
					</h3>
			</div>
			<%@ include file="top.jsp"%>
		</div>
		<div id="intro">
		<% if (session_id!= null) { %>
		<%=session_name%>님방문을환영합니다.
		<% } else { %>
		로그인한후사용하세요.
		<%}%></div>
		<center>
			<div id="templatemo_main">
				<div id="content">
					<div id="home" class="section">
						<br></br>
						<div id="home_about" class="box">
							<h2 id="roro">WELCOME Sookmyung :)</h2>
							<p>
								sookmyung university is the best women university nd it can be
								used for any purpose. Validate <a
									href="http://validator.w3.org/check?uri=referer" rel="nofollow"><strong>XHTML</strong></a>
								&amp; <a href="http://jigsaw.w3.org/css-validator/check/referer"
									rel="nofollow"><strong>CSS</strong></a>. Lorem ipsum dolor sit
								amet, consectetur adipiscing elit. Phasellus felis leo, feugiat
								sed porttitor sagittis, facilisis sit amet lectus. Aenean
								elementum tellus auctor dolor auctor luctus. Vivamus eu orci
								purus, ut vulputate nisl Praesent imperdiet mauris et lorem
								malesuada consequat. Proin nisl metus, faucibus vitae malesuada
								non, interdum sed felis. Sed ut turpis feugiat lorem faucibus
								dignissim. Donec magna tellus, feugiat vel fermentum eget,
								fringilla at metus.
							</p>
						</div>

						<div id="home_gallery" class="box no_mr">
							<a href="images/gallery/01.jpg"><img
								src="images/gallery/02.jpg" alt="image 1" /></a> <a
								href="images/gallery/02.jpg"><img src="images/down.jpg"
								alt="image 2" /></a> <a href="images/gallery/03.jpg"><img
								src="images/gallery/03.jpg" alt="image 3" /></a> <a
								href="images/gallery/04.jpg"><img
								src="images/gallery/04.jpg" height="134px" alt="image 4" /></a> <a
								href="images/gallery/05.jpg"><img
								src="images/gallery/05.jpg" alt="image 5" /></a>
						</div>

						<div></div>
						<!-- END of home -->


					</div>
				</div>
			</div>
		</center>
		<div id="templatemo_footer">
			Copyright 2072 <a href="http://www.sookmyung.ac.kr">숙명여자대학교</a>
		</div>
	</div>
</body>
</html>