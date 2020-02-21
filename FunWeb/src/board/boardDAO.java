package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class boardDAO {
	public Connection getConnection() throws Exception { // db 연결
		Connection con = null;
		Context init = new InitialContext(); // context.xml
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}

	public void insertBoard(boardBean bb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = bb.getNum();

		try {
			con = getConnection();
			String sql = "select MAX(num) as mnum from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("mnum") + 1;
			}
//		num | name | pass | subject | content | readcount | file  | date

			sql = "insert into board(num,name,pass,subject,content,readcount,file,date) values(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setString(7, bb.getFile());
			pstmt.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}
	}

	public String getTime(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String time = null;
		ResultSet rs = null;

		try {

			con = getConnection();

			String sql = "select Time(date) AS time from board where num=?";

//			String sql = "select Date(now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				time = rs.getString("time");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}
		return time;
	}

//	public Date getDate(int num) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		Date date = null;
//		ResultSet rs = null;
//		
//		try {
//			con = getConnection();
//
//			String sql = "select Date(reg_date) AS date from member where num=?";
//			pstmt = con.prepareStatement(sql);
//			pstmt.setInt(1, num);
//			rs = pstmt.executeQuery();
//
//				if(rs.next()) {
//					date = rs.getDate("date");
//				}
//		}catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally { //예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
//			if(rs!=null) try{rs.close();}catch(SQLException e) {}
//			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
//			if(con!=null) try{con.close();}catch(SQLException e) {}
//		
//		}
//		return date;
//	}

	public Date getToday() {
		Connection con = null;
		PreparedStatement pstmt = null;
		Date today = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			String sql = "select Date(now()) AS today";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				today = rs.getDate("today");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}
		return today;
	}

	public boardBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boardBean bb = new boardBean();

		try {

			con = getConnection();

			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getDate("date"));
				bb.setSubject(rs.getString("subject"));
				bb.setPass(rs.getString("pass"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setFile(rs.getString("file"));

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}
		return bb;
	}

	public int getBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {

			con = getConnection();

			String sql = "select count(*) as count from board";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}
		return count;
	}
	
	public int getBoardCount(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {

			con = getConnection();

			String sql = "select count(*) as count from board where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}
		return count;
	}
	
	
	public List getBoardList(int startRow, int pageSize) {

		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
			String sql = "select * from board order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				boardBean bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("pass"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));

				boardList.add(bb);

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}

		return boardList;

	}
	
	public List getBoardList(int startRow, int pageSize, String search) {

		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
			String sql = "select * from board where subject like ? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				boardBean bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("pass"));
				bb.setName(rs.getString("name"));
				bb.setDate(rs.getDate("date"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));

				boardList.add(bb);

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}

		return boardList;

	}

	public void updateReadCount(int num) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();
			String sql = "update board set readcount=readcount+1 where num =? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
//		System.out.println("마무리작업");
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}

	}

	public int updateBoard(boardBean bb) {

		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();

			String sql = "update board set subject=?, name=?, content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getSubject());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getContent());
			pstmt.setInt(4, bb.getNum());
			pstmt.executeUpdate();

			check = 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			check = 0;
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}
		return check;
	}

//	public void deleteBoard(boardBean bb) {
	public void deleteBoard(int num) {
//		int num = bb.getNum();
		// String pass = bb.getPass();
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();

			String sql = "delete from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
//			System.out.println("마무리작업");
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}

	}

	public int userCheck(int num, String pass) {

		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			String sql = "select pass from board where num=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString("pass").equals(pass)) {
					check = 1;
				} else {
					check = 0;
				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally { // 예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
				}

		}

		return check;

	}

}
