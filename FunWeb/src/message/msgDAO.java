package message;

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
import member.memberBean;

public class msgDAO {
	
	public Connection getConnection() throws Exception{ // db 연결
		Connection con = null;
		Context init = new InitialContext(); //	context.xml		
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}

	public void insertMsg(msgBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "insert  into message(sdr,rcvr,msg) values(?,?,?)"; 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, mb.getSdr());
			pstmt.setString(2, mb.getRcvr());
			pstmt.setString(3, mb.getMsg());
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally { //예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException e) {}
		}
	}
	
	public List selectMsg(String rcvr) {
		
		List msgList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			String sql = "select * from message where rcvr=?"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rcvr);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				msgBean mb = new msgBean();
				mb.setSdr(rs.getString("sdr"));
				mb.setRcvr(rs.getString("rcvr"));
				mb.setMsg(rs.getString("msg"));
				
				msgList.add(mb);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally { //예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException e) {}
		}
		return msgList;
	}
	

}
