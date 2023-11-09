package step01_boardEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {

	// SingleTon 디자인 패턴
	private BoardDAO() {}
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	
	private Connection conn         = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs            = null;
	
	// 데이터 베이스 연결 메서드
	private void getConnection() {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MVC1_PRACTICE?serverTimezone=Asia/Seoul", "root", "1234");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
	// 데이터베이스 연결 해제 메서드
	private void getClose() {
		if (rs != null)    try {rs.close();} catch (SQLException e) {e.printStackTrace();}
		if (pstmt != null) try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
		if (conn != null)  try {conn.close();} catch (SQLException e) {e.printStackTrace();}
	}
	
	
	// 게시글 추가 DAO
	public void insertBoard(BoardDTO boardDTO) {
		
		// 단위 테스트
		//System.out.println(boardDTO);
		
		try {
			
			getConnection();
			
			String sql = "INSERT INTO BOARD(WRITER , EMAIL , SUBJECT , PASSWORD , CONTENT , READ_CNT , ENROLL_DT)";
				   sql += "VALUES(?,?,?,?,?,0,NOW())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getWriter());
			pstmt.setString(2, boardDTO.getEmail());
			pstmt.setString(3, boardDTO.getSubject());
			pstmt.setString(4, boardDTO.getPassword());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			getClose();
		}
		
	}
	
	
	// 게시글 전체 조회 DAO
	public ArrayList<BoardDTO> getBoardList() {
		
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		try {
			
			getConnection();
			
			pstmt = conn.prepareStatement("SELECT * FROM BOARD");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				BoardDTO temp = new BoardDTO();
				temp.setBoardId(rs.getLong("BOARD_ID"));
				temp.setWriter(rs.getString("WRITER"));
				temp.setSubject(rs.getString("SUBJECT"));
				temp.setReadCnt(rs.getLong("READ_CNT"));
				temp.setEnrollDt(rs.getDate("ENROLL_DT"));
				boardList.add(temp);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			getClose();
		}
		
		// 단위테스트
		//System.out.println(boardList);
		
		return boardList;
		
	}
	
	// 게시글 상세조회 DAO
	public BoardDTO getBoardDetail(long boardId) {
		
//		System.out.println(boardId);
		
		BoardDTO boardDTO = new BoardDTO();
		
		try {
			
			getConnection();
			
			pstmt = conn.prepareStatement("UPDATE BOARD SET READ_CNT = READ_CNT + 1 WHERE BOARD_ID = ?");
			pstmt.setLong(1, boardId);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE BOARD_ID = ?");
			pstmt.setLong(1, boardId);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				boardDTO.setBoardId(rs.getLong("BOARD_ID"));
				boardDTO.setWriter(rs.getString("WRITER"));
				boardDTO.setEmail(rs.getString("EMAIL"));
				boardDTO.setSubject(rs.getString("SUBJECT"));
				boardDTO.setContent(rs.getString("CONTENT"));
				boardDTO.setReadCnt(rs.getLong("READ_CNT"));
				boardDTO.setEnrollDt(rs.getDate("ENROLL_DT"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			getClose();
		}
		
		System.out.println(boardDTO);
		
		return boardDTO;
		
	}
	
	// 비밀번호 인증 DAO
	public boolean checkAuthorizedUser(BoardDTO boardDTO) {
		
		// 단위테스트
//		System.out.println(boardDTO);
		
		boolean isAuthorizedUser = false;
		
		try {
			
			getConnection();
			
			pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE BOARD_ID = ? AND PASSWORD = ?");
			pstmt.setLong(1, boardDTO.getBoardId());
			pstmt.setString(2, boardDTO.getPassword());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				isAuthorizedUser = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			getClose();
		}
		
		// 단위테스트
//		System.out.println(isAuthorizedUser);
		
		return isAuthorizedUser;
	}
	
	// 게시글 수정 DAO
	public void updateBoard(BoardDTO boardDTO) {
		
		// 단위테스트
		System.out.println(boardDTO);
		
		try {
			
			getConnection();
			pstmt = conn.prepareStatement("UPDATE BOARD SET SUBJECT = ? , CONTENT = ? WHERE BOARD_ID = ?");
			pstmt.setString(1, boardDTO.getSubject());
			pstmt.setString(2, boardDTO.getContent());
			pstmt.setLong(3, boardDTO.getBoardId());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			getClose();
		}
		
	}
	
	
}
