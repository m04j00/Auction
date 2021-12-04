<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("cartId");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("cart.jsp");
		return;
	}
	
	session.invalidate();
	
	response.sendRedirect("cart.jsp");
	//원래 화면으로 복귀
	
%>
