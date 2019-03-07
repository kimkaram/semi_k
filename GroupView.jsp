<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.GroupMgt, member.model.vo.Member, java.util.*" %>   
<%@ page import="group2.model.vo.Group" %>
<%
	ArrayList<Group> list = (ArrayList<Group>)request.getAttribute("list");
	Member member = (Member)session.getAttribute("loginMember");
	Group group = (Group)request.getAttribute("groupd");
	System.out.println("groupDetail : " + group);
	/* ArrayList<GroupMgt> glist = (ArrayList<GroupMgt>)request.getAttribute("list");
	System.out.println("groupList : " + glist); */
	/* ArrayList<Group> glist = (ArrayList<Group>)request.getAttribute("glist");
	System.out.println("a : " + allist);
	System.out.println("m : " + member); */
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임상세조회</title>
<script type="text/javascript">
	function groupMember(){
		 /* location.href = "/semi/views/group/leaderListView.jsp";  */
			 <%-- location.href = "/semi/glist?groupno=<%= group.getGroupNo() %>"; --%>
		<%-- location.href= "/semi/gslist?groupno=<%= group.getGroupNo() %>";
		 location.href= "/semi/gslist?idsearch=<%= member.getUserId() %>"; --%>
	}
	
	<%-- function Leader(){
		<% if(group != null) { %>
		location.href = "/semi/views/group/leaderListView.jsp";
		<% } %>
	} --%>
</script>
<style>
	 /* #div1 {
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
		 
	}  */
</style>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<%-- <div name="group">
	<div id="div1" name="div1"style="width:1000px; height:200px;">
		<h3>공지제목
			<% if(member != null){ %>
				<button onclick="groupMember();">모임관리자</button>
			<% } %>
			
			
			
		</h3>
	<div id="div2" style="border:1px solid grey; border-radius:10px; width:1000px; height:200px; margin:auto; color:grey;">
		<!-- <h4><a href="#">공지 상세 내용</a></h4> -->
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
		<h4><a href="#">가입시 쓴 소개글</a></h4>
	</div>
	</div>
<br><br>
	<div id="div6" style="width:1000px; height:200px;">
		<h3>모임장 한마디</h3>
	<div id="div7" style="border:1px solid grey; border-radius:10px; width:1000px; height:50px; color:grey;">
		<h4><a href="#">즐겁게!</a></h4>
	</div>
	</div></div> --%>
	
	
				
	
	<table align="center">
	
	<div id="div0" style="width:1000px; height:200px; margin-bottom:20px;">
	<h3>공지사항</h3>
	<div id="div1" style="border:1px solid grey; border-radius:10px; width:1000px; height:180px; margin:auto; color:grey;">
	</div>					
	</div>
			
			<% if(member != null){ %>
				
	<!-- 				<div id="div0" style="width:1000px; height:20px; margin-bottom:20px;">
	<h3>공지사항</h3>
	<div id="div1" style="border:1px solid grey; border-radius:10px; width:1000px; height:200px; margin:auto; color:grey;">
	</div>					
	</div> -->
					
					<form action="/semi/glist" method="get" id="setRows">
						<div id="div2" name="div4" style="margin:auto;">
					<% if(member.getUserId().equals(group.getLeaderId())) {%>	
						<input type="submit" name="leader" value=<%= group.getGroupNo() %>>
					
						</div>
					</form>
					<%-- <%= group.getLeaderId() %>
					<%= group.getCgNo() %> --%>
					<div id="div3" style="width:1000px; height:20px; margin-bottom:20px;">
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
					<% } else { %>
				
					<%-- <%= group.getLeaderId() %>
					<%= group.getCgNo() %> --%>
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
					
					
			<% }} %>
		
	
	
	</table>
&nbsp;
<%@include file="../common/footer.jsp"%>
</body>
</html>
