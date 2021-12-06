<%@page import="dto.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
		<script type="text/javascript" src="./resources/js/validation2.js"></script>
		<title>상품 등록</title>
	</head>
	<body>
		<jsp:include page="menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">물품 등록</h1>
			</div>
		</div>

		<div class = "container">
			<form name = "newProduct" action="./processAddProduct.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
<!-- 				<div class="form-group row">
					<label class="col-sm-2">상품 코드</label>
					<div class="col-sm-3">
						<input type = "text" id="productId" name ="productId" class = "form-control">
					</div>
				</div> -->
				<div class="form-group row">
					<label class="col-sm-2">상품명</label>
					<div class="col-sm-3">
						<input type = "text" id="name" name ="name" class = "form-control">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">시작가</label>
					<div class="col-sm-3">
						<input type = "text" id="startPrice" name ="startPrice" class = "form-control">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">상세정보</label>
					<div class="col-sm-3">
						<textarea name = "description" rows="2" cols="50" class = "form-control"></textarea>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">입찰 단위</label>
					<div class="col-sm-3">
						<input type = "text" name ="unit" class = "form-control">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">판매가</label>
					<div class="col-sm-3">
						<input type = "text" name ="sellPrice" class = "form-control">
						<p style="width:1000px">낙찰자가 없을 경우 해당 금액으로 사이트에서 물건을 판매할 수 있습니다. 판매를 원치 않을 경우 공란으로 남겨주세요.</p>
					
						</div>
						
				</div>
				<div class = "form-group row">
					<label class = "col-sm-2">이미지</label>
					<div class = "col-sm-5">
						<input type = "file" name = "productImage" class = "form-control">
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type = "button" class = "btn btn-primary" 
						value = "등록" onclick="CheckAddProduct()">
					</div>
				</div>
			</form>
		</div>
		<%@ include file = "footer.jsp" %>
	</body>
</html>