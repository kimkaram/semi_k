<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.Member, group2.model.vo.Group2, createGroup.model.vo.Group, group.model.vo.GroupMgt, groupPay.model.vo.GroupPay"%>
<%
	Member member = (Member)session.getAttribute("loginMember");
	Group2 group = (Group2)request.getAttribute("groupd");
	Group g = (Group)request.getAttribute("g"); 
	GroupPay gpay = (GroupPay)request.getAttribute("gpay");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 가입</title>
<link rel="stylesheet" href="/semi/resources/css/mainview.css" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>

<script type="text/javascript">
	var member = "<%= member%>";
	if(member == "null"){
		location.href="/semi/views/member/login.jsp";
	}

		function requestPay(){	
			IMP.init('iamport'); //iamport 대신 자신의 "가맹점 식별코드"를 사용하시면 됩니다
			IMP.request_pay({
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '결제테스트',
				amount : <%= g.getPrice() %>,
				buyer_email : 'iamport@siot.do',
				buyer_name : '구매자',
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울특별시 강남구 삼성동',
				buyer_postcode : '123-456'
			}, function(rsp) {
				if ( rsp.success ) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
					alert(msg);
					location.href = "/semi/payServlet?userid=<%= member.getUserId() %>&gno=<%= g.getGroupNo() %>&price=<%= g.getPrice() %>";
					<%-- location.href = "/semi/jfinish?group=<%= g.getGroupNo() %>&mem=<%= member.getUserId() %>"; --%>
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					alert(msg);
					history.back();
				}}
			});
		};
</script>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div id="box" style="width:100%;">
	<div class="conBox" style="width:1000px; margin:0 auto;">
	<table id="subtab" style="border:1px solid #e2e2e2;align:left; border-radius: 8px;position:fixed; left:10%; top:250px; width: 60px; height: 380px">
	<tr>
		<td style="background-image: -webkit-gradient(linear, 0% 0%,0% 100%, color-stop(0.2, rgb(82, 168, 232)), to(rgb(46, 118, 207)));"><a href="/semi/gdetail?group=<%= g.getGroupNo() %>">모임 홈으로</a></td>
	</tr>
	<tr>
		 <td><a href="/semi/gjoin?group=<%= g.getGroupNo() %>">스케쥴러</a></td>
	</tr>
	<tr>
		<td><a href="/semi/gjoin?group=<%= g.getGroupNo() %>">게시판</a></td>
	</tr>
	<tr>
		<td><a href="/semi/gjoin?group=<%= g.getGroupNo() %>">모임 가입</a></td>
	</tr>
