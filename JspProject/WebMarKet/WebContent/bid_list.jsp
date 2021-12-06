<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">

<link rel="stylesheet" href="./resources/css/style.css">
</head>
<%
String cartId = session.getId();
%>
<body>
	<script type="text/javascript">
		function successfulBid(date){
			
			let pDate = new Date(date);
			let ndate = new Date();
			console.log(pDate);
			console.log(ndate);
			console.log(pDate < ndate);
			const tf = pDate < ndate;
			if(tf) return true;
			return false;
		}
		</script>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">입찰 목록</h1>
		</div>
	</div>
	<div style="padding-top: 50px">
		<%@ include file="dbconn.jsp"%>
		<table class="table table-hover">
			<tr>
				<th>상품</th>
				<th>가격</th>
				<th>입찰 여부</th>
				<th>비고</th>
				<th></th>
			</tr>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "SELECT * FROM bid_list where b_buyer = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "admin");
				rs = pstmt.executeQuery();
				String bid = "";
				int sum = 0;
				int i = 0;
				while(rs.next()){
					System.out.println(rs.getString("b_bid_state"));
					String s = rs.getString("b_bid_state");
					String t = "true";
					String bigo = "";
					if(s.equals(t)) {
						bid = "최고 입찰가";
						sum += rs.getInt("p_bid_price");
					}
					else bid = "입찰 불가";
				%>
			<tr
				onclick="location.href='./product.jsp?id=<%=rs.getString("p_id")%>'"
				style="cursor: pointer">
				<td><%=rs.getString("p_id")%> - <%=rs.getString("p_name")%></td>
				<td><%=rs.getString("p_bid_price")%></td>
				<td><%=bid %></td>
				<td style="color: red;" id="sf<%=i%>"><%=bigo%></td>
				<td></td>
			</tr>
			<%
			if(s.equals(t)) {
				PreparedStatement pstmt2 = null;
				ResultSet rs2 = null;
				String sql2 = "select b.b_id, b.p_bid_price, p.p_time FROM bid_list b INNER JOIN product p on p.p_id = b.p_id where b.b_bid_state = ? AND p.p_id = ? AND b.b_buyer = ?";
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, "true");
				pstmt2.setString(2, rs.getString("p_id"));
				pstmt2.setString(3, "admin");
				rs2 = pstmt2.executeQuery();
				while(rs2.next()){
					%>
					<script type="text/javascript">
						const sb = successfulBid('<%=rs2.getString("p_time") %>');
						console.log(sb);
						if(!sb) {
							document.getElementById("sf<%=i%>").innerHTML = "낙찰, 결제 필요";
						}
					</script>
			<%
				}
			
				}
			i++;
				}
				%>
			<tr>
				<th></th>
				<th>총액</th>
				<th><%=sum %></th>
				<th></th>
				<th></th>
			</tr>
		</table>
		
	</div>
<div style="margin: 0px 50px 50px 50px;">
<a href="./auctionProducts.jsp" class="btn btn-secondary">&laquo;쇼핑 계속하기</a>
		<a href="./auctionShippingInfo.jsp?cartId=<%=cartId%>" class="btn btn-info" style="float:right;" id="sfButn">낙찰 결제하기&raquo;</a>
</div>
</body>
</html>