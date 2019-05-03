<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<c:if test="${empty log }">
	<script>
		alert("로그인 후 이용가능합니다");
		location.href="/member/signin";		
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.js"></script>
<script src="/resources/js/messages_ko.js"></script>
<script src="/resources/js/registValidation.js"></script>
<script src="/resources/js/register.js"></script>
</head>
<body>
<div class="container mt-5">
		<div class="row">
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
						<h5>개인정보 변경</h5>
				</div>
				<ul class="list-group">
					<li class="list-group-item"><b>이메일 </b> <br>${log.email }</li>
					<li class="list-group-item"><b>지역 </b> 
						<div class="select-location">
							<select name="zip.shi" id="shi" >
								<option value="${log.zip.shi }">${log.zip.shi }</option>
							</select> 
							<select name="zip.gungu" id="gungu" >
								<option value="${log.zip.gungu }">${log.zip.gungu }</option>
							</select>
							<select name="zip.dong" id="dong" >
								<option value="${log.zip.dong }">${log.zip.dong }</option>
							</select>
							<button type="button" class="btn btn-outline-info change-loc">위치 변경</button>
							<button type="button" class="btn btn-outline-info go-change-loc">위치 변경</button>
						</div>
					</li>
					<li class="list-group-item"><b>비밀번호 </b> 
						<form id="chpw">
							<button type="button" class="btn btn-outline-info change-pw">비밀번호 변경</button><br>
							<input type="password" name="passwordCheck" id="passwordCheck" class="currentPassword mt-2" placeholder="현재 비밀번호" required/>
							<label for="passwordCheck" id="passwordCheck" class="currentPassword"></label>
							<button type="button" class="btn btn-outline-info currentPasswordCheck">현재 비밀번호 확인</button><br>
							
							<input type="password" name="newPassword" id="newPassword" class="mt-2" placeholder="새 비밀번호" required/>
							<label for="passwordCheck" id="newPassword"></label>
							<button type="button" class="btn btn-outline-info go-change-pw">비밀번호 변경하기</button>
						</form>
				</ul>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../../include/mypagetab.jsp"%>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			var logedMemNo = ${log.memNo};
			var logedPassword = "${log.password}";
			var currentPwd = '${log.password}';
			$("#passwordCheck").css("display","none");
			$("#newPassword").css("display","none");
			$(".go-change-loc").css("display","none");
			$(".go-change-pw").css("display","none");
			$(".currentPassword").css("display","none");
			$(".currentPasswordCheck").css("display","none");
			 $("select[name='zip.shi']").attr("disabled",true);
			 $("select[name='zip.gungu']").attr("disabled",true);
			 $("select[name='zip.dong']").attr("disabled",true);
			 $(".select-location").show();
			
			//지역변경
			$(".change-loc").on("click",function(){
				 $("select[name='zip.shi']").attr("disabled",false);
				 $("select[name='zip.gungu']").attr("disabled",false);
				 $("select[name='zip.dong']").attr("disabled",false);
				 $(".change-loc").css("display","none");
				 $(".go-change-loc").show();
				 $.getJSON({
						url : "/getShi",
						success : function(data) {
							console.log(data)
							$.each(data, function(i, zip) {
								$("#shi").append("<option value='" + zip.shi + "'>" + zip.shi + "</option>");
							});
						}
					});
					// 선택한 시에 따라 군구 목록 가져오기
					$("#shi").on("change",function() {
								$("#gungu option").remove();
								$("#donglist").html("");
								$("#gungu").append("<option value=''>---------군/구---------</option>")
								$.getJSON({
									url : "/getGungu",
									data : {
										shi : $("#shi").val()
									},
									success : function(data) {
										console.log(data)
										$.each(data, function(i, g) {
											$("#gungu").append(
													"<option value='" + g.gungu + "'>" + g.gungu + "</option>");
										});
									}
								});
							});

					// 선택값에 따른 읍동면 목록 가져오기
					$("#gungu").on("change",function() {
						$("#dong option").remove();
						$.getJSON({
							url : "/getDong",
							data : {shi : $("#shi").val(),
									gungu : $("#gungu").val()},
							success : function(data) {
								console.log(data)
								$.each(data, function(i, d) {
									$("#dong").append(
											"<option value='" + d.dong + "'>" + d.dong + "</option>");
								});
							}
						});

					});
				 
			});
			
			$(".go-change-loc").on("click",function(){
				$.ajax({
					url: '/member/changeLoc',
					type : 'post',
					data : {memNo : logedMemNo,
							email : "${log.email}",
							password : "${log.password}",
							shi : $("#shi").val(),
							gungu : $("#gungu").val(),
							dong : $("#dong").val()},
					success:function(data){
						if(data=="changeSuccess"){
							alert("지역이 변경되었습니다.");
							href.location="/member/changeMyInfo";
						}else{
							alert("지역변경실패.");
						}
					}
				})//ajax
			});
			
			
			
			//비밀번호 변경
			$(".change-pw").on("click",function(){
				$(".change-pw").fadeOut(500);
				$("#passwordCheck").fadeIn(500);
				$(".currentPasswordCheck").fadeIn(500);
				$(".currentPasswordCheck").on("click",function(){
					if(currentPwd!=$("#passwordCheck").val()){
						alert("현재 비밀번호와 일치하지 않습니다.");
					}else{
						$(".go-change-pw").fadeIn(500);
						$("#newPassword").fadeIn(500);
					}
				})
			});
					
			$(".go-change-pw").on("click",function(){
				$.ajax({
					url: '/member/changePwd',
					type : 'post',
					data : {memNo : logedMemNo,
							newPassword : $("#newPassword").val() },
					success:function(data){
						if(data=="changeSuccess"){
							alert("비밀번호가 변경되었습니다. 재로그인 해주시기 바랍니다.");
							location.href='/member/signin';
						}else{
							alert("비밀번호 변경실패.");
						}
					}
					
				})//ajax
				
			})
	$("#chpw").validate({
			rules:{ newPassword:{required: true, minlength: 8, maxlength: 15, validPassword:true} },
			messages:{newPassword:{required:"새 비밀번호를 입력해주세요"}},
			//에러메시지 위치 지정
			errorElement: "span",
			errorPlacement: function(error, element) {
				$( element ).closest( "form" ).find( "label[for='" + element.attr( "id" ) + "']" ).html( error );
			}
		});
		
	$.validator.addMethod("validPassword",function(value, element){
		return this.optional( element ) || /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,12}$/.test( value );
	},"숫자,영문자,특수문자 조합으로 8~15자리로 지정해주세요.");	
		
	});
	</script>
	
<%@ include file="../../include/footer.jsp"%>