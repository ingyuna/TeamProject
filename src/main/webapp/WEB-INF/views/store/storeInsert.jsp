<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<!-- Header -->
<jsp:include page="../layout/header.jsp">
	<jsp:param value="Main" name="title"/>
</jsp:include>

<link rel="stylesheet" href="resources/asset/css/storeInsert.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script>
	
	$(document).ready(function(){
		fn_storeInsert();
		fn_storeTable();
		fn_fileAlert();
		fn_storeCategory();
	});
	
	// 가게 등록 함수
	function fn_storeInsert(){
		$('#f').submit(function(event){
			if ($('#store_name').val() == '' ||
				$('#store_content').val() == '' ||
				$('#store_table').val() == '' ||
				$('#store_tel').val() == '' ||
				$('#store_addr').val() == '' ||
				$('#store_time').val() == '' ||
				$('#store_category').val() == '' ||
				$('#file').val() == '' 
				) {
				alert('필수 정보를 입력하세요.');
				event.preventDefault();
				return false;
			} 
			$('#f').attr('action', 'storeInsert.do');
			$('#f').submit();	
		});
	}
	
	// 테이블 갯수 입력창
	function fn_storeTable() {
		$('#store_table').blur(function(){
			var storeTable = /^[0-9]{1,3}$/;
			if ( !storeTable.test($('#store_table').val()) ) {
				alert('숫자만 입력해주세요. (3자리를 넘을 수 없습니다.)')
				return false;
			}
		});
	}
	
	// 카테고리 선택 
	function fn_storeCategory() {
		$('input:radio[name=storeCategory].attr("checked", true)');
	}
	
	
	// 파일 업로드 제한 
	function fn_fileAlert(){
		$('#file').change(function(){
			var extension = $(this).val().substring($(this).val().lastIndexOf('.') + 1).toUpperCase();
			var extList = ['JPG', 'JPEG', 'PNG', 'GIF'];
			if ($.inArray(extension, extList) == -1) {
				alert('확장자가 jpg, jpeg, png, gif인 파일만 업로드 가능합니다.');
				$(this).val('');
				return false;
			}
			var maxSize = 1024 * 1024 * 10; 
			var fileSize = $(this)[0].files[0].size;
			if (fileSize > maxSize) {
				alert('10MB 이하의 파일만 업로드 가능합니다.');
				$(this).val('');
				return false;
			}
		});
	}
	

</script>


	<div class="outer">
	
		
		<form id="f" method="post" enctype="multipart/form-data">
		
			<h3>가게 정보를 입력해주세요 :)</h3>
			<p>*는 필수사항입니다.</p>
			
			<table>
				<tbody>
				
				
					<!--
						<tr>
							<td>사업주명</td>
							<td><input type="text" value="${owner.name}" id="owener_name" name="owener_name" class="int" readonly><br></td>
						<tr>
					-->
					 
					
					<tr>
						<td>상호명 *</td>
						<td><input type="text" id="store_name" name="storeName" class="int"><br></td>
					<tr>
						<td>가게 소개 *</td>
						<td><textarea rows="7" cols="25" id="store_content" name="storeContent"></textarea><br></td>
					</tr>
					<tr>
						<td>테이블 수 *</td>
						<td><input type="text" id="store_table" name="storeTable" class="int"><br></td>
					</tr>			
					<tr>
						<td>가게 번호 *</td>
						<td><input type="text" id="store_tel" name="storeTel" class="int"><br></td>
					</tr>
					
					<tr>
						<td>가게 주소 *</td>
						<!--
						<td name="storeAddr">
							<select name="zone" id="zone">
								<option value="">지역</option>
								<option value="서울">서울</option>
								<option value="경기">경기</option>
								<option value="부산">부산</option>
							</select>
							<select name="local" id="local">
								<option value="">구</option>
								<option value="용산">용산구</option>
								<option value="서대문구">서대문구</option>
								<option value="강남구">강남구</option>
							</select><br>
							</td>
							  -->
							  <td>
							<input type="text" id="store_addr" name="storeAddr"  placeholder="상세주소 입력" class="int"><br>			
							</td>
					</tr>
					<tr>
						<td>운영 시간 *</td>
						<td><input type="text" id="store_time" name="storeTime" class="int"><br></td>
					</tr>
					
					
					<tr>
						<td>SNS</td>
						<td><input type="text" id="store_sns" name="storeSns" class="int"><br></td>
					</tr>
				
					
					<tr>
						<td>카테고리 분류 *</td>
						<td id="store_Category" colspan="2">
							<input type="radio" name="storeCategory" value="한식" id="f1"> 
							<label for=f1>한식</label>
							<input type="radio" name="storeCategory" value="양식" id="f2"> 
							<label for=f2>양식</label>
							<input type="radio" name="storeCategory" value="일식" id="f3"> 
							<label for=f3>일식</label>
							<input type="radio" name="storeCategory" value="중식" id="f4"> 
							<label for=f4>중식</label>
							<input type="radio" name="storeCategory" value="술" id="f5"> 
							<label for=f5>술(+19)</label>
						</td>
					</tr>
					
					
					<tr>
						<td>메뉴 등록</td>
						<td>
							<textarea rows="7" cols="25" id="store_menu" name="storeMenu"></textarea>
							<!-- <input type="text" id="menu_price" name="storeMenu" class="menu_int" placeholder="가격(,로 입력)">  -->
						</td>
					</tr>
					
					 
					<tr>
						<td>가게 대표이미지 *</td>
						<td>
							<input type="file" id="file" name="file"><br>
						</td>
					</tr>
				</tbody>
				
				
				 
				<tfoot>
					<tr>
						<td colspan="2">						
								<input type="button" value="뒤로가기" onclick="history.back()" class="btn1">
								<button id="store_insert" class="btn2">등록하기</button>
						</td>
					</tr>	
				</tfoot>	
					
			</table>
			
			
		</form>
		
		
	
	
	</div>
<!-- Footer -->
<%@ include file="../layout/footer.jsp"%>