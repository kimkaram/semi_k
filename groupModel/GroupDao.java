package group.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import group.model.vo.GroupMgt;

public class GroupMgtDao {

	public GroupMgtDao() {}

	//모임 회원 전체 조회
	public ArrayList<GroupMgt> selectList(Connection con){
		ArrayList<GroupMgt> list = new ArrayList<GroupMgt>();
		Statement stmt = null;
		ResultSet rset = null;

		String query = "select * from member_group";

		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);

			while(rset.next()) {
				GroupMgt g = new GroupMgt();
				g.setUserId(rset.getString("user_id"));
				g.setGroupNo(rset.getString("group_no"));
				g.setGroupEnrolltime(rset.getDate("group_enrolltime"));

				list.add(g);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}

		return list;
	}


	//모임 회원  선택 조회
	public GroupMgt selectMember(Connection con, String userId) {
		GroupMgt group = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from member_group where user_id = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);

			rset = pstmt.executeQuery();

			if(rset.next()) {
				group = new GroupMgt();

				group.setUserId(rset.getString("user_id"));
				group.setGroupNo(rset.getString("group_no"));
				group.setGroupEnrolltime(rset.getDate("group_enrolltime"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return group;
	}

	//모임회원 탈퇴
	public int deleteMember(Connection con, String userId) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "delete from member_group where user_id = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

}
