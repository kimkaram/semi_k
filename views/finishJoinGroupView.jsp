<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="createGroup.model.vo.Group, group2.model.vo.Group2, group.model.vo.GroupMgt" %>
<%
	Member member = (Member)session.getAttribute("loginMember");
	Group2 group = (Group2)request.getAttribute("groupd");
	Group g = (Group)request.getAttribute("g"); 
	GroupMgt gm = (GroupMgt)request.getAttribute("groupm");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 가입 완료 페이지</title>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div id="box" style="width:100%;">
		<div class="conBox" style="width:1000px; margin:0 auto;">
			<table  id="gsubtab" style="align:left; border-radius: 8px;position:fixed; left:10%; top:250px; width: 60px; height: 380px">
				<tr>
					<td style="background-image: -webkit-gradient(linear, 0% 0%,0% 100%, color-stop(0.2, rgb(82, 168, 232)), to(rgb(46, 118, 207)));"><a href="/semi/gdetail?group=<%= g.getGroupNo() %>">모임 홈으로</a></td>
				</tr>
				<tr>
		 			<td><a href="/semi/gdetail?group=<%= g.getGroupNo() %>&userid=<%= member.getUserId() %>" method="post">스케쥴러</a></td>
				</tr>
				<tr>
					<td><a href="/semi/gdetail?group=<%= g.getGroupNo() %>&userid=<%= member.getUserId() %>" method="post">게시판</a></td>
				</tr>
				<tr>
					<td><a href="/semi/gdetail?group=<%= g.getGroupNo() %>&userid=<%= member.getUserId() %>" method="post">모임 관리</a></td>
				</tr>
			</table>
	<br><br>
			<table align="center" id="joinFin">
				<tr>
					<td>
						<div style="align:center; width:400px; height:250px; padding: 10px;">
	<br><br><br><br><br><br>
						축하합니다.<br>
						새로운 모임에 가입되었습니다.<br>
						환영합니다~~~!!!!<br>
						</div>
					</td>
				</tr>
			</table>

			<form align="center" action="/semi/gdetail?group=<%= g.getGroupNo() %>&userid=<%= member.getUserId() %>" method="post">
			<br><input type="submit" value="확인" style="font-size: 18px;">
			</form>


		<%@ include file="../common/footer.jsp" %>
</body>
</html>
