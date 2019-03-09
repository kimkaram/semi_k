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
import group2.model.dao.GroupDao;
import group2.model.service.GroupService;
import group2.model.vo.Group;

/**
 * Servlet implementation class GroupListServlet
 */
@WebServlet("/glist")
public class GroupListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		int currentPage = 1;
		int searchList = 0;
		
		if(request.getParameter("page") != null) 
			currentPage = Integer.parseInt(request.getParameter("page").trim());

		String gno = request.getParameter("groupno");
		String userId = request.getParameter("idsearch");
		
		if(userId == null) {
			userId = "";
		}
		int limit = 10;
		
		
		GroupMgtService gservice = new GroupMgtService();
		int listCount = gservice.getListCount(gno);
		
		ArrayList<GroupMgt> list = gservice.selectList(gno, currentPage, limit);
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (((int)((double)currentPage / limit + 0.9))
				- 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		
		if(list != null) {
			view = request.getRequestDispatcher("views/group/leaderListView.jsp");
			request.setAttribute("glist", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("searchList", searchList);
			request.setAttribute("groupNo", gno);
			request.setAttribute("idsearch", userId);
			
			
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/group/groupError.jsp");
			request.setAttribute("message", currentPage + "에 대한 목록 조회 실패!");
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
