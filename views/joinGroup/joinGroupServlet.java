package createGroup.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import createGroup.model.service.GroupService;
import createGroup.model.vo.*;
import group.model.service.GroupMgtService;
import group.model.vo.GroupMgt;
import group2.model.service.Group2Service;
import group2.model.vo.*;
import groupPay.model.service.GroupPayService;
import groupPay.model.vo.GroupPay;

/**
 * Servlet implementation class GroupJoinServlet
 */
@WebServlet(name = "JoinGroupServlet", urlPatterns = { "/gjoin" })
public class GroupJoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupJoinServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String groupNo = request.getParameter("group");
		GroupPay gpay = new GroupPayService().selectOne(groupNo);
		Group2 group = new Group2Service().selectOne(groupNo);
		Group g = new GroupService().selectOne(groupNo);
		int checkCount = new GroupPayService().selectCheckCount(groupNo);
		int gpa2 = g.getMembercount();
		if(gpa2 == 0) {
			gpa2 = 9999;
		}
		
		
		RequestDispatcher view = null;
		if(checkCount < gpa2) {
		
		
		if (group != null || gpay == null) {
			view = request.getRequestDispatcher("views/group/joinGroup.jsp");
			request.setAttribute("groupd", group);
			request.setAttribute("groupno", groupNo);
			request.setAttribute("g", g);
			request.setAttribute("gpay", gpay);
			
			view.forward(request, response);
			
		} else {
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", groupNo + "가입 페이지 불러오기 실패!");
			view.forward(request, response);
		}} else {
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", groupNo + "가입 인원이 다 찼습니다!");
			view.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
