<%@page import="step01_boardEx.BoardDAO"%>
<%@page import="step01_boardEx.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bWritePro</title>
</head>
<body>
	
	<% 
		/*
			(인코딩)데이터를 받는다.
			DTO형태로 만든다.
			DAO객체로 DTO를 보낸다.
			리액션~!
		*/
		
		request.setCharacterEncoding("utf-8");
	
		BoardDTO boardDTO = new BoardDTO();
		//boardDTO.writer = request.getParameter("writer");
	
		boardDTO.setWriter(request.getParameter("writer"));
		boardDTO.setSubject(request.getParameter("subject"));
		boardDTO.setEmail(request.getParameter("email"));
		boardDTO.setPassword(request.getParameter("password"));
		boardDTO.setContent(request.getParameter("content"));
		
		BoardDAO.getInstance().insertBoard(boardDTO);
	
	%>
	
	<script>
		alert("게시글이 되었습니다.");
		// location.href = "url"; > url로 페이지를 이동한다.
		location.href = "bList.jsp";
	</script>


</body>
</html>