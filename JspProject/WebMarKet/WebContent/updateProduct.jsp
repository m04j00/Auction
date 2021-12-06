<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<title>상품 수정</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>
	<%@include file="dbconn.jsp"%>
	<%
	String productId = request.getParameter("id");
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String sql = "SELECT * FROM product where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	if (rs.next()) {
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="c:/upload/<%=rs.getString("p_file_name")%>"
					style="width: 100%" alt="image">
			</div>
			<div class="col-md-7">
				<form name="newProduct" action="./processUpdateProduct.jsp?id=<%=productId%>"
					class="form-horizontal" method="post" enctype="multipart/form-data">
									<div class="form-group row">
					<label class="col-sm-2" style="padding-right: 0;">상품명</label>
					<div class="col-sm-3">
						<input type = "text" id="name" name ="name" class = "form-control" style="width: 200px;">
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2" style="padding-right: 0;">상세정보</label>
					<div class="col-sm-3">
						<textarea name = "description" rows="2" cols="50" class = "form-control" style="width: 200px;"></textarea>
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2" style="padding-right: 0;">판매가</label>
					<div class="col-sm-3">
						<input type = "text" name ="sellPrice" class = "form-control" style="width: 200px;">
					
						</div>
						
				</div>
				<div class = "form-group row">
					<label class = "col-sm-2" style="padding-right: 0;">이미지</label>
					<div class = "col-sm-5">
						<input type = "file" name = "productImage" class = "form-control">
					</div>
				</div>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" value="등록">
						</div>
					</div>
				</form>
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
		<hr>
		<jsp:include page="footer.jsp" />
</body>
</html>