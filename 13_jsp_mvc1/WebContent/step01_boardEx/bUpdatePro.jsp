<%@page import="step01_boardEx.BoardDAO"%>
<%@page import="step01_boardEx.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bUpdatePro</title>
</head>
<body>

	<% 
		/*
			일단 주는건 받자!
			DTO로 만들어서 DAO로 보내자! > update쿼리
			리액션~!
		*/
		
		request.setCharacterEncoding("utf-8");
		 
		BoardDTO boardDTO = new BoardDTO();	
		boardDTO.setBoardId(Long.parseLong(request.getParameter("boardId")));
		boardDTO.setSubject(request.getParameter("subject"));
		boardDTO.setContent(request.getParameter("content"));
		
		BoardDAO.getInstance().updateBoard(boardDTO);
		
	%>
	
	<script>
		alert("수정 되었습니다.");
		location.href = "bList.jsp";
	</script>
	

</body>
</html>