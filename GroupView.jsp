<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.GroupMgt, member.model.vo.Member, java.util.*" %>   
<%@ page import="group2.model.vo.Group" %>
<%
	ArrayList<Group> list = (ArrayList<Group>)request.getAttribute("list");
	Member member = (Member)session.getAttribute("loginMember");
	Group group = (Group)request.getAttribute("groupd");
	String gno = request.getAttribute("groupno").toString();

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임상세조회</title>
<script type="text/javascript" src="/semi/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/semi/resources/js/headerScript.js"></script>
<script type="text/javascript">
	function listView(){
		location.href = "/semi/glist?groupno=<%= group.getGroupNo()%>&page=1";
	}
</script>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div id="box" style="width:100%;">
	<div class="conBox" style="width:1000px; margin:0 auto;">
	<table align="center">
		<% if(member != null){ %>
			<% if(member.getUserId().equals(group.getLeaderId())) {%>	
				<div id="div0" style="width:1000px; height:200px; margin-bottom:20px;">
					<h3>공지사항 <button name="leader" onclick="listView();">모임장</button> </h3>
						<div id="div1" style="border:1px solid grey; border-radius:10px; width:1000px; height:180px; margin:auto; color:grey;"></div>					
				</div>
				<br>
				<div id="div3" style="width:1000px; height:20px; margin-bottom:20px;">
					<h3>모임 이름</h3>
						<%= group.getGroupName() %>
				</div>
				<div id="div4" name="div1" align="center" style="margin-bottom:20px;">
					<img class="meetinglist" src="/semi/resources/images/search/<%= group.getCgNo().trim() %>.jpg">
				</div>
				
				<div id="div5" style="width:1000px; height:200px;">
					<div id="div6" name="div2" style="border:1px solid grey; border-radius:10px; width:1000px; height:150px; margin-bottom:20px; color:grey;">
						<%= group.getGroupText() %>
					</div>
				</div>
				<div id="div7" style="width:1000px; height:200px;">
					<h3>모임장 한마디</h3>
						<div id="div8" style="border:1px solid grey; border-radius:10px; width:1000px; height:50px; color:grey; margin-bottom:20px;">
							<%= group.getLeaderComm() %>
						</div>
				</div>
				<% } else { %>
				<div id="div3" style="width:1000px; height:20px;  margin-top:50px; margin-bottom:20px;">
					<h3>모임 이름</h3>
						<%= group.getGroupName() %>
				</div>
				<div id="div4" name="div1" align="center" style="margin-bottom:20px;">
					<img class="meetinglist" src="/semi/resources/images/search/<%= group.getCgNo() %>.jpg">
				</div>
				<div id="div5" style="width:1000px; height:200px;">
					<div id="div6" name="div2" style="border:1px solid grey; border-radius:10px; width:1000px; height:150px; margin-bottom:20px; color:grey;">
						<%= group.getGroupText() %>
					</div>
				</div>
				<div id="div7" style="width:1000px; height:200px;">
					<h3>모임장 한마디</h3>
						<div id="div8" style="border:1px solid grey; border-radius:10px; width:1000px; height:50px; color:grey; margin-bottom:20px;">
							<%= group.getLeaderComm() %>
						</div>
				</div>
				<% }} else { %>
					<script>
						alert("로그인 하세요!!");
						location.href = "/semi/index.jsp";
					</script>
				<% } %>
	</table>
	</div></div>
&nbsp;
<%@include file="../common/footer.jsp"%>
</body>
</html>
