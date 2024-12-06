<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jbedu.member.dto.MemberDto"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 성공</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mname = request.getParameter("mname");
		String memail = request.getParameter("memail");
		//int mage = Integer.parseInt(request.getParameter("mage"));//mage값을 int로 저장
		String mage = request.getParameter("mage");//mage값을 문자열로 저장
		
		String sql ="UPDATE membertbl SET memberpw=?,membername=?,memberemail=?,memberage=? WHERE memberid=?";
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jbedu";
		String username = "root";
		String password = "12345";
		
		Connection conn = null;		
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mpw);
			pstmt.setString(2, mname);
			pstmt.setString(3, memail);			
			pstmt.setString(4, mage);
			pstmt.setString(5, mid);
			
			int resultNum = pstmt.executeUpdate();//성공하면 1 반환
			
			if(resultNum == 1) {
				out.println("회원 수정 성공!!");
			} else {
				out.println("회원 수정 실패!!");
			}
		}catch(Exception e){
			out.println("DB 에러 발생! 회원 수정 실패!!");
			e.printStackTrace();
		}finally{
			try{
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	
	
	%>
	
	<h2>회원 정보 수정</h2>
	<hr>
	<%
		
		
		String sql1 ="SELECT * FROM membertbl WHERE memberid=?";
		
		
		Connection conn1 = null;		
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;//select 문 사용시 DB에서 반환하는 결과를 받아줄 객체 선언
		MemberDto memberDto = new MemberDto();//빈 memberDto 객체 선언
		
		try {
			Class.forName(driverName);
			conn1 = DriverManager.getConnection(url, username, password);			
			pstmt1 = conn1.prepareStatement(sql1);
			
			pstmt1.setString(1, mid);//sql문의 ? 값으로 modifyid 설정
			
			rs = pstmt1.executeQuery();
			
			//List<MemberDto> memberDtos = new ArrayList<MemberDto>(); 
			
			while(rs.next()) {//레코드의 갯수만큼 반복
				String mid1 = rs.getString("memberid");//DB의 필드명으로 추출
				String mpw1 = rs.getString("memberpw");
				String mname1 = rs.getString("membername");
				String memail1 = rs.getString("memberemail");
				int mage1 = rs.getInt("memberage");//나이->int
				
				memberDto.setMemberid(mid1);
				memberDto.setMemberpw(mpw1);
				memberDto.setMembername(mname1);
				memberDto.setMemberemail(memail1);
				memberDto.setMemberage(mage1);
			}
			
		}catch(Exception e){
			out.println("DB 에러 발생! 회원 정보 조회 실패!!"+"<br><br>");
			e.printStackTrace();
		}finally{
			try{
				if(rs != null) {
					rs.close();
				}
				if(pstmt1 != null) {
					pstmt1.close();
				}
				if(conn1 != null) {
					conn1.close();
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	
	%>
	
	아이디 : <%= memberDto.getMemberid() %><br><br>
	비밀번호 : <%= memberDto.getMemberpw() %><br><br>
	이름 : <%= memberDto.getMembername() %><br><br>
	이메일 : <%= memberDto.getMemberemail() %><br><br>
	나이 : <%= memberDto.getMemberage() %><br><br>
	
	
</body>
</html>