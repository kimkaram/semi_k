package group.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.*;
import java.util.ArrayList;

import group.model.dao.GroupMgtDao;
import group.model.vo.GroupMgt;
import management.model.vo.MemberMgt;


public class GroupMgtService {

	private GroupMgtDao gdao = new GroupMgtDao();

	// 모임회원 전체 조회 서비스
	public ArrayList<GroupMgt> selectList() {
		Connection con = getConnection();
		ArrayList<GroupMgt> list = gdao.selectList(con);
		close(con);
		return list;
	}

	// 모임회원 조회 서비스
	public GroupMgt selectMember(String userId) {
		Connection con = getConnection();
		GroupMgt group = gdao.selectMember(con, userId);
		close(con);
		return group;
	}

	// 모임회원 탈퇴 서비스
	public int deleteMember(String userId) {
		Connection con = getConnection();
		int result = gdao.deleteMember(con, userId);
		if (result > 0)
			commit(con);
		else
			rollback(con);
		return result;

	}

	/*public int getListCount() {
		Connection con = getConnection();
		int listCount = gdao.getListCount(con);
		close(con);
		return listCount;
	}*/
}
