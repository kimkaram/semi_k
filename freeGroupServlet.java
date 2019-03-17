package createGroup.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import createGroup.model.service.GroupService;
import createGroup.model.vo.Group;
import group.model.service.GroupMgtService;
import group.model.vo.GroupMgt;
import group2.model.service.Group2Service;
import group2.model.vo.Group2;

/**
 * Servlet implementation class FreeGroupServlet
 */
@WebServlet("/freeg")
public class FreeGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreeGroupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String userId = (String)request.getParameter("mem");
		String groupNo = (String)request.getParameter("group");
		
		System.out.println(userId);
		System.out.println(groupNo);
		
		
		Group2 group = new Group2Service().selectOne(groupNo);
		Group g = new GroupService().selectOne(groupNo);
		GroupMgt groupm = new GroupMgt();
		groupm.setUserId(userId);
		groupm.setGroupNo(groupNo);
		
		
		int result = new GroupMgtService().insertMember(groupm);
		
		
		
		RequestDispatcher view = null;
		if (group != null || result > 0) {
			view = request.getRequestDispatcher("views/group/finishJoin.jsp");
			request.setAttribute("groupd", group);
			request.setAttribute("groupno", groupNo);
			request.setAttribute("g", g);
			request.setAttribute("groupm", groupm);
			view.forward(request, response);
			
		} 
		
		else {
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", userId + "가입 실패!");
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
