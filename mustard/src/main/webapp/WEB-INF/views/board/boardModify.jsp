<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty log }">
	<script>
		alert("로그인 후 이용가능합니다");
		location.href="/member/signin";		
	</script>
</c:if>
<c:if test="${log.memNo != board.memNo }">
	<script>
		alert("작성자만 이용가능합니다");
		location.href="history.back()";		
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/editor/froala_editor.css">
<link rel="stylesheet" href="/resources/editor/froala_style.css">
<link rel="stylesheet" href="/resources/css/plugins/code_view.css">
<link rel="stylesheet" href="/resources/css/plugins/image_manager.css">
<link rel="stylesheet" href="/resources/css/plugins/image.css">
<link rel="stylesheet" href="/resources/css/plugins/table.css">
<link rel="stylesheet" href="/resources/css/plugins/video.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.js"></script>
<script src="/resources/js/messages_ko.js"></script>
<script src="/resources/js/registValidation.js"></script>
<script src="/resources/editor/froala_editor.min.js"></script>
</head>
<body>
<div class="container mt-5">
	<div class="row">
		<div class="col-md-9 order-md-1 font-jeju ">
			<c:if test="${bno==2 }">
				<h3 class="mb-3">정보게시판 수정</h3>
			</c:if>
			<c:if test="${bno==3 }">
				<h3 class="mb-3">지역게시판 수정</h3>
			</c:if>
			<c:if test="${bno==4 }">
				<h3 class="mb-3">정보게시판 수정</h3>
			</c:if>
			<c:if test="${bno==5 }">
				<h3 class="mb-3">자유게시판 수정</h3>
			</c:if>
			<form id="boardModify" action="boardModify" method="post">
				<div class="list-group-item mb-3 p-0">
					<input class="custom-form-control" type="text" id="title" name="title" placeholder="제목" required="required" value="${board.title }"/>
					<input class="custom-form-control" type="hidden" name="board_no" id="board_no" value="${board.board_no}"/>
					<input class="custom-form-control" type="hidden" id="article_no" name="article_no" value="${board.article_no }"/>
					<input class="custom-form-control" type="hidden" name="writer" value="${board.nick}"/>	<!-- ${logon.nick } -->
					<input class="custom-form-control" type="hidden" name="memNo" value="${board.memNo}"/><!-- ${logon.memNo } -->
					</div>
				<div class="list-group-item p-0 mb-3">
					<textarea id="froala-editor" class="form-control m-0 h-50" placeholder="내용을 입력하세요" name="content" required="required" rows="50" cols="">${board.content }</textarea>
				</div>
				<!-- 첨부파일 -->
				<ul class="list-group">
					<li class="list-group-item attachBtn">
						<input type="file" name="uploadFile" multiple="multiple"/>
					</li>
					<li class="list-group-item uploadevent uploadResult">
						<ul></ul>
					</li>
				</ul>
				<!-- 등록 -->
				<div class="mt-4">
					<button type="submit" class="btn btn-warning btn-modify">수정</button>
					<button type="button" class="btn btn-warning btn-return" onclick="history.back();">취소</button>
				</div>
			</form>
		</div>
		<div class="col-md-3 order-md-2 mb-4 font-jeju">
			<%@ include file="../include/trends.jsp" %>
		</div>
	</div>
