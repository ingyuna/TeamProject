package com.koreait.a.command.review;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.a.dao.ReviewDAO;
import com.koreait.a.dto.ReviewDTO;

public class ReviewInsertCommand implements ReviewCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)map.get("multipartRequest");
		
		
		String writer = multipartRequest.getParameter("writer");
		String content = multipartRequest.getParameter("content");
		long storeNo = Long.parseLong(multipartRequest.getParameter("review_store"));
		int score = Integer.parseInt(multipartRequest.getParameter("star"));
		
		
		ReviewDTO review = new ReviewDTO();
		review.setWriter(writer);
		review.setScore(score);
		review.setContent(content);
		review.setStoreNo(storeNo);
		ReviewDAO reviewDAO = sqlSession.getMapper(ReviewDAO.class);
		
		
		MultipartFile file = multipartRequest.getFile("review_img");
		int result= 0;
		if (file != null && !file.isEmpty()) {
			// 저장할 파일 이름명 
			String originalFilename = file.getOriginalFilename();
			String extension = originalFilename.substring( originalFilename.lastIndexOf('.') + 1 );
			String filename = originalFilename.substring(0, originalFilename.lastIndexOf("."));
			String uploadFilename = filename + "_" + System.currentTimeMillis() + "." + extension;
			// 저장할 위치 생성
			String realPath = multipartRequest.getServletContext().getRealPath("resources/archive");
			File archive = new File(realPath);
			if (!archive.exists()) {
				archive.mkdirs();
			} 
			// 서버에 첨부파일 저장
			File attach = new File(archive, uploadFilename);
			try {
				file.transferTo(attach);
			} catch (IOException e) {
				e.printStackTrace();
			} 
			// DB에 저장 할 때 파일명 인코딩 (한글로된 파일이 있을 수 있다.)
			try {
				uploadFilename = URLEncoder.encode(uploadFilename, "UTF-8");
			} catch (Exception e) {
				e.printStackTrace();
			} 
			review.setFilename(uploadFilename);
			// DB에 저장
			result = reviewDAO.insertReview(review);
			
		} else {
			// DB에 저장
			// 첨부파일이 없다.
			review.setFilename("");
			result = reviewDAO.insertReview(review);
		}

}
}
