<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.GroupMgt, member.model.vo.Member, java.util.*" %>   
<%@ page import="leader.model.vo.Leader" %>
<%
	/* ArrayList<GroupMgt> allist = (ArrayList<GroupMgt>)request.getAttribute("allist");*/
	Member member = (Member)session.getAttribute("loginMember");
	GroupMgt group = (GroupMgt)request.getAttribute("groupno");
	 Leader leader = (Leader)session.getAttribute("leaderUser"); 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임상세조회</title>
<script type="text/javascript">
	function groupMember(){
		
			<%-- location href = "/semi/glist?groupno=<%= leader.getGroupNo() %>"; --%>
		<%-- location.href= "/semi/gslist?groupno=<%= group.getGroupNo() %>";
		 location.href= "/semi/gslist?idsearch=<%= member.getUserId() %>"; --%>
	}
</script>
<style>
	#div1 {
		text-align:left;
		margin:auto;
	}
	
	#div4 {
		 margin:auto;
		 text-align:left;
	}
	
	#div6 {
		margin:auto;
		text-align:left;
	}
	
	#div7 {
		margin:auto; 
		padding:5px;
	}
</style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<div id="div1"style="width:1000px; height:200px;">
		<h3>공지제목
			<% if(member != null){ %>
				<button onclick="groupMember();">모임관리자</button>
			<% } %>
		</h3>
	<div id="div2" style="border:1px solid grey; border-radius:10px; width:1000px; height:200px; margin:auto; color:grey;">
		<h4>공지 상세 내용</h4>
	</div>
	</div>
<br><br>
	<div id="div3" align="center" style="margin-top:20px;">
		<img class="grouppic1"
				src="../../resources/images/book.jpg"
				style="width: 1000px; height: 200px;">
	</div>
	<div id="div4" style="width:1000px; height:200px;">
		<h3>모임 이름</h3>
	<div id="div5" style="border:1px solid grey; border-radius:10px; width:1000px; height:200px; margin:auto; color:grey;">
		<h4>가입시 쓴 소개글</h4>
	</div>
	</div>
<br><br>
	<div id="div6" style="width:1000px; height:200px;">
		<h3>모임장 한마디</h3>
	<div id="div7" style="border:1px solid grey; border-radius:10px; width:1000px; height:50px; color:grey;">
		<h4>즐겁게!</h4>
	</div>
	</div>
&nbsp;
<%@include file="../common/footer.jsp"%>
</body>
</html>
