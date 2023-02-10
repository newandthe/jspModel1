package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
	private static MemberDao dao = null;
	
	private MemberDao() {	// 싱글톤. 다시는 생성되지 못하도록.
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() {
		if(dao == null) {
			dao = new MemberDao();
		}
		return dao;
	}
	
	public boolean getId(String id) {
		
		String sql = " select id "
				+	 " from member "
				+	 " where id=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean findid = false;	// 초기값은 중복이 없다고 가정.
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			System.out.println("2/3 getId Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getId Success");
			
			if(rs.next()) {	// 데이터가 있다면
				findid = true;	// 중복 찾았으니 true로
			}
			
		} catch (SQLException e) {
			System.out.println("getId Failed");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return findid;
	}
	
	public boolean addMember(MemberDto dto) {
		
		String sql = " insert into member(id, pwd, name, email, auth)"
				+	 " values(?, ?, ?, ?, 3)";	// 3명을 넣겠다.
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember Success");
			
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			System.out.println("2/3 addMember Success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addMember Success");
			
		} catch (SQLException e) {
			System.out.println("addMember Failed");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	public MemberDto login(String id, String pwd) {	
		// 위처럼 멤버 dto로 인수 받아서 해도 상관없다.
		
		String sql = " select id, name, email, auth "
				+	 " from member "
				+	 " where id=? and pwd=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 login success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/3 login success");

			
			rs = psmt.executeQuery();	// 쿼리문을 통해 하나만 받을경우 조건문. 여러개 while문
			System.out.println("3/3 login success");
			
			if(rs.next()) {
				String _id = rs.getString("id");
				String _name = rs.getString("name");
				String _email = rs.getString("email");
				int _auth = rs.getInt("auth");
				
				
				mem = new MemberDto(_id, null, _name, _email, _auth);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		
		return mem;
	}
}
