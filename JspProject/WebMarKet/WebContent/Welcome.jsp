<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>Welcome</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<%!
		String greeting = "물품 경매 사이트";
		String tagline = "물품을 등록하고 경매를 통해 물품을 판매하세요. 물품이 낙찰되지 않아도 사이트 내에서 판매할 수 있습니다.";
	%>
	<div class="jumbotron"> <!-- 전광판 -->
		<div class="container" style="text-align:center;">
			<h1 class="display-3" ><%= greeting %></h1>
		</div>
	</div>
	<main role="main">
		<div class = "container">
			<div class="text-center">
				<h6><%= tagline %></h3>
			</div>
			<hr> <!-- 실선 -->
			
		</div>
	</main>
	<%@ include file = "footer.jsp" %>
	
<%-- 	
	<h1> <%= greeting %></h1>
	<h3> <%= tagline %></h3> 
--%>
</body>
</html>