package member;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class memberDAO {

public Connection getConnection() throws Exception{ // db 연결
		Connection con = null;
		Context init = new InitialContext(); //	context.xml		
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}



public void insertMember(memberBean mb) {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con = getConnection();
		
		String sql = "insert  into member(id, pass, name, email, postCode,  detailAddress, extraAddress, address, phone, mobile, reg_date)	 values(?,?,?,?,?,?,?,?,?,?,now())"; 
		pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, mb.getId());
		pstmt.setString(2, mb.getPass());
		pstmt.setString(3, mb.getName() );
		pstmt.setString(4, mb.getEmail());
		pstmt.setInt(5, mb.getPostCode());
		pstmt.setString(6, mb.getDetailAddress());
		pstmt.setString(7,mb.getExtraAddress());
		pstmt.setString(8, mb.getAddress());
		pstmt.setString(9, mb.getPhone());
		pstmt.setString(10, mb.getMobile());
	
		
		pstmt.executeUpdate();
		
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally { //예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
		if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
		if(con!=null) try{con.close();}catch(SQLException e) {}
	}
}

public void deleteMember(String id) {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try {
		con = getConnection();
		
		String sql = "delete from member where id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);			
		pstmt.executeUpdate();
			
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally { 
		if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
		if(con!=null) try{con.close();}catch(SQLException e) {}
	
	}

}

//javascript 새창으로 만들어주기
public int checkId (String id) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;	
	int check = 0;
	try {
		con = getConnection();
		
		String sql = "select * from member where id=? ";
		pstmt = con.prepareStatement(sql);
		 pstmt.setString(1, id);
		rs =pstmt.executeQuery();
		
		 if(rs.next()){
				check =1;		
		}
	} catch (Exception e) {
		e.printStackTrace();
	}finally { //예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
		if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
		if(con!=null) try{con.close();}catch(SQLException e) {}
	}
	
	return check;
}

public int checkUser (String id, String pass) {
	
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			
			 String sql = "select * from member where id=? ";
			pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, id);

			 rs = pstmt.executeQuery();
			
			 if(rs.next()){
				 if(rs.getString("pass").equals(pass)) {
					 check = 1;
				 }else {
					 check = 0;
				 }
			 }else {
				 check=-1;
			 }
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally { //예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
//			System.out.println("마무리작업");
			if(rs!=null) try{rs.close();}catch(SQLException e) {}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException e) {}
		
		}

		return check;
}

public memberBean getMember (String id) {
	memberBean mb = new memberBean();
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con = getConnection();
		
		 String sql = "select * from member where id=? ";
		pstmt = con.prepareStatement(sql);
		 pstmt.setString(1, id);

		 rs = pstmt.executeQuery();
		
		 if(rs.next()){
			 mb.setId(rs.getString("id"));
			 mb.setPass(rs.getString("pass"));
			 mb.setName(rs.getString("name"));
			 mb.setPostCode(rs.getInt("postCode"));
			 mb.setAddress(rs.getString("address"));
			 mb.setDetailAddress(rs.getString("detailAddress"));
			 mb.setExtraAddress(rs.getString("extraAddress"));
			 mb.setPhone(rs.getString("phone"));
			 mb.setMobile(rs.getString("mobile"));
			 mb.setEmail(rs.getString("email"));

		 }
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally { 
		if(rs!=null) try{rs.close();}catch(SQLException e) {}
		if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
		if(con!=null) try{con.close();}catch(SQLException e) {}
	
	}

	return mb;
	
}
public void updateMember(memberBean mb) {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try {
		con = getConnection();
		
		String sql = "update member set pass=?, name=?, email=?, address=?, phone=?, mobile=? where id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, mb.getPass());
		pstmt.setString(2, mb.getName());
		pstmt.setString(3, mb.getEmail());
		pstmt.setString(4, mb.getAddress());
		pstmt.setString(5, mb.getPhone());
		pstmt.setString(6, mb.getMobile());
		pstmt.setString(7, mb.getId());	
			
		pstmt.executeUpdate();
			
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally { //예외 발생여부 상관없이 마무리 작업 => 기억장소 해제
//		System.out.println("마무리작업");
		if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
		if(con!=null) try{con.close();}catch(SQLException e) {}
	
	}
}




}

