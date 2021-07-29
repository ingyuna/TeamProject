<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="resources/asset/css/myPage.css">
	<script>

	
	</script>
</head>
<body>
	
	<c:if test="${empty list}">
		<div class="review">
			<h3>작성된리뷰가 없습니다.</h3>
		</div>
		
	</c:if>
	<c:if test="${not empty list}">
		<c:forEach var="review" items="${list}">
			<div class="review">
				<h3>${review.no}</h3>
				<div id="box1" class="box">
					<h3>${review.storeName}<span>${review.storeCategory}</span></h3>
					<a href="#"><img alt="review_img" src="resources/archive/${review.filename}" /></a>
				</div>
				
				<div id="box2"  class="box">
					<div id="review_grade">
					<p class="star">
					<c:forEach var="i" begin="1" end="${review.score}" step="1">
					★
					</c:forEach>
					</p>
						<span class="grey">(평점)</span>
					</div>
					<p id="review_text">${review.content }</p>
					<div id="review_img">
						
					</div>
				</div>
				<div id="box3" class="box">
					
					<input type="button" value="리뷰 수정" id="update_review_btn" onclick="location.href='updateReviewPage.do?no=${review.no}'">
					<br>
					<input type="button" value="리뷰 삭제" id="delete_review_btn" onclick="location.href='deleteReview.do?no=${review.no}'">
				
				</div>
			</div> <!-- review -->
			<div id="review_padding"></div>
				
		</c:forEach>
	</c:if>
	
</body>
</html>