package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class DBClose {
	public static void close(Connection conn, Statement psmt, ResultSet rs) {
		try {
			if(conn != null) {	// 살아 있으면 db 닫기
				conn.close();
			}
			if(psmt != null) {
				psmt.close();	// 접속 끊기
			}
			if(rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
