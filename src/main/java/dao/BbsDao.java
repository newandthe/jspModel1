package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;
import dto.MemberDto;

public class BbsDao {
	
	private static BbsDao dao = null;
	
	private BbsDao() {
	}
	
	public static BbsDao getInstance() {
		if(dao == null) {
			dao = new BbsDao();
		}
		return dao;
	}
	
	
	public List<BbsDto> getBbsList() {
		
		String sql = " select seq, id, ref, step, depth, title, content, wdate, del, readcount  "
				+	 " from bbs "
				+	 " order by ref desc, step asc ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbsList success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsList success");
			
			while(rs.next()) {
				// (int seq, int id, int ref, int step, int depth, String title, String content, String wdate, int del, int readcount)
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
				
				list.add(dto);
			}
			System.out.println("4/4 getBbsList success");
			
		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
				
		return list;
	}
	
public List<BbsDto> getBbsSearchList(String choice, String search) {
		
		String sql = " select seq, id, ref, step, depth, title, content, wdate, del, readcount  "
				+	 " from bbs ";
		String searchSql = "";
		
		if(choice.equals("title")) {
			searchSql = " where title like '%" + search + "%'";
		}
		else if(choice.equals("content")) {
			searchSql = " where content like '%" + search + "%'";
		}
		else if(choice.equals("writer")) {
			searchSql = " where id='" + search + "'";
		}
		
		sql += searchSql;
		
		sql +=		 " order by ref desc, step asc ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBbsList success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsList success");
			
			while(rs.next()) {
				// (int seq, int id, int ref, int step, int depth, String title, String content, String wdate, int del, int readcount)
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
				
				list.add(dto);
			}
			System.out.println("4/4 getBbsList success");
			
		} catch (SQLException e) {
			System.out.println("getBbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
				
		return list;
	}
	
	// 글의 총수를 알아야 페이지 분할이 가능하다!
	public int getAllBbs(String choice, String search) {
		
		String sql = " select count(*) from bbs ";
		
		String searchSql = "";
		
		if(choice.equals("title")) {
			searchSql = " where title like '%" + search + "%'";
		}
		else if(choice.equals("content")) {
			searchSql = " where content like '%" + search + "%'";
		}
		else if(choice.equals("writer")) {
			searchSql = " where id='" + search + "'";
		}
		
		sql += searchSql;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return count;
	}
	


	public boolean writeBbs(BbsDto dto) {
		String sql = " insert into bbs(id, ref, step, depth, title, content, wdate, del, readcount)"
				+ "	   values(?, "
				+ "			(select ifnull(max(ref), 0)+1 from bbs b), 0, 0 ,"
				+ "			?, ?, now(), 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 wirteBbs Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/3 wirteBbs Success");
			
			count = psmt.executeUpdate();	// query문 실행
			System.out.println("3/3 wirteBbs Success");
		} catch (SQLException e) {
			System.out.println("writeBbs Failed");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
public List<BbsDto> getBbsPageList(String choice, String search, int pageNumber) {
		
		String sql = "select seq, id, ref, step, depth, title, content, wdate, del, readcount "
			+	" from "
			+	" (select row_number()over(order by ref desc, step asc) as rnum, "
			+	"	seq, id, ref, step, depth, title, content, wdate, del, readcount "
			+   "	from bbs ";
		
		String searchSql = "";
		if(choice.equals("title")) {
			searchSql = " where title like '%" + search + "%'";
		}
		else if(choice.equals("content")) {
			searchSql = " where content like '%" + search + "%'";
		}
		else if(choice.equals("writer")) {
			searchSql = " where id='" + search + "'";
		}
		
			
			

		
		sql += searchSql;
		
		sql +=	" order by ref desc, step asc) a "
				+ " where rnum between ? and ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		// count(0, 1, 2 . . ) 와 같이 넘어온다.
		int start, end;
		start = 1 + 10 * pageNumber;
		end = 10 + 10 * pageNumber;
		

		
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsPageList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getBbsPageList success");
			rs = psmt.executeQuery();
			System.out.println("3/4 getBbsPageList success");
			
			while(rs.next()) {
				// (int seq, int id, int ref, int step, int depth, String title, String content, String wdate, int del, int readcount)
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
				
				list.add(dto);
			}
			System.out.println("4/4 getBbsPageList success");
			
		} catch (SQLException e) {
			System.out.println("getBbsPageList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
				
		return list;
	}

	
	  public BbsDto getBbs(int seq) {
			String sql = " select seq, id, ref, step, depth, "
					+	 " title, content, wdate, del, readcount "
					+	" from bbs "
					+   " where seq=? ";
			
			
			
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			
			BbsDto dto = null;
			
			int count = 0;
			
			
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 getBbs success");
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, seq);
				System.out.println("2/3 getBbs success");
				rs = psmt.executeQuery();	// result set으로 return받기
				System.out.println("3/3 getBbs success");
				if(rs.next()) {
					
					dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));
					
				}
			} catch (SQLException e) {
				System.out.println("getBbs Failed");
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DBClose.close(conn, psmt, rs);
			}
			
			return dto;
	  }
	  
	  public boolean answer(int seq, BbsDto dto) {
		  
		  // update
		  String sql1 = " update bbs "
					+ " set step=step+1 "
					+ " where ref=(select ref from (select ref from bbs a where seq=?) A) "
					+ "	  and step>(select step from (select step from bbs b where seq=?) B) ";

		  
		  // insert
		  String sql2 = " insert into bbs(id, ref, step, depth, title, content, wdate, del, readcount) "
					+ " values(?, "
					+ "		(select ref from bbs a where seq=?), "
					+ "		(select step from bbs b where seq=?)+1, "
					+ "		(select depth from bbs c where seq=?)+1, "
					+ "		?, ?, now(), 0, 0) ";

		  
		  Connection conn = null;
		  PreparedStatement psmt = null;
		  int count = 0, count2 = 0;
		  
		 
		  try {
			  conn = DBConnection.getConnection();
			  System.out.println("1/3 answer success");
			  // commit(적용)을 비활성화	commit(확정적용)/ rollback
			conn.setAutoCommit(false);
			
			// update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/3 answer success");
			count = psmt.executeUpdate();
			
			// psmt 초기화 
			// (2개의 쿼리를 사용해야하는 경우- 따로 호출하거나 초기화하고 진행)
			psmt.clearParameters();
			
			// insert
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, dto.getId());
			psmt.setInt(2,seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, dto.getTitle());
			psmt.setString(6, dto.getContent());
			
			count2 = psmt.executeUpdate();
			
			conn.commit();
			System.out.println("3/3 answer success");
		} catch (SQLException e) {
			
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);
		}
		  
		 
		 if(count2 > 0) {
			 return true;
		 }else {
			 return false;
		 }
	  }
	  
	  public boolean update(int seq, BbsDto dto) {
		  String sql = " update bbs "
					+ " set title=?, content=? "
					+ " where seq=? ";
		  
		  Connection conn = null;
		  PreparedStatement psmt = null;
		  int count = 0;
		  
		  
		  try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			
			// update
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setInt(3, seq);
			
			count = psmt.executeUpdate();
			
			conn.commit();
			
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			DBClose.close(conn, psmt, null);
		}
		  
		  if(count > 0) {
				 return true;
			 }else {
				 return false;
			 }
		  
	  }
	  
	  public boolean delete(int seq, BbsDto dto) {
		  String sql = " update bbs "
					+ " set del=? "
					+ " where seq=? ";
		  
		  Connection conn = null;
		  PreparedStatement psmt = null;
		  int count = 0;
		  
		  
			try {
				conn = DBConnection.getConnection();
				System.out.println("1/3 delete success");
				conn.setAutoCommit(false);
				
				// delete
				psmt = conn.prepareStatement(sql);
				psmt.setInt(1, 1);
				psmt.setInt(2, seq);
				System.out.println("2/3 delete success");
				count = psmt.executeUpdate();
				
				conn.commit();
				System.out.println("3/3 delete success");
			} catch (SQLException e) {
				e.printStackTrace();
				
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			} finally {
				try {
					conn.setAutoCommit(true);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				DBClose.close(conn, psmt, null);
			}
			
			if(count > 0) {
				 return true;
			 }else {
				 return false;
			 }
	  }
	 
	  public void ReadCNT(int seq) {
		  String sql = " update bbs "
					+ " set readcount=readcount+1 "
					+ " where seq=? ";
		  
		  Connection conn = null;
		  PreparedStatement psmt = null;
		  
		  conn = DBConnection.getConnection();
		  
		  
		  try {
			  psmt = conn.prepareStatement(sql);
			  psmt.setInt(1, seq);
			  
			  psmt.execute();
			  
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		  
	  }
}
