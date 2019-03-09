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
@WebServlet("/gmlist")
public class MemberSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int searchList = 1;
		int currentPage = 1;
		if(request.getParameter("page") != null) 
			currentPage = Integer.parseInt(request.getParameter("page").trim());

		String gno = request.getParameter("groupno");
		String userId = request.getParameter("idsearch");
	
		int limit = 10;
	
		GroupMgtService gmservice = new GroupMgtService();
		int listCount = gmservice.getListCount2(userId);
		
		ArrayList<GroupMgt> list = gmservice.searchMember(gno, userId, currentPage, limit);
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (((int)((double)currentPage / limit + 0.9))
				- 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		if(list !=  null) {
			view = request.getRequestDispatcher("views/group/leaderListView.jsp");
			request.setAttribute("list", list);
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
			request.setAttribute("message", "紐⑥엫�쉶�썝 寃��깋  議고쉶 �떎�뙣!");
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
