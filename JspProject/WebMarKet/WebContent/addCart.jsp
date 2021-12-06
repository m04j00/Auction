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
	System.out.println(id);
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
	ArrayList<Product> goodsList = dao.getAllProducts();
	Product goods = product;
	
	for(int i = 0; i < goodsList.size(); i++){
		goods = goodsList.get(i);
		if(goods.getProductId().equals(id)){
			break;
		}
	}
	
	ArrayList<Product> list = (ArrayList<Product>)session.getAttribute("cartlist");
	if(list == null){ //장바구니 목록 세션
		//웹 브라우저 끄기 전까지 목록은 그대로 남아있음. 
		//새로 저장한건지 아닌지 확인해야함.
		//장바구니가 존재하지 않을경우 새로 만들기.
		list = new ArrayList<Product>();
		session.setAttribute("cartlist", list);
	}
	
	int cnt = 0;
	Product goodsQnt = new Product();
	for(int i = 0; i < list.size(); i++){
		goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)){
			cnt++; // 주문 상품 개수 증가 
			int orderQuantity = goodsQnt.getQuantity() + 1;
			// 주문 상품 시작 1로 맞추기 
			goodsQnt.setQuantity(orderQuantity);
		}
	}
	
	if(cnt == 0	){
		goods.setQuantity(1);
		list.add(goods);
	}// 장바구니 안에 없는 상품일 경우 값을 1로 하여 추가
	
	response.sendRedirect("product.jsp?id=" + id);
	//원래 화면으로 복귀
	
%>