</div>
<script>
	$(function(){
		var cloneObj = $(".attachBtn").clone();
		var articleNo = ${board.article_no };
		$('textarea#froala-editor').froalaEditor();
		//validation
		$(".btn-modify").on("click",function(e){
			e.preventDefault();
			if($("#title").val()==""){
				alert("제목을 입력해주세요.");
			}
			if($("#froala-editor").val()==""){
				alert("내용을 입력해주세요.");
			}
			
			var str = "";
			$(".uploadResult ul li").each(function(i,obj){
				var job=$(obj);
				str+="<input type='hidden' name='attach[" + i + "].uuid' value='" + job.data("uuid") + "'>";
				str+="<input type='hidden' name='attach[" + i + "].uploadPath' value='" + job.data("path") + "'>";
				str+="<input type='hidden' name='attach[" + i + "].fileName' value='" + job.data("filename") + "'>";
				str+="<input type='hidden' name='attach[" + i + "].fileType' value='" + job.data("type") + "'>";
				str+="<input type='hidden' name='attach[" + i + "].board_no' value='" + $("#board_no").val() + "'>";
				str+="<input type='hidden' name='attach[" + i + "].article_no' value='" + articleNo + "'>";
			});
			if($("#title").val()!="" && $("#froala-editor").val()!=""){
				$("#boardModify").append(str).submit();
			}
		});
		//페이지 로드 되자마자 첨부된 파일들 불러오기
		$.getJSON({
			url : 'BoardgetAttachList',
			data : {article_no:articleNo},
			success:function(data){
				console.log(data);
				var uploadResult = $(".uploadResult ul");
				var str="";
				//				.each : 루프돌리기. for(Arr obj : uploadResultArr)이랑 같음. i:1씩 증가될 변수. obj : uploadResultArr에 들어온 값 한줄씩.
				$(data).each(function(i,obj){
					if(obj.fileType){//true : 이미지
									//uploadPath에 d/upload/2019/04/16 들어있음. 
									//encodeURIComponent : 클라이언트 쪽에서 인코딩함
						//썸네일 이미지 경로
						var filePath = encodeURIComponent(obj.uploadPath + "\\thum_" + obj.uuid + "_" + obj.fileName);
					
						str+="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
						str+="<span>" + obj.fileName + "</span>";
						str+="<button type='button' class='btn btn-warning btn-circle' data-file='" + filePath + "' data-type='image'><i class='fa fa-times'></i></button><br>";
						str+="<div><a><img src='/display?fileName=" + filePath + "'></a>";
						str+="</div></li>";
					}else{//false : 이미지 외
						var filePath = encodeURIComponent(obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName);	
						str+="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
						str+="<div><span>" + obj.fileName + "</span><br>";
						str+="<button type='button' class='btn btn-warning btn-circle' data-file='" + filePath + "' data-type='image'><i class='fa fa-times'></i></button><br>";
						str+="</a></div></li>";
					}
				});
				uploadResult.append(str);
			}
		});
		//업로드 영역에 변화 감지 시 uploadFile에 있는 정보 가져오기
		$(".attachBtn").on("change",function(){
			console.log("★uploadevent 변화감지★");
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;	
			
			for(var i=0; i<files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){	//확장자 확인
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			//formData를 ajax 기술로 서버로 전송하기
			$.ajax({
				url : "/uploadAjax",
				data : formData,
				processData : false,
				contentType : false,
				type : "post",
				dataType : "json",
				success : function(result){
					console.log(result);
					showUploadedFile(result);
					$(".attachBtn").html(cloneObj.html());
				}
			});//ajax
		});
		// 서버에서 result를 받은 후 result 보여주기
		function showUploadedFile(uploadResultArr){
			//결과 보여줄 영역 자겨오기
			var uploadResult = $(".uploadResult ul");
			var str="";
			$(uploadResultArr).each(function(i,obj){
				if(obj.fileType){//true : 이미지
					//썸네일 이미지 경로	//encodeURIComponent : 클라이언트 쪽에서 인코딩. uploadPath에 d/upload/2019/04/16 들어있음. 
					var filePath = encodeURIComponent(obj.uploadPath + "\\thum_" + obj.uuid + "_" + obj.fileName);
				
					//원본파일이미지경로
					var oriPath=obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;

					oriPath = oriPath.replace(new RegExp(/\\/g), "/"); //폴더 구분의 /를 \로 바꾸기
					
					//가져온 데이터 html에 붙이기
					str+="<li class='attahLi' data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
					str+="<div>";
					str+="<button type='button' class='btn btn-warning btn-circle' data-file='" + filePath + "' data-type='image'><i class='fa fa-times'></i></button><br>";
					str+="<a href=\"javascript:showImage(\'" + oriPath + "\')\">";
					str+="<img src='/display?fileName=" + filePath + "'></a>";
					str+="</div></li>";
				}else{//false:이미지 외
					var filePath = encodeURIComponent(obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName);	
					str+="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
					str+="<div>";
					str+="<span>" + obj.fileName + "</span>";
					str+="<button type='button' class='btn btn-warning btn-circle deleteBtn' data-file='" + filePath + "' data-type='file'><i class='fa fa-times'></i></button><br>";
					str+="<a href='/download?fileName=" + filePath + "'>";
					str+="<img src='/resources/img/attach.png'></a>";
					str+="</div></li>";
				}
			});
			uploadResult.append(str);
			
		}//showUploadedFile
		//첨부파일의 크기와 확장자 제한
		function checkExtension(fileName,fileSize){
			var regex = new RegExp("(.*?)\.(exe|sh|alz)$");
			var maxSize = 5242880; //5mb
			
			if(fileSize>maxSize){
				alert("파일사이즈초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 파일의 확장자는 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}//확장자검사
		
		// X를 클릭하면 첨부된 파일 삭제하기
		$(".uploadResult").on("click","button",function(){
			console.log("x버튼 클릭됨")
			//첨부목록 삭제
			var targetLi = $(this).closest("li");
			targetLi.remove();
		});
	});
</script>
<%@ include file="../include/footer.jsp"%>