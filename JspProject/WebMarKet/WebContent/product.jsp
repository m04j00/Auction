<%@page import="dao.ProductRepository"%>
<%@ page import="java.sql.*"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<jsp:useBean id="productDAO" class="dao.ProductRepository"
	scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">

<link rel="stylesheet" href="./resources/css/style.css">
<script type="text/javascript" src="./resources/js/timer.js"></script>
<title>상품 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<%@ include file="dbconn.jsp"%>
	<%
	String id = request.getParameter("id");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM product WHERE p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	while (rs.next()) {
	%>
	<div class="jumbotron product-title-jumbotron product-body">
		<div class="container" style="margin-bottom: 10px">
			<span class="display-3 product-title"><%=rs.getString("p_name")%></span>
			<span id="productTimer" class="product-timer"></span>
		</div>
	</div>
	<div class="container product-body">
		<div class="row">
			<div class="col-md-5" style="text-align: center; margin: 0px 30px;">
				<img src="C:/upload/<%=rs.getString("p_file_name")%>"
					class="product-img">
			</div>

			<div class="col-md-6">
				<h3>
					판매가
					<%=rs.getString("p_sell_price")%>원
				</h3>

				<p>
					<b>물품 번호 </b><span class="badge badge-danger"><%=rs.getString("p_id")%></span>
				<p>
				<p>
					<b>판매자 </b>
					<%=rs.getString("p_seller")%>
				<p>
				<form name="addForm"
					action="./addCart.jsp?id=<%=id%>" method="post">
					<a href="#" class="btn btn-info" onclick="addToCart()"> 상품주문 &raquo;</a> 
					<a href="./cart.jsp" class="btn btn-warning">장바구니 &raquo;</a> 
					<a href="./products.jsp" class="btn btn-secondary">상품목록 &raquo;</a>
				</form>
			</div>
		</div>
		<p class="product-desc-title">물품 설명</p>
		<div class="product-desc-body">
			<p class="product-desc"><%=rs.getString("p_description")%></p>
		</div>
	</div>
	<%
	}
	if (rs != null)
	rs.close();
	if (pstmt != null)
	pstmt.close();
	if (conn != null)
	conn.close();
	%>
	<%@ include file="footer.jsp"%>
	
	<script type="text/javascript">
	function addToCart() {
		if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit();
		} else {
			document.addForm.reset();
		}
	}
</script>
</body>
</html>