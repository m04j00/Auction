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
	<script type="text/javascript">
		countDownTimer("productTimer", "<%=rs.getString("p_time")%>", 1);
	</script>
	<div class="container product-body">
		<div class="row">
			<div class="col-md-5" style="text-align: center; margin: 0px 30px;">
				<img src="C:/upload/<%=rs.getString("p_file_name")%>"
					class="product-img">
			</div>

			<div class="col-md-6">
				<h3>
					현재가
					<%=rs.getString("p_bid_price")%>원
				</h3>

				<p>
					<b>물품 번호 </b><span class="badge badge-danger"><%=rs.getString("p_id")%></span>
				<p>
				<p>
					<b>경매 기간 </b> ~
					<%=rs.getString("p_time")%></p>
				<p>
					<b>시작가 </b>
					<%=rs.getString("p_start_price")%>
				<p>
				<p>
					<b>입찰 단위 </b>
					<%=rs.getString("p_bid_unit")%>
				<p>
				<p>
					<b>입찰 수 </b>
					<%=rs.getString("p_bid_cnt")%>
				<p>
				<form name="addForm"
					action="./addCart.jsp?id=<%=rs.getString("p_id")%>" method="post">
					<a href="#" class="btn btn-info" onclick="bid()"> 입찰하기 &raquo;</a> 
					<a href="./auctionProducts.jsp" class="btn btn-secondary">상품목록
						&raquo;</a>
				</form>
			</div>
		</div>
		<p class="product-desc-title">물품 설명</p>
		<div class="product-desc-body">
			<p class="product-desc"><%=rs.getString("p_description")%></p>
		</div>
		<div class="modal">
			<div class="popup">
				<div class="popup-content">
					<p>현재 입찰가 : <%=rs.getString("p_bid_price")%>
					<p>입찰 단위 : <%=rs.getString("p_bid_unit")%>
				</div>
				<form name="formform" action="./addBid.jsp" method="get" id="formform">
					<div class="form-group row" style="margin: 50px 130px;" >
						<p style="margin-top: 5px;">입찰 금액</p>
						<div class="col-sm-3" >
							<input type="text" id="price" name="price" class="form-control" style="width:100px;">
							<input type="text" id="id" name="id" class="form-control" style="width:100px;display:none;" value="<%=id%>">
						</div>
					</div>
					<div class="popup-btn">
						<input type="button" class="btn btn-info" onclick="addToCart('<%=rs.getString("p_bid_unit")%>', '<%=rs.getString("p_bid_price")%>')" value="입찰">
						<a class="btn btn-secondary" href="#" onclick="bid()">취소</a>
					</div>
				</form>
				
				
			</div>
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
	function addToCart(unit, bid) {
		
		const price = document.getElementById('price').value;
		console.log(price);
		if(price % unit != 0){
			alert(`입찰 단위가 맞지 않습니다. 입찰 단위 : \${unit}`);
			return false;
		}
		else if((Number)(price) <= (Number)(bid)){
			alert(`현재 입찰가보다 낮은 가격을 입력했습니다. 현재 입찰가 : \${bid}`);
			return false;
		}
		if (confirm("입찰 시 취소할 수 없습니다. 입찰하시겠습니까?")) {
			document.formform.submit();
		} else {
			return false;
		}
	}
	function bid(){
		const popup = document.querySelector('.modal');

	    popup.classList.toggle('show-modal');
	}
</script>
</body>
</html>