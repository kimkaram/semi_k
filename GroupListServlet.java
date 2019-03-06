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


/**
 * Servlet implementation class GMemberListServlet
 */
@WebServlet("/gslist")
public class GMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GMemberListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String userId = request.getParameter("idsearch");
		
		ArrayList<GroupMgt> list = new GroupMgtService().searchMember(userId);
		System.out.println(list);
		RequestDispatcher view = null;
		if(list.size()  > 0) {
			view = request.getRequestDispatcher("views/group/GMemberList.jsp");
			request.setAttribute("list", list);
			System.out.println("listS : " + list);
			//request.setAttribute("group", group.setUserId(ss));
			//System.out.println("group2 : " + group);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/group/groupError.jsp");
			request.setAttribute("message", "모임회원 전체 목록 조회 실패!");
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
