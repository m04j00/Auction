<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.*" %>
<%@include file="dbconn.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String filename = "";
	String realFolder = "C:\\upload";	//웹 애플리케이션상의 절대 경로 //파일명이 너무 길면 파일을 못 찾는다.
	int maxSize = 5 * 1024 * 1024;		//한번에 올릴수 있는 최대 업로드될 최대 용량 5MB
	String encType = "UTF-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	//new DefaultFileRenamePolicy() 같은 이름의 파일이 있을 경우 어떻게 할것인지 -> 파일이름이 바뀜 p1, p2, p3...
	//원래는 request로 처리, 만약 파일 중복과 같은 값을 처리해야한다면 request뒤의 내용들로 처리
	//파일 저장용도
	
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String menufacturer = multi.getParameter("menufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
		
	Integer price;
	if(unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(unitPrice);
	
	long stock;
	if(unitsInStock.isEmpty())
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);
	
	Enumeration files = multi.getFileNames();	//Enumeration files에 파일을 담는다.
	//파일을 list형태로 files에 담음
	String fname = (String)files.nextElement(); //files에 있는 파일의 이름을 가져온다.
	String fileName = multi.getFilesystemName(fname); //서버에 실제 저장된 파일이름(원 파일 명)을 가져옴 -> 이후 중복되면 파일명 바꿈
	
	PreparedStatement pstmt = null;
	String sql = "insert into product values(?, ?, ?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	pstmt.setString(2, name);
	pstmt.setInt(3, price);
	pstmt.setString(4, description);
	pstmt.setString(5, category);
	pstmt.setString(6, menufacturer);
	pstmt.setLong(7, stock);
	pstmt.setString(8, condition);
	pstmt.setString(9, fileName);
	pstmt.executeUpdate();
	
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();

	response.sendRedirect("products.jsp");
%>
