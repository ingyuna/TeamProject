DROP TABLE REVIEW;
DROP TABLE FREPLY;
DROP TABLE MEMBER;
DROP TABLE OWNER;
DROP TABLE OWNERINFO;
DROP TABLE RESERVATION;  
DROP TABLE STOREREG;
DROP TABLE NOTICE;
DROP TABLE FBOARD;
DROP TABLE QNABOARD;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE NOTICE_SEQ;
DROP SEQUENCE STORERES_SEQ;
DROP SEQUENCE STOREREG_SEQ;
DROP SEQUENCE FBOARD_SEQ;
DROP SEQUENCE FREPLY_SEQ;
DROP SEQUENCE QNABOARD_SEQ;
CREATE SEQUENCE MEMBER_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE STORERES_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE STOREREG_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE NOTICE_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE FBOARD_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE FREPLY_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE QNABOARD_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE SEQUENCE REVIEW_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
CREATE TABLE MEMBER(
    MEMBERNO NUMBER PRIMARY KEY,
    MEMBERID VARCHAR2(32) UNIQUE ,
    MEMBERPW VARCHAR2(32),
    MEMBERNAME VARCHAR2(32),
    MEMBERADDR VARCHAR2(64),
    MEMBERTEL VARCHAR2(32),
    MEMBEREMAIL VARCHAR2(32),
    MEMBERAGE NUMBER,
    STATUS NUMBER
);
ALTER TABLE MEMBER MODIFY MEMBERID VARCHAR2(32) NOT NULL;
ALTER TABLE MEMBER MODIFY MEMBERAGE VARCHAR2(32) NOT NULL;

CREATE TABLE OWNERINFO (
    OWNERNO NUMBER PRIMARY KEY,
    OWNERNAME VARCHAR2(32),
    STORENAME VARCHAR2(32),
    OWNEREMAIL VARCHAR2(32) UNIQUE
);

CREATE TABLE OWNER(
    OWNERNO NUMBER PRIMARY KEY,
    OWNERPW VARCHAR2(32),
    OWNERTEL VARCHAR2(32),
    OWNEREMAIL VARCHAR2(32),
    OWNERNAME VARCHAR2(32),
    CONSTRAINT FK_ID FOREIGN KEY (OWNERNO) REFERENCES OWNERINFO(OWNERNO)
);

-- 가게 테이블
CREATE TABLE STOREREG
(
    STORENO NUMBER PRIMARY KEY,
    STORENAME VARCHAR2(32) NOT NULL,
    STORECONTENT VARCHAR2(300) NOT NULL,
    STORETABLE NUMBER NOT NULL,
    STORETEL VARCHAR2(32) NOT NULL,
    STOREADDR1 VARCHAR2(64) NOT NULL,
    STOREADDR2 VARCHAR2(64) NOT NULL,
    STOREADDR3 VARCHAR2(64) NOT NULL,
    STORETIME VARCHAR2(32) NOT NULL,
    STORESNS VARCHAR2(100),
    STORECATEGORY VARCHAR2(32),
    STOREMENU VARCHAR2(200),
  	ORIGINFILENAME VARCHAR2(256),
    SAVEFILENAME VARCHAR2(40),  -- 파일명 32바이트, 확장자 8바이트
    STOREHIT NUMBER,
    STATUS NUMBER			
);

-- 예약 테이블
CREATE TABLE RESERVATION
(
	RESNO NUMBER PRIMARY KEY,		-- 예약번호
	STORENO NUMBER,					-- 가게번호(외래키)
	RESDATE VARCHAR2(10) NOT NULL,	-- 예약한 해당 날짜
	RESHOURS VARCHAR2(20),			-- 예약 시간
	RESPEOPLE VARCHAR2(10),			-- 예약 인원
	RESNOTE VARCHAR2(4000),			-- 예약 요청사항
	RESPOSTDATE DATE,				-- 예약한 날짜
	CONSTRAINT FK_RESERVATION_STOREREG FOREIGN KEY (STORENO) REFERENCES STOREREG(STORENO)
);


