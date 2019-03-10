package admin.model.service;

import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;
import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;

import java.sql.Connection;
import java.util.ArrayList;

import admin.model.dao.AdminDao;
import group.model.vo.GroupMgt;
import group2.model.vo.Group2;
import member.model.vo.Member;

public class AdminService {

	private AdminDao adao = new AdminDao();

	
	public ArrayList<Member> selectMemberList() {
		// 회원 전체 정보 조회
		Connection conn = getConnection();
		ArrayList<Member> list = adao.selectMemberList(conn);
		close(conn);
		return list;
	}
	
	public ArrayList<Group2> selectList(int currentPage, int limit) {
		//모임 전체 조회
		Connection con = getConnection();
		ArrayList<Group2> list = adao.selectList(con, currentPage, limit);
		close(con);
		return list;
	}

	public int getListCount() {
		Connection con = getConnection();
		int listCount = adao.getListCount(con);
		close(con);
		return listCount;
	}
	
	public int getListCount2(String cgNo, String groupName) {
		Connection con = getConnection();
		int listCount = adao.getListCount2(con, cgNo, groupName);
		close(con);
		return listCount;
	}
	
	public ArrayList<Group2> searchMember(String cgNo, String groupName, int currentPage, int limit ) {
		Connection con = getConnection();
		ArrayList<Group2> slist = adao.searchMember(con,cgNo, groupName, currentPage, limit);
		close(con);
		return slist;
	}
	
	public int deleteMember(String groupNo) {
		Connection con = getConnection();
		int result = adao.deleteMember(con, groupNo);
		if (result > 0)
			commit(con);
		else
			rollback(con);
		return result;

	}
}
