package reference;

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


public class referenceDAO {
	public Connection getConnection() throws Exception { // db 연결
		Connection con = null;
		Context init = new InitialContext(); // context.xml
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}

	public void insertReference(referenceBean rb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = rb.getNum();

		try {
			con = getConnection();
			String sql = "select MAX(num) as mnum from reference";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("mnum") + 1;
			}
//		num | name | pass | subject | content | readcount | file  | date

			sql = "insert into reference(num,name,pass,subject,content,readcount,file,date) values(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, rb.getName());
			pstmt.setString(3, rb.getPass());
			pstmt.setString(4, rb.getSubject());
			pstmt.setString(5, rb.getContent());
			pstmt.setInt(6, rb.getReadcount());
			pstmt.setString(7, rb.getFile());
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

			String sql = "select Time(date) AS time from reference where num=?";

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

	public referenceBean getReference(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		referenceBean rb = new referenceBean();

		try {

			con = getConnection();

			String sql = "select * from reference where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				rb.setNum(rs.getInt("num"));
				rb.setName(rs.getString("name"));
				rb.setPass(rs.getString("pass"));
				rb.setContent(rs.getString("content"));
				rb.setDate(rs.getDate("date"));
				rb.setSubject(rs.getString("subject"));
				rb.setPass(rs.getString("pass"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setFile(rs.getString("file"));

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
		return rb;
	}

	public int getReferenceCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {

			con = getConnection();

			String sql = "select count(*) as count from reference";
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
	
	public int getReferenceCount(String search) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		try {

			con = getConnection();

			String sql = "select count(*) as count from reference where subject like ?";
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
	
	
	
	public List getReferenceList(int startRow, int pageSize) {

		List referenceList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
			String sql = "select * from reference order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				referenceBean rb = new referenceBean();
				rb.setNum(rs.getInt("num"));
				rb.setName(rs.getString("name"));
				rb.setContent(rs.getString("pass"));
				rb.setSubject(rs.getString("subject"));
				rb.setContent(rs.getString("content"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setDate(rs.getDate("date"));
				rb.setFile(rs.getString("file"));
				

				referenceList.add(rb);

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

		return referenceList;

	}
	
	public List getReferenceList(int startRow, int pageSize, String search) {

		List referenceList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();

			// limit 시작행-1부터 몇개 글 가져오기 (mysql)
			String sql = "select * from reference where subject like ? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				referenceBean rb = new referenceBean();
				rb.setNum(rs.getInt("num"));
				rb.setSubject(rs.getString("subject"));
				rb.setContent(rs.getString("pass"));
				rb.setName(rs.getString("name"));
				rb.setDate(rs.getDate("date"));
				rb.setContent(rs.getString("content"));
				rb.setReadcount(rs.getInt("readcount"));

				referenceList.add(rb);

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

		return referenceList;

	}

	public void updateReadCount(int num) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();
			String sql = "update reference set readcount=readcount+1 where num =? ";
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

	public int updateReference(referenceBean rb) {

		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();

			String sql = "update reference set subject=?, name=?, content=?, file=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rb.getSubject());
			pstmt.setString(2, rb.getName());
			pstmt.setString(3, rb.getContent());
			pstmt.setString(4, rb.getFile());	
			pstmt.setInt(5, rb.getNum());
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

//	public void deleteReference(referenceBean rb) {
	public void deleteReference(int num) {
//		int num = rb.getNum();
		// String pass = rb.getPass();
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();

			String sql = "delete from reference where num=?";
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

			String sql = "select pass from reference where num=? ";
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
