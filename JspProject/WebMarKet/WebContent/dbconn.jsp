<%@ page import="java.sql.*" %>

<%
	Connection conn = null;

	try{
		String url = "jdbc:mysql://localhost:3306/auction_db?serverTimezone=Asia/Seoul&useSSL=false";
		String user = "root";
		String password = "0620";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
	}catch(SQLException e){
		out.println("데이터베이스 연결이 실패했습니다.<br>");
		out.println("SQLException : " + e.getMessage());
	}
%>