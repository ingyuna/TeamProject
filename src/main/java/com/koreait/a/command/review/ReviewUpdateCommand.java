package com.koreait.a.command.review;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.a.dao.ReviewDAO;
import com.koreait.a.dto.ReviewDTO;

public class ReviewUpdateCommand implements ReviewCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)map.get("multipartRequest");
		
		// DB 삭제
		String writer = multipartRequest.getParameter("writer");
		String content = multipartRequest.getParameter("content");
		long storeNo = Long.parseLong(multipartRequest.getParameter("review_store"));
		int score = Integer.parseInt(multipartRequest.getParameter("star"));
		
		
		ReviewDTO review = new ReviewDTO();
		review.setWriter(writer);
		review.setScore(score);
		review.setContent(content);
		review.setStoreNo(storeNo);
		
		String filename1 = multipartRequest.getParameter("review_img");    // 서버에 저장된 첨부파일명
		MultipartFile filename2 = multipartRequest.getFile("review_img");  // 새로운 첨부파일
		
		String realPath = multipartRequest.getServletContext().getRealPath("resources/archive");
		
		File file = new File(realPath, filename1);  // 서버에 저장된 파일(기존의 첨부)
		
		ReviewDAO reviewDAO = sqlSession.getMapper(ReviewDAO.class);
		
		if (filename2 != null && !filename2.isEmpty()) {  // 새로운 첨부가 있다.

			// 기존 첨부와 새로운 첨부가 모두 있으면 -> 기존 첨부를 지운다.
			if (file != null) {
				// 기존 첨부 지우기
				if (file.exists()) {
					file.delete();
				}
			}
			
			// 새 첨부 넣기
			String originalFilename = filename2.getOriginalFilename();
			String extension = originalFilename.substring( originalFilename.lastIndexOf(".") + 1 );
			String filename = originalFilename.substring( 0, originalFilename.lastIndexOf(".") );
			String uploadFilename = filename + "_" + System.currentTimeMillis() + "." + extension;
			File uploadFile = new File(realPath, uploadFilename);
			try {
				filename2.transferTo(uploadFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			// DB에 넣는 파일명 인코딩 처리
			try {
				uploadFilename = URLEncoder.encode(uploadFilename, "utf-8");
				review.setFilename(uploadFilename);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			reviewDAO.updateReview(review);
			
		} else {  // 새로운 첨부가 없다.
			review.setFilename("");
			reviewDAO.updateReview(review);
			
		}
		
	}


}
