package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CalendarDto;

public class CalendarDao {

	private static CalendarDao dao = null;
	
	private CalendarDao() {
	}
	
	public static CalendarDao getInstance() {
		if(dao == null) {
			dao = new CalendarDao();
		}
		return dao;
	}
	
	public List<CalendarDto> getCalendarList(String id, String yyyyMM) {
	
		String sql = " select seq, id, title, content, rdate, wdate "
				+ "    from "
				+ "	     (select row_number()over(partition by substr(rdate, 1, 8) order by rdate asc) as rnum, "
				+ "		         seq, id, title, content, rdate, wdate "
				+ "	      from calendar "
				+ "	      where id=? and substr(rdate, 1, 6)=?) a "
				+ "    where rnum between 1 and 5 ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getCalendarList success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyyMM);
			System.out.println("2/3 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getCalendarList success");
			
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(	rs.getInt(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++), 
													rs.getString(i++) );
				list.add(dto);				
			}
			
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}		
				
		return list;
	}
	
	public boolean addCalendar(CalendarDto dto) {
		String sql = " insert into calendar(id, title, content, rdate, wdate)"
				+	 " values(?, ?, ?, ?, now()) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addCalendar Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getRdate());
			System.out.println("2/3 addCalendar Success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addCalendar Success");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	public CalendarDto getDay(int seq) {
		String sql = " select seq, id, title, content, rdate, wdate "
				+	 " from calendar "
				+	 " where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		CalendarDto dto = null;
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getDay Success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			System.out.println("2/3 getDay Success");
			rs = psmt.executeQuery();
			System.out.println("3/3 getDay Success");
			if(rs.next()) {
				dto = new CalendarDto();
				
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setWdate(rs.getString(6));
				
			}
		} catch (SQLException e) {
			System.out.println("getDay Failed");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
	}
	
	public boolean calUpdate(int seq, String title, String content, String rdate) {
		String sql = " update calendar "
				+	 " set title=?, content=?, rdate=? "
				+	 " where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 CalendarUpdate Success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, rdate);
			psmt.setInt(4, seq);
			System.out.println("2/3 CalendarUpdate Success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 CalendarUpdate Success");
		} catch (SQLException e) {
			System.out.println("CalendarUpdate Failed");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return count>0?true:false;
	}
	
	public boolean calDelete(int seq) {
		String sql = " delete from calendar "
					+" where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 CalendarDelete Success");
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 CalendarDelete Success");
			count = psmt.executeUpdate();
			System.out.println("3/3 CalendarDelete Success");
		} catch (SQLException e) {
			System.out.println("CalendarDelete Failed");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return count>0?true:false;
	}
	
	
	public List<CalendarDto> getDayList(String id, String yyyymmdd) {
		
		String sql = "select seq, id, title, content, rdate, wdate "
				+	 " from calendar "
				+ 	 " where id=? and substring(rdate, 1, 8)=? "
				+ 	 " order by rdate asc; ";
				
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getDayList Success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyymmdd);
			System.out.println("2/3 getDayList Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getDayList Success");
			
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(rs.getInt(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++), 
												rs.getString(i++));
				list.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("getDayList Failed");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		
		return list;
	}
}



