<%@page import="step01_boardEx.BoardDAO"%>
<%@page import="step01_boardEx.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bAuthenticationPro</title>
</head>
<body>

	<%
		/*
			주는건 받는다.(id, password, menu)
			dto로 만든다.
			DAO로 보내서 select를 해보고 결과를 받는다.(boolean)
			
			if (인증이 되면) {
				if (업데이트면) {
					업데이트화면으로 이동
				}
				else if (삭제면) {
					삭제화면으로 이동
				}
			}
			else {
				다시 뒤로 이동
			}
		*/
		
		request.setCharacterEncoding("utf-8");
		
		long boardId    = Long.parseLong(request.getParameter("boardId"));
		String password = request.getParameter("password");
		String menu     = request.getParameter("menu");
	
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoardId(boardId);
		boardDTO.setPassword(password);
		
//		if (BoardDAO.getInstance().checkAuthorizedUser(boardDTO)) {}
		boolean isAuthorizedUser = BoardDAO.getInstance().checkAuthorizedUser(boardDTO);
		if (isAuthorizedUser) {
			
			if (menu.equals("update")) {
				// 업데이트화면으로 이동
	%>
				<script>
					location.href = "bUpdate.jsp?boardId=" + <%=boardId%>;
				</script>
	<%
			}
			else if (menu.equals("delete")) {
				// 삭제화면으로 이동
			}
			
		}
		else {
	%>
			<script>
				alert("잘못된 패스워드 입니다.");
				history.go(-1);  // 한 페이지 뒤로가기
				//history.back();  // 한 페이지 뒤로가기
				//history.go(-3);  // 세 페이지 뒤로가기
			</script>
	<%		
		}
	%>
</body>
</html>