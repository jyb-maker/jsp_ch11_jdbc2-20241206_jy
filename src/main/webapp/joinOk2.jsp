<%@page import="java.sql.PreparedStatement"%>
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
		int mage = Integer.parseInt(request.getParameter("mage"));		
		//String mage = request.getParameter("mage");			
		
		String sql = "INSERT INTO membertbl(memberid,memberpw,membername,memberemail,memberage) VALUES (?,?,?,?,?)";  // 5개 개수만큼 물음표를 작성

		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jbedu";
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
//		Statement stmt = null;
		PreparedStatement pstmt = null;		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url,username,password);
 			//stmt = conn.createStatement();		
			pstmt = conn.prepareStatement(sql);
 		    //int resultNum = stmt.executeUpdate(sql);
 		    pstmt.setString(1, mid); // sql문 내의 첫번째 ?에 mid를 세팅 
 		    pstmt.setString(2, mpw);
 		    pstmt.setString(3, mname);
 		    pstmt.setString(4, memail);
 		    pstmt.setInt(5, mage); 		    
 		    //pstmt.setString(5, mage); 
 		    
 			int resultNum = pstmt.executeUpdate(); //성공하면 1반환 
 			
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
				if(pstmt != null) {
				   pstmt.close();
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