CREATE TABLE NOTICE(
    NO NUMBER PRIMARY KEY,
    WRITER VARCHAR2(32),
    TITLE VARCHAR2(500),
    CONTENT VARCHAR2(4000),
    POSTDATE DATE,
    LASTDATE DATE,
    HIT NUMBER
);
INSERT INTO NOTICE VALUES (NOTICE_SEQ.NEXTVAL,'ADMIN','공지사항','공지사항 게시판입니다',SYSDATE,SYSDATE,0);
CREATE TABLE FBOARD(
     NO NUMBER PRIMARY KEY,
      WRITER VARCHAR2(32),
      CONTENTTYPE VARCHAR2(50)  CHECK ( CONTENTTYPE IN ('이벤트', '홍보글') ) NULL,
      TITLE VARCHAR2(500),
      CONTENT VARCHAR2(4000),
      FILENAME1 VARCHAR2(1000),
      POSTDATE DATE,
      LASTDATE DATE,
      HIT NUMBER,
      STATUS NUMBER
);
insert into fboard values (fboard_seq.nextval, 'jaims', '이벤트', '이벤트글', '이벤트 시작합니다.', '', sysdate, sysdate, 0,0);
CREATE TABLE FREPLY(
      FNO NUMBER PRIMARY KEY,
      NO NUMBER,
      WRITER VARCHAR2(32),
      CONTENT VARCHAR2(500),
      POSTDATE DATE,
      CONSTRAINT FK_REPLY_NO FOREIGN KEY (NO) REFERENCES FBOARD(NO)
);

CREATE TABLE QNABOARD(
    NO NUMBER PRIMARY KEY,
    WRITER VARCHAR2(32),
    TITLE VARCHAR2(32),
    CONTENT VARCHAR2(300),
    POSTDATE DATE,
    GROUPORD NUMBER,
    GROUPNO NUMBER,
    DEPTH NUMBER
);

CREATE TABLE REVIEW(
    WRITER VARCHAR2(32),
    NO NUMBER PRIMARY KEY,
    SCORE NUMBER,
    CONTENT VARCHAR2(300),
    FILENAME VARCHAR2(64),
    STORENO NUMBER,
      CONSTRAINT FK_REVIEW FOREIGN KEY (STORENO) REFERENCES STOREREG(STORENO)
);

INSERT INTO STOREREG VALUES(1,'이연복','목란','010-1111-1111','중식','09:00-17:00','서울시 강남구 삼성동 165-5','중식점 목란입니다.','메뉴','sns',0,'이미지',10);
INSERT INTO STOREREG VALUES(2,'백종원','골목식당','010-2222-2222','한식','09:00-17:00','서울시 강남구 삼성동 165-6','한식점 골목식당입니다.','메뉴','sns',0,'이미지',10);
INSERT INTO REVIEW VALUES('qwer1234',REVIEW_SEQ.NEXTVAL,5,'정말맛있어요','FILENAME1',1);
INSERT INTO REVIEW VALUES('qwer1234',REVIEW_SEQ.NEXTVAL,4,'정말맛있어요','FILENAME1',2);
INSERT INTO REVIEW VALUES('qwer1234',REVIEW_SEQ.NEXTVAL,3,'평범했어요','FILENAME1',1);

SELECT R.NO, R.WRITER,R.SCORE,R.CONTENT,R.FILENAME,S.STORENAME,S.STORECATEGORY 
FROM REVIEW R , STOREREG S  WHERE R.STORENO =S.STORENO AND R.WRITER='ABC';

SELECT * FROM REVIEW WHERE WRITER='ABC';
SELECT R.WRITER,R.SCORE,R.CONTENT,R.FILENAME,S.STORENAME,S.STORECATEGORY 
	FROM REVIEW R , STOREREG S  
	WHERE R.STORENO =S.STORENO AND S.STORENO='2';
    
SELECT R.NO ,R.WRITER,R.SCORE,R.CONTENT,R.FILENAME,S.STORENAME,S.STORECATEGORY 
					FROM REVIEW R , STOREREG S  WHERE R.STORENO =S.STORENO AND R.WRITER='qwer1234';
                    
INSERT INTO REVIEW VALUES ('qwer1234',REVIEW_SEQ.NEXTVAL,5,'좋아요','FILENAME1',1);
SELECT * FROM MEMBER;
SELECT * FROM REVIEW;

SELECT R.NO ,R.WRITER,R.SCORE,R.CONTENT,R.FILENAME,S.STORENAME,S.STORECATEGORY 
					FROM REVIEW R , STOREREG S  WHERE R.STORENO =S.STORENO AND R.NO=10;