package group.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import group.model.service.GroupMgtService;
import group.model.vo.GroupMgt;

/**
 * Servlet implementation class GroupMemberDelete
 */
@WebServlet("/mdel")
public class GMemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GMemberDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		String userId = request.getParameter("mdelete");
		
		String gno = request.getParameter("groupno");
		
		int result = new GroupMgtService().deleteMember(userId);
		
		if(result > 0) {
			response.sendRedirect("/semi/glist?page=1&groupno=" + gno+ "&idsearch=0");
			//request.setAttribute("gdelete", userId);
			
		} else {
			RequestDispatcher view = request.getRequestDispatcher("views/group/memberError.jsp");
			request.setAttribute("message", userId + " 님의 탈퇴처리가 실패했습니다.");
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
