<%@page import="step01_boardEx.BoardDAO"%>
<%@page import="step01_boardEx.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bWritePro</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	
	<% 
		
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
		/*
			alert("게시글이 등록 되었습니다.");
			
			// location.href = "url"; > url로 페이지를 이동한다.
			location.href = "bList.jsp";
		*/
		
		Swal.fire({
			title: "게시글이 등록 되었습니다.",
			text: "메인화면으로 이동합니다.",
			icon: "success"
		}).then(function(){
			location.href = "bList.jsp";
		});
		
	</script>




</body>
</html>