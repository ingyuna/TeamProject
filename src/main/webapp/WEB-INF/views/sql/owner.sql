DROP TABLE OWNER;
DROP TABLE OWNERIDF;

CREATE TABLE OWNERIDF 
(
    OWNERNO NUMBER PRIMARY KEY,
    OWNERNAME VARCHAR2(32),
    OWNEREMAIL VARCHAR2(32) UNIQUE
);

CREATE TABLE OWNER
(
    OWNERNO NUMBER PRIMARY KEY,
    OWNERPW VARCHAR2(32),
    OWNERTEL VARCHAR2(32),
    OWNEREMAIL VARCHAR2(32),
    OWNERNAME VARCHAR2(32),
    CONSTRAINT FK_ID FOREIGN KEY (OWNERNO) REFERENCES OWNERIDF(OWNERNO)
);

INSERT INTO OWNERIDF VALUES(12345, '사장1', 'owner1@store.com');

