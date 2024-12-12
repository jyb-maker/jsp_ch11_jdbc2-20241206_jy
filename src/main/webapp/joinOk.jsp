<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입성공</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mname = request.getParameter("mname");
		String memail = request.getParameter("memail");		
		String mage = request.getParameter("mage");		
		
		String sql = "b membertbl(memberid,memberpw,membername,memberemail,memberage) VALUES ('"+mid+"','"+mpw+"','"+mname+"','"+memail+"','"+mage+"')";

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jbedu";
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
		Statement stmt = null;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url,username,password);
			stmt = conn.createStatement();
			
			int resultNum = stmt.executeUpdate(sql);
			
			if (resultNum ==1) {
				out.println("회원가입 성공");
			} else {
				out.println("회원가입 실패!!");
			}
		}catch(Exception e) {
			out.println("DB 에러발생 ! 회원가입 실패!!");		
			e.printStackTrace();
		}finally{
			try {
				if(stmt != null) {
					stmt.close();
				}
				if(conn != null){
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
	%>

</body>
</html>