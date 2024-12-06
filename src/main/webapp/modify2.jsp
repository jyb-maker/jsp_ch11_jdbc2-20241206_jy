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
<title>회원 정보 수정</title>
</head>
<body>
	<h2>회원 정보 수정</h2>
	<hr>
	<%
		request.setCharacterEncoding("utf-8");
		String modfiyid = request.getParameter("mid");//수정할 아이디 가져오기
		
		String sql ="SELECT * FROM membertbl WHERE memberid=?";
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jbedu";
		String username = "root";
		String password = "12345";
		
		Connection conn = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;//select 문 사용시 DB에서 반환하는 결과를 받아줄 객체 선언
		MemberDto memberDto = new MemberDto();//빈 memberDto 객체 선언
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, modfiyid);//sql문의 ? 값으로 modifyid 설정
			
			rs = pstmt.executeQuery();
			
			//List<MemberDto> memberDtos = new ArrayList<MemberDto>(); 
			
			while(rs.next()) {//레코드의 갯수만큼 반복
				String mid = rs.getString("memberid");//DB의 필드명으로 추출
				String mpw = rs.getString("memberpw");
				String mname = rs.getString("membername");
				String memail = rs.getString("memberemail");
				int mage = rs.getInt("memberage");//나이->int
				
				memberDto.setMemberid(mid);
				memberDto.setMemberpw(mpw);
				memberDto.setMembername(mname);
				memberDto.setMemberemail(memail);
				memberDto.setMemberage(mage);
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
	
	<form action="modifyOk.jsp">
		<input type="hidden" name="mid" value="<%= memberDto.getMemberid() %>">
		아이디 : <input type="text" value="<%= memberDto.getMemberid() %>" disabled="disabled"><br><br>
		비밀번호 : <input type="text" name="mpw" value="<%= memberDto.getMemberpw() %>"><br><br>
		이름 : <input type="text" name="mname" value="<%= memberDto.getMembername() %>"><br><br>
		이메일 : <input type="text" name="memail" value="<%= memberDto.getMemberemail() %>"><br><br>
		나이 : <input type="text" name="mage" value="<%= memberDto.getMemberage() %>"><br><br>
		<input type="submit" value="정보수정">
	
	</form>
	
</body>
</html>