<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.GroupMgt, member.model.vo.Member, java.util.*" %>   
<%@ page import="group2.model.vo.Group2" %>
<%
	//전체 조회용 리스트
	ArrayList<Group2> list = (ArrayList<Group2>)request.getAttribute("list");
	//검색용 리스트
	//ArrayList<Group> adslist = (ArrayList<Group>)request.getAttribute("adslist");
	
	Member member = (Member)session.getAttribute("loginMember");
	int listCount = Integer.parseInt(request.getAttribute("listCount").toString());
	int startPage = Integer.parseInt(request.getAttribute("startPage").toString());
	int endPage = Integer.parseInt(request.getAttribute("endPage").toString());
	int maxPage = Integer.parseInt(request.getAttribute("maxPage").toString());			
	int currentPage = Integer.parseInt(request.getAttribute("page").toString());
	int searchList = Integer.parseInt(request.getAttribute("searchList").toString());
	
%>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 관리자 페이지</title>
<script type="text/javascript" src="/semi/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		showDiv();
		
		$("input[name=item]").on("change", function(){
			showDiv();
		});
	});
	
	function showDiv(){
			if($("input[name=item]").eq(0).is(":checked")){
				$("#titleDiv").css("display", "block");
				$("#dateDiv").css("display", "none");
			}
			
			if($("input[name=item]").eq(1).is(":checked")){
				$("#titleDiv").css("display", "none");
				$("#dateDiv").css("display", "block");
			}
		}

</script>
</head>
<body>
	<%@ include file = "../common/adminHeader.jsp"%>
	<hr style="clear:both;">
	<h3 align="center"><font color="grey">모임 목록</font></h3>
	
	<br><br>
	
	<center>
	<div>
	<h4>검색할 항목을 선택하시오.</h4>
	<input type="radio" name="item" value="title" checked> 제목 &nbsp; &nbsp; &nbsp; 
	<input type="radio" name="item" value="date"> 날짜
	</div>
	</center>
	<br><br>
	<div id="titleDiv">
	<form action="/semi/adgsearch?page=1" method="get" align="center" id="setRows">
	<input type="hidden" value="writer" name="search">
			<select name="cgno">
				<option value="">전체</option>
				<option value="c0001">IT</option>
				<option value="c0002">스포츠</option>
				<option value="c0003">음악</option>
				<option value="c0004">요리</option>
				<option value="c0005">독서</option>
				<option value="c0006">스터디</option>
				<option value="c0007">여행</option>
				<option value="c0008">자유</option>
			</select> 
			<input type="text" style="width: 300px;" name="groupname" placeholder="제목"></input> 
			<input type="submit" name="button" value="검색"></input>
	</input>		
	</form>
	</div>
	
	<div id="dateDiv">
	<form action="/semi/adgsearch" method="get" align="center" id="setRows">
			<input type="hidden" name="search" value="date">
			<label>날짜 : 		
			<input type="date" name="from"> - 
			<input type="date" name="to"></label>
			<input type="submit" name="button" value="검색"></input>
			</input>
	</form>
	</div>



	<br><br>

	<%if(list.size() != 0){ %>	
	<table align="center" border="1" cellspacing="0" width="700">
		<tr>
			<th>모임번호</th>
			<th>모임장 아이디</th>
			<th>카테고리 번호</th>
			<th>모임이름</th>
			<th>모임생성날짜</th>
			<th>수정</th>
			<th>탈퇴</th>
		</tr>
		<% for(int i = 0; i < list.size(); i++){ %>
		<tr>
		<td><%= list.get(i).getGroupNo() %></td>
		<td><%= list.get(i).getLeaderId() %></td>
		<td><%= list.get(i).getCgNo() %></td>
		<td><%= list.get(i).getGroupName() %></td>
		<td><%= list.get(i).getCreatetime() %></td>	
		<td align="center"><button onclick="location.href = '/semi/agudetail?groupNo=<%= list.get(i).getGroupNo() %>&page=<%= currentPage%>'">수정</button></td>
		<td align="center"><button onclick="location.href = '/semi/agdelete?gmdelete=<%= list.get(i).getGroupNo() %>&page=<%= currentPage%>'">삭제</button></td>
		</tr>
		<% } }else {%>
		<h3 align="center">조회된 모임이 없습니다.</h3>
	<%} %>		
	</table>

	<br>
	
 <!-- 페이징 처리 -->
<div style="text-align:center;">
<% if(currentPage == 1){ %>
	[맨처음]&nbsp;
	[이전]&nbsp;
<% }else{ %>
	<a href="/semi/adlist?page=1&">[맨처음]&nbsp;</a>
	<a href="/semi/adlist?page=<%= currentPage - 1 %>">[이전]&nbsp;</a>

<% }
	for(int p = startPage; p <= endPage; p++){ 
		if(p == currentPage){
		
%>
	<font color="red" size="4"><b>[<%= p %>]</b></font>
<% }else{ %>
	<a href="/semi/adlist?page=<%= p %>">
	<%= p %></a>
<% }} %>

<% if(currentPage >= maxPage){ %>
	[다음]&nbsp;
	[맨끝]&nbsp;
	
<% }else{ %>
	<a href="/semi/adlist?page=<%= currentPage + 1 %>">[다음]&nbsp;</a>
	<a href="/semi/adlist?page=<%= maxPage %>">[맨끝]&nbsp;</a>
<% } %>

</div>
	
<%@include file="../common/footer.jsp"%>

</body>
</html>
