DROP TABLE STOREREG;
CREATE TABLE STOREREG
(
    STORENO NUMBER PRIMARY KEY,
    OWNERNAME VARCHAR2(32),
    STORENAME VARCHAR2(32) NOT NULL,
    STORETEL VARCHAR2(32) NOT NULL,
    STORECATEGORI VARCHAR2(32) NOT NULL,
    STORETIME VARCHAR2(32) NOT NULL,
    STOREADDR VARCHAR2(64) NOT NULL,
    STORECONTENT VARCHAR2(300) NOT NULL,
    STOREMENU VARCHAR2(200),
    STORESNS VARCHAR2(100),
    STOREHIT NUMBER,
    FILENAME1 VARCHAR2(64) NOT NULL,
    STORETABLE NUMBER NOT NULL
);

DROP SEQUENCE STOREREG_SEQ;
CREATE SEQUENCE STOREREG_SEQ INCREMENT BY 1 START WITH 1 NOCYCLE NOCACHE;
