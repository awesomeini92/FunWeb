package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.boardBean;
import gallary.gallaryBean;

public class commentDAO {
	public Connection getConnection() throws Exception { // db 연결
		Connection con = null;
		Context init = new InitialContext(); // context.xml
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}

	public void insertComment(commentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();
//			String sql = "alter table comment auto_increment=1";
//			pstmt = con.prepareStatement(sql);
//			pstmt.executeUpdate();
			
			String sql = "insert into comment (gllr_num, id, comment, date) values(?,?,?,now())";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, cb.getGllr_num());
			pstmt.setString(2, cb.getId());
			pstmt.setString(3, cb.getComment());
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
	
		public commentBean getComment(int cmmnt_num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			commentBean cb = new commentBean();

			try {

				con = getConnection();

				String sql = "select * from comment where cmmnt_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cmmnt_num);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					cb.setCmmnt_num(rs.getInt("cmmnt_num"));
					cb.setGllr_num(rs.getInt("gllr_num"));
					cb.setId(rs.getString("id"));
					cb.setComment(rs.getString("comment"));
					cb.setDate(rs.getDate("date"));
				}

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
			return cb;

	}
		
		public int getCommentCount(int gllr_num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0;

			try {

				con = getConnection();

				String sql = "select count(*) as count from comment where gllr_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, gllr_num);

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

//	public List getCommentList(int startRow, int pageSize) {
	public List getCommentList(int startRow, int pageSize, int gllr_num) {

		List commentList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
//			String sql = "select * from comment order by num desc limit ?,? cmmnt_num =?";
			String sql = "select * from comment where gllr_num=? order by cmmnt_num limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,gllr_num);
			 pstmt.setInt(2, startRow-1);
			 pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				commentBean cb = new commentBean();
				cb.setCmmnt_num(rs.getInt("cmmnt_num"));
				cb.setGllr_num(rs.getInt("gllr_num"));
				cb.setId(rs.getString("id"));
				cb.setComment(rs.getString("comment"));
				cb.setDate(rs.getDate("date"));

				commentList.add(cb);

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

		return commentList;
	}
	
	public List getCommentList(int gllr_num) {

		List commentList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
			
//			String sql = "select * from comment order by num desc limit ?,? cmmnt_num =?";
			String sql = "select * from comment where gllr_num=? order by cmmnt_num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,gllr_num);
//			 pstmt.setInt(2, startRow-1);
//			 pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				commentBean cb = new commentBean();
				cb.setCmmnt_num(rs.getInt("cmmnt_num"));
				cb.setGllr_num(rs.getInt("gllr_num"));
				cb.setId(rs.getString("id"));
				cb.setComment(rs.getString("comment"));
				cb.setDate(rs.getDate("date"));

				commentList.add(cb);

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

		return commentList;
	}
	

	public String getTime() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String time = null;
		ResultSet rs = null;

		try {
			con = getConnection();
			String sql = "select Time(date) AS time from reference";
//		String sql = "select Date(now())";
			pstmt = con.prepareStatement(sql);
//		pstmt.setInt(1, cmmnt_num);
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
	
	public void updateCmmnt(commentBean cb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();
			String sql = "alter table comment auto_increment=1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			sql = "update comment set gllr_num=?, id=?, comment=?, date=now() where cmmnt_num=?";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, cb.getGllr_num());
			pstmt.setString(2, cb.getId());
			pstmt.setString(3, cb.getComment());
			pstmt.setInt(4, cb.getCmmnt_num());
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
	
	public void deleteComment(int cmmnt_num) {
//		int num = rb.getNum();
		// String pass = rb.getPass();
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();

			String sql = "delete from comment where cmmnt_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cmmnt_num);
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

	
}
