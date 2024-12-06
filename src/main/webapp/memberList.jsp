<%@page import="java.util.ArrayList"%>
<%@page import="com.jbedu.member.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
</head>
<body>
	<h2>전체 회원 리스트</h2>
	<hr>
	<%		
		
		String sql ="SELECt * FROM membertbl";
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jbedu";
		String username = "root";
		String password = "12345";
		
		Connection conn = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;//select 문 사용시 DB에서 반환하는 결과를 받아줄 객체 선언
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<MemberDto> memberDtos = new ArrayList<MemberDto>(); 
			
			while(rs.next()) {//레코드의 갯수만큼 반복
				String mid = rs.getString("memberid");//DB의 필드명으로 추출
				String mpw = rs.getString("memberpw");
				String mname = rs.getString("membername");
				String memail = rs.getString("memberemail");
				int mage = rs.getInt("memberage");//나이->int
				
				MemberDto memberDto = new MemberDto(mid, mpw, mname, memail, mage);//필드 생성자 호출로 초기화
				
				memberDtos.add(memberDto);
			}
			
			for(MemberDto member : memberDtos){//향상된 for문
				out.println(member.getMemberid() + "/");//아이디
				out.println(member.getMembername() + "/");//이름
				out.println(member.getMemberemail() + "/");//이메일
				out.println(member.getMemberage() + "<br>");//나이
				
			}
				
			
		}catch(Exception e){
			out.println("DB 에러 발생! 회원 리스트 조회 실패!!");
			e.printStackTrace();
		}finally{
			try{
				if(rs != null) {
					rs.close();
				}
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
</body>
</html>