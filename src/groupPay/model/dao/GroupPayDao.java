package groupPay.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import groupPay.model.vo.GroupPay;

public class GroupPayDao {

	public GroupPay selectOne(Connection con, String groupNo) {
		GroupPay g = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select price from group_pay where group_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,groupNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				g = new GroupPay();
				
				g.setPrice(rset.getInt("price"));
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return g;
	}
	
	
}
