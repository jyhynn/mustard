/**
 * registValidation
 */
$(function(){
	$("#form-signin").validate({
		
		rules:{
			name:{required: true, minlength: 2, maxlength: 10, validName:true},
			nick:{required: false, minlength: 2, maxlength: 20, validNick:true},
			password:{required: true, minlength: 8, maxlength: 15, validPassword:true},
			passwordCheck:{required: true, minlength: 8, maxlength: 15, equalTo: "#password"},
			email:{required: true, validEmail:true},
			agree_service:{required: true}
		},
		messages:{
			name:{required: "아이디는 필수 요소입니다.", minlength: "최소 2자리 이상 입력해주세요.", maxlength: "최대 10자리 이하로 입력해주세요."},
			nick:{minlength: "최소 2자리 이상 입력해주세요.", maxlength: "최대 20자리 이하로 입력해주세요."},
			password:{required: "비밀번호는 필수 요소입니다.", minlength: "최소 8자리 이상 입력해주세요.", maxlength: "최대 15자리 이하로 입력해주세요."},
			passwordCheck:{required:"비밀번호 재입력", equalTo: "위에 입력한 비밀번호와 동일하게 입력하세요."},
			email:{required: "이메일은 필수입니다."},
			agree_service:{required: "약관에 동의해주세요."}
		},
		//에러메시지 위치 지정
		errorElement: "span",
		errorPlacement: function(error, element) {
			// Append error within linked label
			$( element )
				.closest( "form" )
					.find( "label[for='" + element.attr( "id" ) + "']" ).html( error );
		}
	
	});
});
$.validator.addMethod("validEmail",function(value, element){
	return this.optional( element ) || /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/.test( value );
},'올바른 이메일 형식이 아닙니다.');	

$.validator.addMethod("validName",function(value, element){
	return this.optional( element ) || /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,10}$/.test( value );
},"영문 혹은 한글로 2~10자리로 입력해주세요.");	

$.validator.addMethod("validNick",function(value, element){
	return this.optional( element ) ||  /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,20}$/.test( value );
},"영문 혹은 한글로 2~20자 사이로 입력해주세요");	

$.validator.addMethod("validPassword",function(value, element){
	return this.optional( element ) || /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,12}$/.test( value );
},"숫자,영문자,특수문자 조합으로 8~15자리로 지정해주세요.");	