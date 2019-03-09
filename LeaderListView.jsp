<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.GroupMgt, member.model.vo.Member, java.util.*" %>   
<%@ page import="group2.model.vo.Group" %>
<%
	ArrayList<GroupMgt> glist = (ArrayList<GroupMgt>)request.getAttribute("glist");
	ArrayList<GroupMgt> list = (ArrayList<GroupMgt>)request.getAttribute("list"); 
	Member member = (Member)session.getAttribute("loginMember");
	/* GroupMgt g = (GroupMgt)request.getAttribute("gdelete"); */
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();			
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int searchList = ((Integer)request.getAttribute("searchList")).intValue();
	String gno = request.getAttribute("groupNo").toString();
	String userId = request.getAttribute("idsearch").toString();
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 리스트 페이지</title>
<script type="text/javascript" src="/semi/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/semi/resources/js/headerScript.js"></script>

</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<hr style="clear:both;">
	<h3 align="center"><font color="grey">모임회원 목록</font></h3>
	
	<br><br>
	<form action="/semi/gmlist?groupno=<%= gno %>" method="post" align="center" id="setRows">
		<div class="container" align="center" style="margin-bottom:20px;">
			<input type="text" placeholder="아이디검색" name="idsearch"></input>
			<input type="submit" name="button" id="button" value="검색"></input>
		</div>
	</form>
	<% if(glist != null || list == null) { %>
	<table align="center" border="1" cellspacing="0" width="700">
		<tr>
			<th>아이디</th>
			<th>모임번호</th>
			<th>모입 가입 날짜</th>
			<th>탈퇴</th>
		</tr>
		
		<% for(int i = 0; i < glist.size(); i++){ %>
		<tr>
		<td><%= glist.get(i).getUserId() %></td>
		<td><%= glist.get(i).getGroupNo() %></td>
		<td><%= glist.get(i).getGroupEnrolltime() %></td>		
		<td align="center"><button onclick="location.href = '/semi/mdel?mdelete=<%= glist.get(i).getUserId() %>&groupno=<%= gno %>&page=<%= currentPage%>'">탈퇴</button></td>
		</tr>
		<% } %>
	</table>
	<br>
	
<!-- 페이징 처리 -->
<div style="text-align:center;">
<% if(searchList == 0){  %>
<% if(currentPage == 1){ %>
	[맨처음]&nbsp;
	[이전]&nbsp;
<% }else{ %>
	<a href="/semi/glist?page=1&groupno=<%=gno%>&idsearch=<%=userId  %>">[맨처음]&nbsp;</a>
	<a href="/semi/glist?page=<%= currentPage - 1 %>&groupno=<%=gno  %>">[이전]&nbsp;</a>

<% }
	for(int p = startPage; p <= endPage; p++){ 
		if(p == currentPage){
		
%>
	<font color="red" size="4"><b>[<%= p %>]</b></font>
<% }else{ %>
	<a href="/semi/glist?page=<%= p %>&groupno=<%=gno %>">
	<%= p %></a>
<% }} %>

<% if(currentPage >= maxPage){ %>
	[다음]&nbsp;
	[맨끝]&nbsp;
	
<% }else{ %>
	<a href="/semi/glist?page=<%= currentPage + 1 %>&groupno=<%=gno  %>">[다음]&nbsp;</a>
	<a href="/semi/glist?page=<%= maxPage %>&groupno=<%= gno %>">[맨끝]&nbsp;</a>
<% }} %>
</div>
	<% } %>
	
	<%if(list != null || glist == null) { %>
		<table align="center" border="1" cellspacing="0" width="700">
		<tr>
			<th>아이디</th>
			<th>모임번호</th>
			<th>모입 가입 날짜</th>
			<th>탈퇴</th>
		</tr>
			<% for(int i = 0; i < list.size(); i++){ %>
			<tr>
				<td><%= list.get(i).getUserId() %></td>
				<td><%= list.get(i).getGroupNo() %></td>
				<td><%= list.get(i).getGroupEnrolltime() %></td>		
				<td align="center"><button onclick="location.href = '/semi/mdel?mdelete=<%= list.get(i).getUserId() %>&groupno=<%= gno %>&page=<%= currentPage%>'">탈퇴</button></td>
			</tr>
			<% } %>
	</table>
<div style="text-align:center;">
<% if(searchList == 1){  %>
<% if(currentPage == 1){ %>
	[맨처음]&nbsp;
	[이전]&nbsp;
<% }else{ %>
	<a href="/semi/gmlist?page=1&groupno=<%=gno%>&idsearch=<%=userId  %>">[맨처음]&nbsp;</a>
	<a href="/semi/gmlist?page=<%= currentPage - 1 %>&groupno=<%=gno  %>&idsearch=<%=userId  %>">[이전]&nbsp;</a>

<% }
	for(int p = startPage; p <= endPage; p++){ 
		if(p == currentPage){
		
%>
	<font color="red" size="4"><b>[<%= p %>]</b></font>
<% }else{ %>
	<a href="/semi/gmlist?page=<%= p %>&groupno=<%=gno %>&idsearch=<%=userId  %>">
	<%= p %></a>
<% }} %>

<% if(currentPage >= maxPage){ %>
	[다음]&nbsp;
	[맨끝]&nbsp;
	
<% }else{ %>
	<a href="/semi/gmlist?page=<%= currentPage + 1 %>&groupno=<%=gno  %>&idsearch=<%=userId  %>">[다음]&nbsp;</a>
	<a href="/semi/gmlist?page<%= maxPage %>&groupno=<%= gno %>&idsearch=<%=userId  %>">[맨끝]&nbsp;</a>
<% }} %>
	</div>
		<% } %>
&nbsp;
<%@include file="../common/footer.jsp"%>
</body>
</html>
