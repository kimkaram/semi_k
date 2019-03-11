<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.GroupMgt, member.model.vo.Member, java.util.*" %>   
<%@ page import="group2.model.vo.Group2" %>
<%
	ArrayList<Group2> adlist = (ArrayList<Group2>)request.getAttribute("adlist");
	ArrayList<Group2> adslist = (ArrayList<Group2>)request.getAttribute("adslist"); 
	Member member = (Member)session.getAttribute("loginMember");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();			
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int searchList = ((Integer)request.getAttribute("searchList")).intValue();
	
	String gname = request.getAttribute("groupname").toString();
	String cgno = request.getAttribute("cgno").toString(); 
%>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 관리자 페이지</title>

</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<hr style="clear:both;">
	<h3 align="center"><font color="grey">모임회원 목록</font></h3>
	
	<br><br>
	<form action="/semi/adgsearch" method="get" align="center" id="setRows">
		<div class="box">
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
			<input type="submit" name="button" id="button" value="검색"></input>
		</div>
	</form>

	<br><br>
	<% if(adlist != null || adslist == null) { %>
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
		
		<% for(int i = 0; i < adlist.size(); i++){ %>
		<tr>
		<td><%= adlist.get(i).getGroupNo() %></td>
		<td><%= adlist.get(i).getLeaderId() %></td>
		<td><%= adlist.get(i).getCgNo() %></td>
		<td><%= adlist.get(i).getGroupName() %></td>
		<td><%= adlist.get(i).getCreatetime() %></td>	
		<td align="center"><button onclick="location.href = '/semi/agdelete?gmdelete=<%= adlist.get(i).getLeaderId() %>&page=<%= currentPage%>'">수정</button></td>
		<td align="center"><button onclick="location.href = '/semi/agdelete?gmdelete=<%= adlist.get(i).getGroupNo() %>&page=<%= currentPage%>'">삭제</button></td>
		</tr>
		<% } %>
	</table>
	<br>
	<!-- http://127.0.0.1:8880/semi/glist?page=1&groupno=G_1&idsearch=0 -->
<!-- 페이징 처리 -->
<div style="text-align:center;">
<% if(searchList == 0){  %>
<% if(currentPage == 1){ %>
	[맨처음]&nbsp;
	[이전]&nbsp;
<% }else{ %>
	<a href="/semi/adlist?page=1">[맨처음]&nbsp;</a>
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
<% }} %>
</div>
	<% } %>
	
	<%if(adslist != null || adlist == null) { %>
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
		
		<% for(int i = 0; i < adslist.size(); i++){ %>
		<tr>
		<td><%= adslist.get(i).getGroupNo() %></td>
		<td><%= adslist.get(i).getLeaderId() %></td>
		<td><%= adslist.get(i).getCgNo() %></td>
		<td><%= adslist.get(i).getGroupName() %></td>
		<td><%= adslist.get(i).getCreatetime() %></td>	
		<td align="center"><button onclick="location.href = '/semi/mdel?mdelete=<%= adslist.get(i).getLeaderId() %>&page=<%= currentPage%>'">수정</button></td>
		<td align="center"><button onclick="location.href = '/semi/agdelete?gmdelete=<%= adslist.get(i).getGroupNo() %>&page=<%= currentPage%>'">삭제</button></td>
		</tr>
		<% } %>
	</table>
<div style="text-align:center;">
<% if(searchList == 1){  %>
<% if(currentPage == 1){ %>
	[맨처음]&nbsp;
	[이전]&nbsp;
<% }else{ %>
	<a href="/semi/adslist?page=1&cgno=<%= cgno %>&groupname=<%= gname  %>">[맨처음]&nbsp;</a>
	<a href="/semi/adslist?page=<%= currentPage - 1 %>&cgno=<%= cgno %>&groupname=<%= gname  %>">[이전]&nbsp;</a>

<% }
	for(int p = startPage; p <= endPage; p++){ 
		if(p == currentPage){
		
%>
	<font color="red" size="4"><b>[<%= p %>]</b></font>
<% }else{ %>
	<a href="/semi/adslist?page=<%= p %>&cgno=<%= cgno %>&groupname=<%= gname  %>">
	<%= p %></a>
<% }} %>

<% if(currentPage >= maxPage){ %>
	[다음]&nbsp;
	[맨끝]&nbsp;
	
<% }else{ %>
	<a href="/semi/adslist?page=<%= currentPage + 1 %>&cgno=<%= cgno %>&groupname=<%= gname  %>">[다음]&nbsp;</a>
	<a href="/semi/adslist?page<%= maxPage %>&cgno=<%= cgno %>&groupname=<%= gname  %>">[맨끝]&nbsp;</a>
<% }} %>
	</div>
		<% } %>
&nbsp;
<%@include file="../common/footer.jsp"%>

</body>
</html>
