package gallary;

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

import board.boardBean;
import gallary.gallaryBean;

public class gallaryDAO {

	public Connection getConnection() throws Exception { // db 연결
		Connection con = null;
		Context init = new InitialContext(); // context.xml
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}


	public void insertGallary(gallaryBean gb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = gb.getNum();

		try {
			con = getConnection();
			String sql = "select MAX(num) as mnum from gallary";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("mnum") + 1;
			}
//			num | name | pass | subject | content | readcount | file  | date

			sql = "insert into gallary(num,name,pass,subject,content,readcount,file,date) values(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, gb.getName());
			pstmt.setString(3, gb.getPass());
			pstmt.setString(4, gb.getSubject());
			pstmt.setString(5, gb.getContent());
			pstmt.setInt(6, gb.getReadcount());
			pstmt.setString(7, gb.getFile());
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

	public gallaryBean getGallary(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		gallaryBean gb = new gallaryBean();

		try {

			con = getConnection();

			String sql = "select * from gallary where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				gb.setNum(rs.getInt("num"));
				gb.setContent(rs.getString("content"));
				gb.setDate(rs.getDate("date"));
				gb.setName(rs.getString("name"));
				gb.setSubject(rs.getString("subject"));
				gb.setPass(rs.getString("pass"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setFile(rs.getString("file"));

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
		return gb;
	}
	
	public String getTime(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String time = null;
		ResultSet rs = null;

		try {

			con = getConnection();

			String sql = "select Time(date) AS time from gallary where num=?";

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
	
	public int getGallaryCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {

			con = getConnection();

			String sql = "select count(*) as count from gallary";
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
	
	public int getGallaryCount(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {

			con = getConnection();

			String sql = "select count(*) as count from gallary where subject like ?";
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
	
	
	public List getGallaryList(int startRow, int pageSize) {

		List gallaryList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
			String sql = "select * from gallary order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				gallaryBean gb = new gallaryBean();
				gb.setNum(rs.getInt("num"));
				gb.setSubject(rs.getString("subject"));
				gb.setContent(rs.getString("pass"));
				gb.setName(rs.getString("name"));
				gb.setDate(rs.getDate("date"));
				gb.setContent(rs.getString("content"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setFile(rs.getString("file"));

				gallaryList.add(gb);

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

		return gallaryList;

	}
	
	public List getGallaryList(int startRow, int pageSize, String search) {

		List gallaryList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
			String sql = "select * from gallary where subject like ? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				gallaryBean gb = new gallaryBean();
				gb.setNum(rs.getInt("num"));
				gb.setSubject(rs.getString("subject"));
				gb.setContent(rs.getString("pass"));
				gb.setName(rs.getString("name"));
				gb.setDate(rs.getDate("date"));
				gb.setContent(rs.getString("content"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setFile(rs.getString("file"));
				
				gallaryList.add(gb);

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

		return gallaryList;

	}

	public void updateReadCount(int num) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();
			String sql = "update gallary set readcount=readcount+1 where num =? ";
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

	public int updateGallary(gallaryBean gb) {

		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();

			String sql = "update gallary set subject=?, name=?, content=?, file=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gb.getSubject());
			pstmt.setString(2, gb.getName());
			pstmt.setString(3, gb.getContent());
			pstmt.setString(4, gb.getFile());	
			pstmt.setInt(5, gb.getNum());
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

//	public void deleteGallary(gallaryBean gb) {
	public void deleteGallary(int num) {
//		int num = gb.getNum();
		// String pass = gb.getPass();
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();

			String sql = "delete from gallary where num=?";
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

			String sql = "select pass from gallary where num=? ";
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
