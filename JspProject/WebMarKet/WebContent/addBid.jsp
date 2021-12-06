<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String price = request.getParameter("price");
	System.out.println(price);
	System.out.println(id);
	
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM product WHERE p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	while (rs.next()) {
		
		sql = "insert into bid_list(p_id, p_name, p_bid_price, b_bid_state, b_buyer) values(?, ?, ?, 'true', 'admin')";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, rs.getString("p_id"));
		pstmt.setString(2, rs.getString("p_name"));
		pstmt.setString(3, price);
		pstmt.executeUpdate();
		int cnt = rs.getInt("p_bid_cnt");
		cnt++;
		sql = "UPDATE product SET p_bid_price = ?, p_bid_cnt = ? WHERE p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.valueOf(price));
		pstmt.setInt(2, cnt);
		pstmt.setInt(3, Integer.valueOf(id));
		pstmt.executeUpdate();
		
		sql = "UPDATE bid_list SET b_bid_state = 'false' WHERE p_id = ? AND p_bid_price != ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.valueOf(id));
		pstmt.setInt(2, Integer.valueOf(price));
		pstmt.executeUpdate();
		
	}

	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	response.sendRedirect("bid_list.jsp");
	//원래 화면으로 복귀
	
%>