</table>
</div>
</div>
<br><br>
<table align="center" id="payAgree">
	<tr>
		<th><h3>모임명 : <%= g.getGroupName() %> </h3> </th><br>
	</tr>
	<tr>
	<% if(gpay == null) { %>
		<th><h3>결제금액 : 0 원</h3></th><br> 
	<% } else { %>
		<th><h3>결제금액 : <%= gpay.getPrice() %>원</h3></th>
	<% } %>
	</tr>
	<tr>
		<th style="color:black"><h3>결제 동의 상세 내용</h3></th><br>
	</tr>
	<tr>
		<td>
			<div style="overflow: scroll; width:600px; height:250px; padding: 10px;">
			<br>
			모임결제 및 이용동의 약관 <br>
			제1장 총칙<br>
			제1조 (목적)<br>
			이 약관은 주식회사 다날 및 주식회사 케이지모빌리언스(이하 통칭하여 ‘회사’라 함)가 제공하는<br>
			결제 서비스의 이용과 관련하여 회사와 이용자와의 권리, 의무, 책임사항 및 기타 필요한 사항을 규정함을 목적으로 합니다.<br>
			제2조 (용어의 정의)<br>
			이 약관에서 정하는 용어의 정의는 다음과 같습니다.<br>
			1. ‘이용자'라 함은 이 약관에 동의하고 회사가 제공하는 휴대폰 간편결제 서비스를 이용하는 자를 말합니다.<br>
			2. ‘휴대폰간편결제 서비스’란 ‘이용자’가 휴대용 단말기 등 각종 유무선 기기를 통하여 자신의 정보를 입력하여 <br>
				서비스 등록 후에는 휴대폰번호와 비밀번호의 입력만으로 결제를 요청할 수 있는 서비스를 말합니다.<br>
			3. '비밀번호'라 함은 휴대폰 간편결제 서비스를 이용하기 위하여 필요한 인증 수단으로서 이용자가 본인임을 사전에<br>
				확인하고 스스로 설정한 6자리 숫자의 조합을 말합니다.<br>
			제3조 (약관의 명시 및 효력변경)<br>
			1. 회사는 이용자가 휴대폰 간편결제 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.<br>
			2. 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.<br>
			3. 회사가 이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 제 1항의 방식에 따라 그 개정약관을 적용일자 7일 전부터 적용일자 전일까지 공지합니다.<br>
			    다만, 이용자에게 불리하거나 중요한 사항을 변경하는 경우에는 적용일자 30일 이전에 공지하며, 공지 외에 이용자의 전자우편 등의 전자적 수단을 통해 따로 명확히 통지합니다.<br>
			4. 회사가 전 항에 따라 개정약관을 공지 또는 통지하면서 이용자에게 개정약관 적용일자 전까지 의사표시를 하지 않으면 개정약관에 동의한 것으로 본다는 뜻을 명확하게 공지 또는 통지하였음<br>
			   에도 이용자가 명시적으로 거부의사를 표명하지 아니한 경우 이용자가 개정약관에 동의한 것으로 봅니다.<br>
			5. 이용자가 개정약관의 내용에 동의하지 않는 경우 회사는 해당 이용자에 대하여 개정약관의 내 용을 적용할 수 없으며,<br>
			   이 경우 이용자는 이용계약을 해지할 수 있습니다. 다만, 회사가 개정약관에 동의하지 않은 이용자에게 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는<br>
			    해당 이용자와의 이용계약을 해지할 수 있습니다.<br>
			제2장 서비스 이용<br>
			제4조 (이용 계약의 성립)<br>
			1. 휴대폰 간편결제 서비스 이용계약은 이용자가 되고자 하는 자가 회사가 정한 가입 절차와 방법에 따라 휴대폰 간편결제 서비스 이용신청을 하고, <br>
			   회사가 이러한 신청에 대하여 승낙함으로써 체결됩니다.<br>
			2. 서비스 이용자가입 시 이 약관의 동의 란에 체크하면 이 약관에 동의하는 것으로 간주됩니다.<br>
			3. 회사는 다음 각 호에 해당하는 신청에 대하여는 승인을 하지 않거나 사후에 이용의 제한 또는 이용계약을 해지할 수 있습니다.<br>
				1) 회사의 실명 확인절차에서 실명기입정보와 사실여부가 일치하지 아니하는 경우<br>
				2) 이미 가입된 이용자와 이름 및 개인정보가 이용자정보와 입력정보가 동일한 경우<br>
				3) 등록내용에 허위 정보를 기재하거나, 기재누락, 오기가 있는 경우<br>
				4) 기타 이 약관에 위배되거나 위법 또는 부당한 이용신청임이 확인된 경우 및 회사가 합리적인판단에 의하여 필요하다고 인정하는 경우<br>
				5) 관계법령에 위배되거나 사회의 안녕질서 혹은 미풍양속을 저해할 수 있는 목적으로 신청한 경우<br>
				6) 이용자의 귀책사유로 인하여 승인이 불가능하거나 기타 규정한 제반 사항을 위반하여 신청하는 경우<br>
				7) 회사는 이용자의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다.<br>
				8) 회사는 서비스관련설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.<br>
				9) 제8조 회원의 의무를 위반하는 경우<br>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			<input type="checkbox" id="scheck" name="check">
			<label for="scheck">결제  내용에 동의하시겠습니까?</label>
		</td>
	</tr>	
</table>	
	<%-- <form align="center" name="frmJoin" action="/semi/jfinish?group=<%= g.getGroupNo() %>&mem=<%= member.getUserId() %>" method="post" onsubmit="return checkSubmit();"> --%>
		<br>
		<center><button style="width: 50px; height: 30px;" id="check_module" onclick="requestPay()">결제</button></center>
	<!-- </form> -->
	<%@ include file="../common/footer.jsp" %>
</body>
</html>
