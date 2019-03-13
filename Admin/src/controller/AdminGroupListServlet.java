package admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.model.service.AdminService;
import group.model.service.GroupMgtService;
import group.model.vo.GroupMgt;
import group2.model.vo.Group2;

/**
 * Servlet implementation class adminGroupList
 */
@WebServlet("/adglist")
public class AdminGroupList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminGroupList() {
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

		if(request.getParameter("page") != null ) 
			currentPage = Integer.parseInt(request.getParameter("page").trim());

		String cgNo = request.getParameter("cgno");
		String gname = request.getParameter("groupname");
		
		if(cgNo == null || gname == null) {
			cgNo = "";
			gname ="";
		}
		
		int limit = 10;
		
		AdminService aservice = new AdminService();
		int listCount = aservice.groupAdminListCount(); // 모임개수
		
		ArrayList<Group2> list = aservice.selectAdminGroupList(currentPage, limit);//그 모임들에 대한 정보
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (((int)((double)currentPage / limit + 0.9))
				- 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		
		if(list.size() > 0) {
			view = request.getRequestDispatcher("views/admin/adminGroupList.jsp");
			request.setAttribute("list", list);
			request.setAttribute("page", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("searchList", searchList);
			
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/admin/memberError.jsp");
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
