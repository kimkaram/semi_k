package admin.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import group.model.vo.GroupMgt;
import group2.model.vo.Group2;
import member.model.vo.Member;

public class AdminDao {

	public ArrayList<Member> selectMemberList(Connection conn) {
		// 회원 전체 조회 컨트롤러
		ArrayList<Member> list = new ArrayList<Member>();
		Statement stmt = null;
		ResultSet rset = null;
		String query = "select user_id, user_name, gender, email, nickname, enrolltime from member";
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			while(rset.next()) {
				Member m = new Member();
				m.setUserId(rset.getString("user_id"));
				m.setUserName(rset.getString("user_name"));
				m.setGender(rset.getString("gender"));
				m.setEmail(rset.getString("email"));
				m.setNickName(rset.getString("nickname"));
				m.setEnrollDate(rset.getDate("enrolltime"));	
				list.add(m);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}

	public ArrayList<Group2> selectList(Connection con, int currentPage, int limit) {
		//모임 전체 조회
		ArrayList<Group2> list = new ArrayList<Group2>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "String query = \"select group_no, leader_id, cg_no, group_name, group_text, address, leader_comm, createtime, charge, group_score from (select rownum rnum, group_no, leader_id, cg_no, group_name, group_text, address, leader_comm, createtime, charge, group_score from group1 order by group_no asc) where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;

		try {
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			
				rset = pstmt.executeQuery();

				while (rset.next()) {

				Group2 g = new Group2();

				g.setGroupNo(rset.getString("group_no"));
				g.setLeaderId(rset.getString("leader_id"));
				g.setCgNo(rset.getString("cg_no"));
				g.setGroupName(rset.getString("group_name"));
				g.setGroupText(rset.getString("group_text"));
				g.setAddress(rset.getString("address"));
				g.setLeaderComm(rset.getString("leader_comm"));
				g.setCreatetime(rset.getDate("createtime"));
				g.setCharge(rset.getString("charge"));
				g.setGroupScore(rset.getInt("group_score"));

				list.add(g);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}
	
	public int getListCount(Connection con) {
		int listCount = 0;
		Statement stmt = null;
		ResultSet rset = null;

		String query = "select count(*) from group1";

		try {
			
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if (rset.next()) {
				listCount = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}

		return listCount;
	}
	
	public int getListCount2(Connection con, String cgNo, String groupName) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select count(*) from group1";

		try {
			if(!(cgNo == null || "".equals(cgNo)) && (groupName == null || "".equals(groupName)) ) {
				// 카테고리로 조회
				query += " where cg_no = ?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, cgNo);
				
			}else if((cgNo == null || "".equals(cgNo)) && !(groupName == null || "".equals(groupName)) ) {
				// 제목으로 조회
				query += " where group_name like '%' || ? || '%'";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, groupName);
				
			}else if(!(cgNo == null || "".equals(cgNo)) && !(groupName == null || "".equals(groupName)) ) {
				// 카테고리 + 제목으로 조회
				query += " where cg_no = ? and group_name like '%' || ? || '%'";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, cgNo);
				pstmt.setString(2, groupName);
			
			}else {
				pstmt = con.prepareStatement(query);
			} 
			
			
			rset = pstmt.executeQuery();
			if (rset.next()) {
				listCount = rset.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return listCount;
	}
	
	public ArrayList<Group2> searchMember(Connection con, String cgNo, String groupName, int currentPage, int limit) {
		ArrayList<Group2> slist = new ArrayList<Group2>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from (select rownum rnum, group_no, leader_id, cg_no, group_name, createtime from group1";


		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;

		try {

			if(!(cgNo == null || "".equals(cgNo)) && (groupName == null || "".equals(groupName))) {
				query += " where cg_no = ? order by group_no asc ) where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(query);
				
				pstmt.setString(1, cgNo);
				pstmt.setInt(2 ,(currentPage-1)*limit+1);
				pstmt.setInt(3 , endRow);
			
			} else if((cgNo == null || "".equals(cgNo)) && !(groupName == null || "".equals(groupName)) ) {
				// 제목으로 조회
				query += " where group_name like '%' || ? || '%'"
					  + " order by GROUP_NO asc"
					  + ") where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, groupName);
				pstmt.setInt(2, (currentPage-1)*limit+1);
				pstmt.setInt(3, currentPage*limit);
			
			
			} else if(!(cgNo == null || "".equals(cgNo)) && !(groupName == null || "".equals(groupName)) ) {
				// 카테고리 + 제목으로 조회
				query += " where cg_no = ? and group_name like '%' || ? || '%'"
					  + " order by GROUP_NO asc"
					  + ") where rnum >= ? and rnum <= ?";
				
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, cgNo);
				pstmt.setString(2, groupName);
				pstmt.setInt(3, (currentPage-1)*limit+1);
				pstmt.setInt(4, currentPage*limit);
				
			}else {
				query +=  " order by GROUP_NO asc"
					  + ") where rnum >= ? and rnum <= ?";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, (currentPage-1)*limit+1);
				pstmt.setInt(2, currentPage*limit);
			}
	
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Group2 g = new Group2();

				g.setGroupNo(rset.getString("group_no"));
				g.setLeaderId(rset.getString("leader_id"));
				g.setCgNo(rset.getString("cg_no"));
				g.setGroupName(rset.getString("group_name"));
				g.setCreatetime(rset.getDate("createtime"));
				
				slist.add(g);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return slist;
	}
	
	//deltet쪽 db group_member 도 전부 다 모임번호 연결되어 있느 ㄴ회원들 삭제해야 함
	public int deleteMember(Connection con, String groupNo) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query1 = "delete from group1 where group_no = ?";
		String query2 = "delete from member_group where group_no = ?";
		
		try {
			pstmt = con.prepareStatement(query1);
			pstmt.setString(1, groupNo);
			result = pstmt.executeUpdate();
			
			pstmt = con.prepareStatement(query2);
			pstmt.setString(1, groupNo);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	
	
}






