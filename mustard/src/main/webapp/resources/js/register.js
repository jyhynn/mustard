/**
 * register
 */

$(function() {
	$(".tip").css("display", "none");
	console.log("email?? >> " + $("#email").val());
	if ($("#email").val() == "") {
		$(".form-start-email").css("display", "none");
		$(".start-email-info").css("display", "none");
		$(".select-location").css("display","none");
		$(".step").css("display","none");
		$(".goRegist").css("display", "none");
	} else {
		$(".start-email").css("display", "none");
		$(".start-kakao").css("display", "none");
		$(".email-msg").show();
	}
	
	// 각 input영역 클릭시 입력안내문구 나타내기
	$("#email").on("focus", function() {
		$(".tip-email").show();
	});
	$("#name").on("focus", function() {
		$(".tip-name").show();
	});
	$("#nick").on("focus", function() {
		$(".tip-nick").show();
	});
	$("#password").on("focus", function() {
		$(".tip-pwd").show();
	});
	$("#passwordCheck").on("focus", function() {
		$(".tip-pwdCk").show();
	});
	// 이메일로 시작하기 버튼 클릭시 이메일 인증폼 나타내기
	$(".start-email").on("click", function() {
		$(".form-start-email").fadeIn(500);
	});
	
	// 이메일 인증요청
	$(".auth-email").on("click", function(e) {
		var emailReg = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		if(!emailReg.test($("#email").val())){
				e.preventDefault();
		}else{
			$(".email-msg").show();
			$.ajax({
				url : 'checkEmail',
				type : 'post',
				data : {
					email : $("#email").val()
				},
				dataType : 'text',
				success : function(result) {
					if (result == "requestCheckEmailSuccess") {
						console.log(result);
						$(".email-msg").html("메일 수신함에서 인증버튼을 클릭해주시면 다음단계로 넘어갑니다.");
					} else if (result == "exist") {
						$(".email-msg").html("이미 존재하는 이메일입니다.");
					} else if(result=="notyetauth"){
						$(".email-msg").html("메일 수신함에서 인증버튼을 클릭해주세요.");
					}
				}
	
			});
		}
	});// 이메일 인증요청

	// 호출과 동시에 시 목록 가져오기
	$.getJSON({
		url : "/getShi",
		success : function(data) {
			console.log(data)
			$.each(data, function(i, zip) {
				$("#shi").append(
						"<option value='" + zip.shi + "'>" + zip.shi
								+ "</option>");
			});
		}
	});
	// 선택한 시에 따라 군구 목록 가져오기
	$("#shi").on(
			"change",
			function() {
				$("#gungu option").remove();
				$("#donglist").html("");
				$("#gungu").append(
						"<option value=''>---------군/구---------</option>")
				$.getJSON({
					url : "/getGungu",
					data : {
						shi : $("#shi").val()
					},
					success : function(data) {
						console.log(data)
						$.each(data, function(i, g) {
							$("#gungu").append(
									"<option value='" + g.gungu + "'>"
											+ g.gungu + "</option>");
						});
					}
				});
			});

	// 선택값에 따른 읍동면 목록 가져오기
	$("#gungu").on(
			"change",
			function() {
				$("#donglist").html("");
				$.getJSON({
					url : "/getDong",
					data : {
						shi : $("#shi").val(),
						gungu : $("#gungu").val()
					},
					success : function(data) {
						console.log(data)
						$.each(data, function(i, d) {
							$("#donglist").append(
									"<option value='" + d.dong + "'>"
									+ d.dong + "</option>");
						});
					}
				});

			});
	// agree_all 체크시 다른 체크박스 모두 선택되게
	$("#agree_all").click(function() {
		// 클릭되었으면
		if ($("#agree_all").prop("checked")) {
			// input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
			$("input[type='checkbox']").prop("checked", true);
			// 클릭이 안되있으면
		} else {
			// input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
			$("input[type='checkbox']").prop("checked", false);
		}
	})
});