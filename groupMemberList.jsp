<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.GroupMgt, member.model.vo.Member, java.util.*" %>   
<%@ page import="leader.model.vo.Leader" %>
<%
	ArrayList<GroupMgt> alist = (ArrayList<GroupMgt>)request.getAttribute("alist");
	Member member = (Member)session.getAttribute("loginMember");
	GroupMgt group = (GroupMgt)request.getAttribute("group");
	/* Leader leader = (Leader)session.getAttribute("leaderUser"); */
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임번호에 대한 전체 조회 리스트 페이지</title>
	<script type="text/javascript">
		function searchId() {
			location href = "/semi/gmlist?idsearch=<%= member.getUserId() %>";
		}
		
		function deleteGroupMember() {
			location href = "/semi/mdel?mdelete=<%= member.getUserId() %>";
		}
	</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<hr style="clear:both;">
	<h3 align="center"><font color="grey">모임회원 목록</font></h3>
	
	<br><br>
	<form action="/semi/mlist" method="get" align="center" id="setRows">
		<div class="container" align="center" style="margin-bottom:20px;">
			<input type="text" placeholder="아이디검색" name="idsearch"></input>
			<button onclick="searchId();">검색</button>
			<!-- onclick="searchId();"  -->
		</div>
	</form>

	<table align="center" border="1" cellspacing="0" width="700">
		<tr>
			<th>아이디</th>
			<th>모임번호</th>
			<th>모입 가입 날짜</th>
			<th>탈퇴</th>
		</tr>
		
		<% for(int i = 0; i < alist.size(); i++){ %>
		<tr>
		<td><%= alist.get(i).getUserId() %></td>
		<td><%= alist.get(i).getGroupNo() %></td>
		<td><%= alist.get(i).getGroupEnrolltime() %></td>		
		<td align="center"><input type="button" name="mdelete" value="탈퇴" onclick="deleteGroupMember();"></td>
		</tr>
		<% } %>
	</table>
	&nbsp;
	<%@include file="../common/footer.jsp"%>
</body>
</html>
