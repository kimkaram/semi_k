package group.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import group.model.service.GroupMgtService;
import group.model.vo.GroupMgt;
import group2.model.service.GroupService;
import group2.model.vo.Group;

/**
 * Servlet implementation class AllListServlet
 */
@WebServlet("/gdetail")
public class GroupDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupDetailServlet() {
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
		System.out.println("groupNo" + groupNo);
		Group group = new GroupService().selectOne(groupNo);
		
		RequestDispatcher view = null;
		if (group != null) {
			view = request.getRequestDispatcher("views/group/groupView.jsp");
			request.setAttribute("groupd", group);
			request.setAttribute("groupno", groupNo);
			view.forward(request, response);
			
		} else {
			view = request.getRequestDispatcher("views/group/groupError.jsp");
			request.setAttribute("message", groupNo + "상세조회 실패!");
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
