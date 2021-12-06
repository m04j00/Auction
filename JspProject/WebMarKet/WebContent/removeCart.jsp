<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="dbconn.jsp"%>
<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}
	
	ProductRepository dao = ProductRepository.getInstance();
	Product product = new Product();
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM product WHERE p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	while (rs.next()) {
		product.setProductId(id);
		product.setPname(rs.getString("p_name"));
		product.setDescription(rs.getString("p_description"));
		product.setFileName(rs.getString("p_file_name"));
		product.setQuantity(1);
		product.setUnitPrice(rs.getInt("p_sell_price"));
	}
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	
	
	if(product == null){
		response.sendRedirect("exceptionNoProductId.jsp");
	}

	ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
	
	Product goodsQnt = product;
	for(int i = 0; i < cartList.size(); i++){
		goodsQnt = cartList.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cartList.remove(goodsQnt);
		}
	}
	
	
	response.sendRedirect("cart.jsp");
	//원래 화면으로 복귀
	
%>
