<%@ page import="java.sql.*"%>
<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String cartId = session.getId();
String shipping_cartId = "";
String shipping_name = "";
String shipping_shippingDate = "";
String shipping_country = "";
String shipping_zipCode = "";
String shipping_addressName = "";

Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if (n.equals("Shipping_cartId"))
			shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		if (n.equals("Shipping_name"))
			shipping_name = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		if (n.equals("Shipping_shippingDate"))
			shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		if (n.equals("Shipping_country"))
			shipping_country = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		if (n.equals("Shipping_zipCode"))
			shipping_zipCode = URLDecoder.decode((thisCookie.getValue()), "utf-8");
		if (n.equals("Shipping_addressName"))
			shipping_addressName = URLDecoder.decode((thisCookie.getValue()), "utf-8");

	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>주문 정보</title>
</head>
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
	<jsp:include page="menu.jsp"/>
	<%@ include file="dbconn.jsp"%>
	<div class="jumbotron">
		<div class="container">
			<h1 class="diplay-3">주문 정보</h1>
		</div>
	</div>

	<div class="container col-8 alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 주소</strong><br> 성명 :
				<%
				out.println(shipping_name);
				%><br> 우편번호 :
				<%
				out.println(shipping_zipCode);
				%><br> 주소 :
				<%
				out.println(shipping_addressName);
				%>
				(
				<%
				out.println(shipping_country);
				%>)<br>
			</div>
			<div class="col-4" align="right">
				<p>
					<em>배송일 : <%
					out.println(shipping_shippingDate);
					%></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">
				<tr>
					<th class="text-center">제품</th>
					<th class="text-center">#</th>
					<th class="text-center">가격</th>
					<th class="text-center">소계</th>
				</tr>
				<%
				int sum = 0;
				int i = 0;
				int id = 0;
				PreparedStatement pstmt2 = null;
				ResultSet rs2 = null;
				String sql2 = "select b.p_id, b.p_name, b.p_bid_price, p.p_time FROM bid_list b INNER JOIN product p on p.p_id = b.p_id where b.b_bid_state = ? AND b.b_buyer = ?";
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, "true");
				pstmt2.setString(2, "admin");
				rs2 = pstmt2.executeQuery();
				while(rs2.next()){
					%>
					<tr>
						<td class="text-center"><em id="pName<%=i%>"></em></td>
						<td class="text-center"><em ></em></td>
						<td class="text-center"><em id="pPrice<%=i%>"></em></td>
						<td class="text-center"><em></em></td>
					</tr>
					<script type="text/javascript">
						const sb = successfulBid('<%=rs2.getString("p_time") %>');
						console.log(sb);
						if(!sb) {
							document.getElementById("pName<%=i%>").innerHTML = '<%=rs2.getString("p_name")%>';
							document.getElementById("pPrice<%=i%>").innerHTML = '<%=rs2.getString("p_bid_price")%>';
						}
					</script>
					<%
					i++;
					id = rs2.getInt("p_id");
					sum += rs2.getInt("p_bid_price");
					
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = "DELETE FROM product WHERE p_id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, id);
					System.out.println(pstmt);
					pstmt.executeUpdate();
					pstmt = null;
					rs = null;
					sql = "DELETE FROM bid_list WHERE p_id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, id);
					pstmt.executeUpdate();
					pstmt = null;
					rs = null;
				}
				
				
				%>
				<tr>
					<td></td>
					<td></td>
					<td class="text-right"><strong>총액 : </strong></td>
					<td class="text-center text-danger"><strong><%=sum%></strong></td>
			</table>
			<a href="./shippingInfo.jsp?cartId=<%=shipping_cartId%>"
				class="btn btn-secondary" role="button">이전</a> <a
				href="./thankCustomer.jsp?id=" class="btn btn-success" role="button">주문
				완료</a> <a href="./checkOutCancelled.jsp" class="btn btn-secondary"
				role="button">취소</a>
		</div>
	</div>

</body>
</html>