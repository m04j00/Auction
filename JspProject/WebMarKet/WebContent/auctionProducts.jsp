<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<link rel="stylesheet" href="./resources/css/style.css">
<script type="text/javascript" src="./resources/js/timer.js"></script>
<title>상품 목록</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<!-- 전광판 -->
		<div class="container">
			<h1 class="display-3">현재 진행중인 경매</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<%@ include file="dbconn.jsp"%>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "SELECT * FROM product where p_action_end = false";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int i = 0;
				
				while(rs.next()){
					String timeId = "product" + i;
				%>
			<div class="col-md-4 products-div"
				onclick="location.href='./auctionProduct.jsp?id=<%=rs.getString("p_id")%>'">
				<img src="C:/upload/<%=rs.getString("p_file_name")%>"
					class="products-img">
				<h3><%=rs.getString("p_name")%></h3>
				<div class="price-text"><%=rs.getString("p_bid_price") %>원
				</div>
				<span class="products-text">입찰 <%=rs.getString("p_bid_cnt") %></span>
				<span class="products-text">판매 <%=rs.getString("p_seller") %></span>
				<div id=<%=timeId %> class="products-timer"></div>
			</div>

			<script type="text/javascript">
				countDownTimer("<%=timeId %>", "<%=rs.getString("p_time")%>");
			</script>
			<% 
				i++;
				}
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			%>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>