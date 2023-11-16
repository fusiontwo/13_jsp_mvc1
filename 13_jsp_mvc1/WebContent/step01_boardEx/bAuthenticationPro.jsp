<%@page import="step01_boardEx.BoardDAO"%>
<%@page import="step01_boardEx.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bAuthenticationPro</title>
</head>
<body>
	
	<% 
	
		request.setCharacterEncoding("utf-8");
		
		long boardId    = Long.parseLong(request.getParameter("boardId"));
		String password = request.getParameter("password");
		String menu     = request.getParameter("menu");
		
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoardId(boardId);
		boardDTO.setPassword(password);
		
		//if (BoardDAO.getInstance().checkAuthorizedUser(boardDTO)){}
		
		boolean isAuthorizedUser = BoardDAO.getInstance().checkAuthorizedUser(boardDTO);		
		if (isAuthorizedUser) {
			
			if (menu.equals("update")) {
	%>
				<script>
					location.href = "bUpdate.jsp?boardId=" + <%=boardId%> ;
				</script>
	<% 			
			}
			else if (menu.equals("delete")) {
	%>
				<script>
					location.href = "bDelete.jsp?boardId=" + <%=boardId%>
				</script>
	<% 
			}
			
		}
		else {
	%>
			<script>
				alert("잘못된 패스워드 입니다.");
				history.go(-1);   // 한 페이지 뒤로가기
				//history.back(); // 한 페이지 뒤로가기
				//history.go(-3); // 세 페이지 뒤로가기
				
			</script>	
	<% 		
		}
	%>
	



</body>
</html>