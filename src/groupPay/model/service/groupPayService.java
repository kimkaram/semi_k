package groupPay.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;

import groupPay.model.dao.GroupPayDao;
import groupPay.model.vo.GroupPay;

public class GroupPayService {

	private GroupPayDao pdao = new GroupPayDao(); 
	
	public GroupPay selectOne(String groupNo) {
		Connection con = getConnection();
		GroupPay group = pdao.selectOne(con, groupNo);
		close(con);
		return group;
	}
	
}
