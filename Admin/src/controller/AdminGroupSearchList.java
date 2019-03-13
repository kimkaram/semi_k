package admin.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.model.service.AdminService;
import group2.model.vo.Group2;

/**
 * Servlet implementation class AdminGroupSearchServlet
 */
@WebServlet("/adgsearch")
public class AdminGroupSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminGroupSearchServlet() {
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
		
		int searchList = 1;
		int currentPage = 1;
		
		if(request.getParameter("page") != null) 
			currentPage = Integer.parseInt(request.getParameter("page").trim());
		String search = request.getParameter("search");
		
		int limit = 10;
		int listCount =0;
		
		ArrayList<Group2> adslist=null;
		AdminService amservice = new AdminService();
		
		String cgNo = request.getParameter("cgno");
		String gname = request.getParameter("groupname");
		String dateFrom = request.getParameter("from");
		String dateTo = request.getParameter("to");
		
		switch(search) {
		case "writer":
			//카테고리 + 제목
			adslist = amservice.searchAdminGroup(cgNo, gname, currentPage, limit);
			listCount = amservice.groupAdminListCount2(cgNo, gname);
			
			break;
		case "date":
			//날짜
			if(!(dateTo == null || "".equals(dateTo))){
			adslist = amservice.selectSearchAdminGroupDate(Date.valueOf(dateFrom), Date.valueOf(dateTo), currentPage, limit); 
			listCount = amservice.groupAdminListCount3(dateFrom, dateTo);
			}else {
				dateTo += dateFrom;
				adslist = amservice.selectSearchAdminGroupDate(Date.valueOf(dateFrom), Date.valueOf(dateTo), currentPage, limit); 
				listCount = amservice.groupAdminListCount3(dateFrom, dateTo);
			}
			break;
		}
		
	
		
		
		int maxPage = (int)((double)listCount / limit + 0.9);
		int startPage = (((int)((double)currentPage / limit + 0.9))
				- 1) * limit + 1;
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage)
			endPage = maxPage;
		
		RequestDispatcher view = null;
		if(adslist !=  null) {
			view = request.getRequestDispatcher("views/admin/adminGroupList.jsp");
			request.setAttribute("list", adslist);
			request.setAttribute("page", currentPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("searchList", searchList);
			view.forward(request, response);
		} else {
			view = request.getRequestDispatcher("views/member/memberError.jsp");
			request.setAttribute("message", "모임 검색  조회 실패!");
			view.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	

}
