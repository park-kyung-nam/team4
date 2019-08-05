/**********************************/
/* Table Name: 제품 카테고리 그룹 */
/**********************************/
DROP TABLE product;
DROP TABLE member;
DROP TABLE prodcate;
DROP TABLE prodcategrp;

CREATE TABLE prodcategrp(
    prodcategrpno                     NUMBER(10)     NOT NULL    PRIMARY KEY,
    prodgrp_title                             VARCHAR2(50)     NOT NULL,
    prodgrp_seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    prodgrp_visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    prodgrp_cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    prodgrp_rdate                             DATE     NOT NULL
);

COMMENT ON TABLE prodcategrp is '제품 카테고리 그룹';
COMMENT ON COLUMN prodcategrp.prodcategrpno is '제품 그룹 번호';
COMMENT ON COLUMN prodcategrp.prodgrp_title  is '제품 그룹 제목';
COMMENT ON COLUMN prodcategrp.prodgrp_seqno is '출력 순서';
COMMENT ON COLUMN prodcategrp.prodgrp_visible is '출력 모드';
COMMENT ON COLUMN prodcategrp.prodgrp_cnt is '등록된 자료수';
COMMENT ON COLUMN prodcategrp.prodgrp_rdate is '그룹 생성일';

CREATE TABLE prodcate(
    prodcateno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    prodcategrpno                     NUMBER(10)     NULL ,
    prodcate_title                             VARCHAR2(50)     NOT NULL,
    prodcate_seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    prodcate_visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    prodcate_cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    prodcate_ids                               VARCHAR2(10)     DEFAULT 'admin'     NOT NULL,
    prodcate_rdate                             DATE     NOT NULL,
  FOREIGN KEY (prodcategrpno) REFERENCES prodcategrp (prodcategrpno)
);

COMMENT ON TABLE prodcate is '제품 카테고리';
COMMENT ON COLUMN prodcate.prodcateno is '제품 카테고리 번호';
COMMENT ON COLUMN prodcate.prodcategrpno is '제품 그룹 번호';
COMMENT ON COLUMN prodcate.prodcate_title is '카테고리 제목';
COMMENT ON COLUMN prodcate.prodcate_seqno is '출력 순서';
COMMENT ON COLUMN prodcate.prodcate_visible is '출력 모드';
COMMENT ON COLUMN prodcate.prodcate_cnt is '등록된 자료수';
COMMENT ON COLUMN prodcate.prodcate_ids is '접근 계정';
COMMENT ON COLUMN prodcate.prodcate_rdate is '카테고리 생성일';

CREATE TABLE product(
    productno         NUMBER(10)    NOT NULL    PRIMARY KEY,
    prodcateno        NUMBER(10)     NULL ,
    adminno            NUMBER(10)     NULL,
    prod_title                   VARCHAR2(300)                        NOT NULL,
    prod_content              CLOB                                      NOT NULL,      -- CLOB
    prod_good                 NUMBER(7)        DEFAULT 0       NOT NULL,
    thumbs              VARCHAR2(1000)                             NULL ,
    files                   VARCHAR2(1000)                            NULL ,
    sizes                  VARCHAR2(1000)                            NULL ,
    prod_cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
    replyprod_cnt              NUMBER(7)        DEFAULT 0       NOT NULL,
    prod_rdate                  DATE                                      NOT NULL,
    prod_grpno                 NUMBER(7)                              NOT NULL,
    prod_indent                NUMBER(2)        DEFAULT 0       NOT NULL,
    prod_ansnum              NUMBER(5)        DEFAULT 0       NOT NULL,
    prod_word                  VARCHAR2(100)                              NULL,
    prod_price                  NUMBER(10)      DEFAULT 0       NOT NULL,
    prod_maker                VARCHAR2(100)                                NULL,
    prod_dc                     NUMBER(10)      DEFAULT 0       NOT NULL,
    dcprod_price               NUMBER(10)      DEFAULT 0       NOT NULL,
    prod_point                  NUMBER(10)      DEFAULT 0       NOT NULL,
    prod_startdate             DATE                NULL,
    prod_enddate              DATE                NULL,
    prod_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,  
    viewprod_cnt               NUMBER(8)    DEFAULT 0     NOT NULL,
    ip                      VARCHAR2(15)     NOT NULL,
  FOREIGN KEY (prodcateno) REFERENCES prodcate (prodcateno),
  FOREIGN KEY (adminno) REFERENCES ADMIN (adminno)
);

COMMENT ON TABLE product is '제품';
COMMENT ON COLUMN product.productno is '제품번호';
COMMENT ON COLUMN product.prodcateno is '제품 카테고리 번호';
COMMENT ON COLUMN product.prod_title is '제품 제목';
COMMENT ON COLUMN product.seqno is '출력 순서';
COMMENT ON COLUMN product.prod_visible is '출력 모드';
COMMENT ON COLUMN product.prod_cnt is '제품갯수';
COMMENT ON COLUMN product.prod_rdate is '제품 생성일';
COMMENT ON COLUMN product.prod_price is '가격';
COMMENT ON COLUMN product.prod_content is '내용';
COMMENT ON COLUMN product.passwd is '패스워드';
COMMENT ON COLUMN product.viewprod_cnt is '조회수';
COMMENT ON COLUMN product.files is '파일명';
COMMENT ON COLUMN product.thumbs is 'Preview 이미지';
COMMENT ON COLUMN product.sizes is '파일크기';
COMMENT ON COLUMN product.ip is 'IP';

-----------------------------------비추: 아래 부분 사용하지 마시오--------------------------------------------
DROP SEQUENCE prodcategrp_seq;

CREATE SEQUENCE prodcategrp_seq
START WITH   1            --시작번호
INCREMENT BY 1          --증가값
MAXVALUE   99999999  --최대값, NUMBER(7) 대응
CACHE        2               --시쿼스 변경시 자주 update되는 것을 방지하기위한 캐시값
NOCYCLE;  

2) insert
- classification: 1-Blog, 2-Gallery, 3-Product
- prodgrp_visible: Y, N

   INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
   VALUES(prodcategrp_seq.nextval, 'CPU', 1, 'Y',0 ,sysdate);
   
   INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
   VALUES(prodcategrp_seq.nextval, '그래픽카드', 1, 'Y',0 ,sysdate);
   
   INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
   VALUES(prodcategrp_seq.nextval, '운영체제', 1, 'Y',0 ,sysdate);
   
-----------------------------------비추: 윗 부분 사용하지 마시오--------------------------------------------

   
3) Sequence를 사용하지 않는 일련번호의 자동 생성
   
SELECT prodcategrpno FROM prodcategrp;

 PRODCATEGRPNO
 -------------

SELECT MAX(prodcategrpno) FROM prodcategrp; -- 레코드가 없으면 null

 MAX(PRODCATEGRPNO)
 ------------------
               NULL
           
SELECT MAX(prodcategrpno) + 1 FROM prodcategrp;    -- 레코드가 없으면 의미 없음, null       
           
 MAX(PRODCATEGRPNO)+1
 --------------------
                 NULL

-- null인 컬럼의 값을 0으로 변경후 연산, NVL(컬럼명, 0): 컬럼값이 null이면 0으로 변경
SELECT NVL(MAX(prodcategrpno), 0) + 1 FROM prodcategrp;
                       
 NVL(MAX(PRODCATEGRPNO),0)+1 <-- 컬럼명이 너무 큼
 ---------------------------
                           1
                        
-- as: 커럼 별명 지정, SELECT시에만 컬럼명 변경                       
SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp;                       

 PRODCATEGRPNO
 -------------
             1
         
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             'CPU', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '그래픽카드', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '운영체제', 1, 'Y',0 ,sysdate);
   
-- List
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate
FROM prodcategrp
ORDER BY prodgrp_seqno ASC;

 PRODCATEGRPNO TITLE SEQNO VISIBLE CNT RDATE
 ------------- ----- ----- ------- --- ---------------------
             1 CPU       1 Y         0 2019-05-14 11:16:21.0
             3 운영체제      1 Y         0 2019-05-14 11:16:23.0
             2 그래픽카드     1 Y         0 2019-05-14 11:16:22.0

-- Read: 조회
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate
FROM prodcategrp
WHERE prodcategrpno = 1;

 PRODCATEGRPNO TITLE SEQNO VISIBLE CNT RDATE
 ------------- ----- ----- ------- --- ---------------------
             1 CPU       1 Y         0 2019-05-14 11:16:21.0
        
-- 수정
UPDATE prodcategrp
SET prodgrp_title='그래픽카드', prodgrp_seqno=1, prodgrp_visible='Y', prodgrp_cnt=0
WHERE prodcategrpno=1;

-- 한건의 레코드 삭제
DELETE FROM prodcategrp
WHERE prodcategrpno=3;

-- 모든 레코드 삭제
DELETE FROM prodcategrp;

-- 출력순서의 낮춤(나중에 출력)
UPDATE prodcategrp
SET prodgrp_seqno = prodgrp_seqno + 1
WHERE prodcategrpno=1;

-- 출력 순서의 높임(먼저 출력)
UPDATE prodcategrp
SET prodgrp_seqno = prodgrp_seqno - 1
WHERE prodcategrpno=1;

-- 출력 변경
UPDATE prodcategrp
SET prodgrp_visible='Y' -- 출력
WHERE prodcategrpno=1;

UPDATE prodcategrp
SET prodgrp_visible='N' -- 숨기기
WHERE prodcategrpno=1;

-- 최대값
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcategrp;

 SEQNO
 -----
     2
     
-- MAX 함수는 레코드가 없으면 null을 출력함으로 사칙연산이 불가능함.
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcategrp;

 prodgrp_seqno
 -------
    null

-- NVL 함수의 사용으로 null 값일경우 0으로 변경되어 1이 출력됨.
SELECT NVL(MAX(prodgrp_seqno), 0)+1 as prodgrp_seqno 
FROM prodcategrp;

 prodgrp_seqno
 -----
     1    

-- 등록된 글 수 증가
UPDATE prodcategrp
SET prodgrp_cnt = prodgrp_cnt + 1
WHERE prodcategrpno=1;

-- 등록된 글 수 감소
UPDATE prodcategrp
SET prodgrp_cnt = prodgrp_cnt - 1
WHERE prodcategrpno=1;


8) 검색

         
9) 페이징

-- FOREIGN KEY (prodcategrpno) REFERENCES prodcategrp (prodcategrpno):
-- prodcategrpno 컬럼의 값은 prodcategrp 테이블의 prodcategrpno 컬럼에 등록된 값만
-- 사용할 수 있습니다.  
-- PK 삭제시 FK 레코드 자동 삭제(권장 아님)
-- FOREIGN KEY (prodcategrpno) REFERENCES prodcategrp (prodcategrpno) ON DELETE CASCADE
/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE prodcontents;
DROP TABLE prodcate;

DROP TABLE MEMBER;

CREATE TABLE prodcate(
    prodcateno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    prodcategrpno                     NUMBER(10)     NULL ,
    prodgrp_title                             VARCHAR2(50)     NOT NULL,
    prodgrp_seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    prodgrp_visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    prodgrp_cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    ids                               VARCHAR2(10)     DEFAULT 'admin'     NOT NULL,
    prodgrp_rdate                             DATE     NOT NULL,
  FOREIGN KEY (prodcategrpno) REFERENCES prodcategrp (prodcategrpno)
);

COMMENT ON TABLE prodcate is '제품 카테고리';
COMMENT ON COLUMN prodcate.prodcateno is '제품 카테고리 번호';
COMMENT ON COLUMN prodcate.prodcategrpno is '제품 그룹 번호';
COMMENT ON COLUMN prodcate.prodgrp_title is '카테고리 제목';
COMMENT ON COLUMN prodcate.prodgrp_seqno is '출력 순서';
COMMENT ON COLUMN prodcate.prodgrp_visible is '출력 모드';
COMMENT ON COLUMN prodcate.prodgrp_cnt is '등록된 자료수';
COMMENT ON COLUMN prodcate.ids is '접근 계정';
COMMENT ON COLUMN prodcate.prodgrp_rdate is '카테고리 생성일';

2) 테이블 삭제: 자식 -> 부모
① DROP TABLE prodcategrp; : ORA-02449: unique/primary keys in table referenced by foreign keys
② 자식 테이블 삭제: DROP TABLE prodcate;
③ 부모 테이블 삭제: DROP TABLE prodcategrp;


3) 테이블 생성: 부모 -> 자식
① FK cate 생성시 에러 발생: ORA-00942: table or view does not exist
② 부모 테이블 먼저 생성: prodcategrp
③ 자식 테이블 생성: prodcate


4) 부모 테이블의 강제 삭제(권장 하지 않음), 제약 조건도 함께 삭제됨.
DROP TABLE prodcategrp CASCADE CONSTRAINTS;


5) 레코드 추가, ERROR, 부모 테이블 PK 컬럼에 값이 없는 경우
SELECT * FROM prodcategrp ORDER BY prodgrp_seqno ASC;
 PRODCATEGRPNO   SORT     SEQNO
 ----------  ---------   ---------
 PK 테이블에 레코드 없음.

 -----------------------------------비추: 아래 부분 사용하지 마시오--------------------------------------------
DROP SEQUENCE prodcate_seq;

CREATE SEQUENCE prodcate_seq
START WITH   1            --시작번호
INCREMENT BY 1          --증가값
MAXVALUE   99999999  --최대값, NUMBER(7) 대응
CACHE        2               --시쿼스 변경시 자주 update되는 것을 방지하기위한 캐시값
NOCYCLE;  

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES(prodcate_seq.nextval, 1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES(prodcate_seq.nextval, 2, '윈도우', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES(prodcate_seq.nextval, 3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);

-----------------------------------비추: 윗 부분 사용하지 마시오--------------------------------------------

   
--   부모키 prodcategrpno가 없을 경우
--   ORA-02291: integrity constraint (AI4.SYS_C007705) violated - parent key not found
--   (0 rows affected)
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '윈도우', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
               3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);
   
-- List
SELECT prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate
FROM prodcate
ORDER BY prodgrp_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
          4             2 윈도우         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 윈도우         1 Y         0 admin 2019-05-14 11:39:15.0

          
③ 그룹별로 정렬하여 출력 

SELECT prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate
FROM prodcate 
ORDER BY prodcategrpno ASC, prodgrp_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- -------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G      1 Y         0 admin 2019-05-27 17:15:03.0
          2             2 윈도우          1 Y         0 admin 2019-05-27 17:15:28.0
          3             3 HDD(1TB)     1 Y         0 admin 2019-05-27 17:15:29.0
          
-- 모든 그룹의  join
    SELECT c.prodcategrpno, c.prodgrp_title,
              t.prodcateno, t.prodcategrpno, t.prodgrp_title, t.prodgrp_seqno, t.prodgrp_visible, t.ids, t.prodgrp_cnt, t.prodgrp_rdate
    FROM prodcategrp c, prodcate t  
    WHERE c.prodcategrpno = t.prodcategrpno 
    ORDER BY c.prodcategrpno ASC, t.prodgrp_seqno ASC
    
     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- -------- ----- ------- ----- --- ---------------------
             1 CPU               1             1 DDR4 4G      1 Y       admin   0 2019-05-27 17:15:03.0
             2 그래픽카드             2             2 윈도우          1 Y       admin   0 2019-05-27 17:15:28.0
             3 운영체제              3             3 HDD(1TB)     1 Y       admin   0 2019-05-27 17:15:29.0

-- 1번 그룹만 출력, 해외여행 그룹만 JOIN 출력(사용빈도 높음)         
    SELECT c.prodcategrpno, c.prodgrp_title,
              t.prodcateno, t.prodcategrpno, t.prodgrp_title, t.prodgrp_seqno, t.prodgrp_visible, t.ids, t.prodgrp_cnt, t.prodgrp_rdate
    FROM prodcategrp c, prodcate t   
    WHERE (c.prodcategrpno = 1) AND (c.prodcategrpno = t.prodcategrpno) 
    ORDER BY c.prodcategrpno ASC, t.prodgrp_seqno ASC

     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- ------- ----- ------- ----- --- ---------------------
             1 CPU              1             1 DDR4 4G     1 Y       admin   0 2019-05-27 17:15:03.0

             
-- Read: 조회
SELECT prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate
FROM prodcate
WHERE prodcateno = 1;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
    
-- 수정
UPDATE prodcate
SET prodgrp_title='DDR4 8G', prodgrp_seqno=1, prodgrp_visible='Y', prodgrp_cnt=0, ids='manager'
WHERE prodcateno=1;

-- 한건의 레코드 삭제
DELETE FROM prodcate
WHERE prodcateno=1;

-- 모든 레코드 삭제
DELETE FROM prodcate;

13) 삭제
- 레코드 삭제 순서: 자식 cate -> 부모 categrp 

1) 하나의 레코드 삭제
DELETE FROM prodcate WHERE prodcateno = 4;

2) categrp(대분류) 값과 일치하는 다수의 레코드 삭제(많은 레코드가 삭제 될 수 있음)
DELETE FROM prodcate WHERE prodcategrpno = 1;

-- 출력순서의 낮춤(나중에 출력)
UPDATE prodcate
SET prodgrp_seqno = prodgrp_seqno + 1
WHERE prodcateno=1;

-- 출력 순서의 높임(먼저 출력)
UPDATE prodcate
SET prodgrp_seqno = prodgrp_seqno - 1
WHERE prodcateno=1;

-- 출력 변경
UPDATE prodcate
SET prodgrp_visible='Y' -- 출력
WHERE prodcateno=1;

UPDATE prodcate
SET prodgrp_visible='N' -- 숨기기
WHERE prodcateno=1;

-- 최대값
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcate;

 SEQNO
 -----
     2
     
-- MAX 함수는 레코드가 없으면 null을 출력함으로 사칙연산이 불가능함.
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcate;

 prodgrp_seqno
 -------
    null

-- NVL 함수의 사용으로 null 값일경우 0으로 변경되어 1이 출력됨.
SELECT NVL(MAX(prodgrp_seqno), 0)+1 as prodgrp_seqno 
FROM prodcate;

 prodgrp_seqno
 -----
     1    

-- 등록된 글 수 증가
UPDATE prodcate
SET prodgrp_cnt = prodgrp_cnt + 1
WHERE prodcateno=1;

-- 등록된 글 수 감소
UPDATE prodcate
SET prodgrp_cnt = prodgrp_cnt - 1
WHERE prodcateno=1;

12) prodcategrp(대분류) 값에 따른 갯수 산출
SELECT COUNT(*) as prodgrp_cnt
FROM prodcate
WHERE prodcategrpno = 1;
 CNT
 -----
   1
   
 ▷ /webapp/WEB-INF/doc/dbms/product.sql
-----------------------------------------------------------------------------------
DROP TABLE product;
DROP TABLE member;
 
CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (mno)                  -- 한번 등록된 값은 중복 안됨
);
 
COMMENT ON TABLE member is '리조트 회원';
COMMENT ON COLUMN member.mno is '리조트 회원 번호';


-----------------------------------비추: 아래 부분 사용하지 마시오--------------------------------------------

DROP SEQUENCE product_seq;

CREATE SEQUENCE product_seq
START WITH   1            --시작번호
INCREMENT BY 1          --증가값
MAXVALUE   99999999  --최대값, NUMBER(7) 대응
CACHE        2               --시쿼스 변경시 자주 update되는 것을 방지하기위한 캐시값
NOCYCLE;  

2. 글 추가(C: Create) 
SELECT prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate
FROM prodcate
ORDER BY prodgrp_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
          4             2 윈도우         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 윈도우         1 Y         0 admin 2019-05-14 11:39:15.0

INSERT INTO product(prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate,
                  price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip)
VALUES(product_seq.nextval, 1, 'LG로지텍 HDD(1TB)', 1, 'Y', 0, sysdate,
            50000, '좋은가격 좋은품질', '123', 0, 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate,
                  price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip)
VALUES(product_seq.nextval, 2, '윈도우 10', 1, 'Y', 0, sysdate,
            50000, '좋은가격 좋은품질', '123', 0, 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate,
                  price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip)
VALUES(product_seq.nextval, 3, '삼성전자 DDR4 4G', 1, 'Y', 0, sysdate,
            50000, '좋은가격 좋은품질', '123', 0, 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');

-----------------------------------비추: 윗 부분 사용하지 마시오--------------------------------------------

            
--   부모키 prodcategrpno가 없을 경우
--   ORA-02291: integrity constraint (AI4.SYS_C007705) violated - parent key not found
--   (0 rows affected)
            
            
3. 전체 글 목록(S:Total Select List), 최신글 먼저 출력 
   - ASC: 오름 차순, DESC: 내림 차순 
   - substring(컬럼명, 시작위치, 길이), 시작위치 1부터 시작: 문자열 일부만 선택
   - 함수 사용시 컬럼명이 매우 길어짐으로 
     'SUBSTR(prodgrp_rdate, 1, 10)' 문장을 as 키워드로 'prodgrp_rdate' 변환합니다.
     
-- 모든 카테고리
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      3          2 윈도우 10             1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0

-- 목록 출력시 content, passwd 컬럼은 생략하여 구현
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- ------- -------- ------------ ----- ------- ----
      3          2 윈도우 10             1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0

SELECT prodno, prodcateno, prodgrp_title, file1, thumb1, size1
FROM product
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          FILE1    THUMB1       SIZE1
 ------ ---------- -------------- -------- ------------ -----
      3          2 윈도우 10         cafe.jpg spring_t.jpg  1000
      2          1 LG로지텍 HDD(1TB) cafe.jpg spring_t.jpg  1000

-- 'LG로지텍 HDD(1TB)'만 출력
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodno = 2
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0

-- '국내 여행'만 출력, content 컬럼의 출력
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, SUBSTR(content, 1, 150) as content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodno = 2
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0

4. product 조회

1) 조회수 증가 
UPDATE product
SET prodgrp_cnt = prodgrp_cnt + 1
WHERE prodno=1;

2) 1건의 글 보기(R:Read, PK 사용) 
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodno = 2;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0

5. 패스워드 검사
   - COUNT(): 발생한 레코드의 수를 계산, 레코드가 없으면 0 출력
   
SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodno=2 AND passwd='123';

 CNT
 ---
   1

   
6. 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음. 
    
1) 글만 수정 
UPDATE product
SET content='내용 변경'
WHERE prodno=2;
  
2) Visible 수정
UPDATE product
SET prodgrp_visible = 'Y'
WHERE prodno=1;

3) 파일 삭제, 폴더에서 실제 파일 삭제 진행, DBMS는 파일명만 삭제
UPDATE product
SET file1='', thumb1='', size1=0
WHERE prodno=1;

4) 새로운 파일 등록
UPDATE product
SET file1='test.jpg', thumb1='test_m.jpg', size1=123
WHERE prodno=1;

5) 파일 교체
UPDATE product
SET file1='new.jpg', thumb1='new_m.jpg', size1=123
WHERE prodno=1;
 
7. 글 삭제(D:Delete) 
DELETE FROM product
WHERE prodno = 1;

DELETE FROM product
WHERE prodno <= 4;

DELETE FROM product
WHERE prodno >= 71;


8. 검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - rname, prodgrp_title, content 컬럼 대상

1) 선언: 
    - WHERE prodgrp_title LIKE '삼성'
       prodgrp_title 컬럼의 값이 '삼성'인 레코드 전부 출력

    - WHERE prodgrp_title LIKE '%삼성%'
      prodgrp_title 컬럼의 값중 '삼성'가 들어간 레코드 전부 출력

    - WHERE prodgrp_title LIKE '삼성%'
      prodgrp_title 컬럼의 값중 '삼성'로 시작하는 레코드 전부 출력

    - WHERE prodgrp_title LIKE '%삼성'
      prodgrp_title 컬럼의 값중 '삼성'로 종료하는 레코드 전부 출력
   

2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;

4) 제목으로 검색  
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodgrp_title LIKE '%삼성%'
ORDER BY prodno DESC;

5) 내용으로 검색
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE content LIKE '%PC%'
ORDER BY prodno DESC;

6) 제목, 내용으로 검색
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodgrp_title LIKE '%삼성%' OR content LIKE '%PC%'
ORDER BY prodno DESC;
 
7) 카테고리별 검색
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodcateno=11 AND (prodgrp_title LIKE '%삼성%' OR content LIKE '%PC%')
ORDER BY prodno DESC;
  
 
9. 페이징 
-- 페이징이 안되는 SQL
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodcateno = 1
ORDER BY prodno DESC;

-- Step 1: 정렬
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodcateno = 1
ORDER BY prodno DESC;

-- Step 2: rownum 발생
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, rownum as r
FROM (
          SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                     price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
          FROM product
          WHERE prodcateno = 1
          ORDER BY prodno DESC
);         

-- Step 3: 1 페이지
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, rownum as r
FROM (
          SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                     price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
          FROM product
          WHERE prodcateno = 1
          ORDER BY prodno DESC
);        

SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, r
FROM (
          SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                     price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, rownum as r
          FROM (
                     SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                                price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
                     FROM product
                     WHERE prodcateno = 1
                     ORDER BY prodno DESC
          )   
)
WHERE r >= 1 AND r <= 3;


-- Step 3: 2 페이지
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, r
FROM (
          SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                     price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, rownum as r
          FROM (
                     SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                                price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
                     FROM product
                     WHERE prodcateno = 1
                     ORDER BY prodno DESC
          )   
)
WHERE r >= 4 AND r <= 6;


-- Step 3: 3 페이지
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, r
FROM (
          SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                     price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, rownum as r
          FROM (
                     SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                                price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
                     FROM product
                     WHERE prodcateno = 1
                     ORDER BY prodno DESC
          )   
)
WHERE r >= 7 AND r <= 9;


       
10. 검색된 레코드 갯수
SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodcateno = 1 AND prodgrp_title LIKE '%삼성%'
ORDER BY prodno DESC;

SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodcateno = 1 AND content LIKE '%PC%'
ORDER BY prodno DESC;

SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodcateno = 1 AND (prodgrp_title LIKE '%삼성%' OR content LIKE '%PC%')
ORDER BY prodno DESC;
 
 
11. 펼쳐보기
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, r
FROM (
          SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                     price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, rownum as r
          FROM (
                     SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                                price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
                     FROM product
                     WHERE prodcateno = 1
                     ORDER BY prodno DESC
          )   
)
WHERE r >= 1 AND r <= 1;


13. 카테고리의 삭제
-- 1번 카테고리의 등록 글수 카운트
SELECT COUNT(prodno) as prodgrp_cnt
FROM product
WHERE prodcateno=1;
 
-- 삭제, 첨부 파일, Thumb 파일, MP3, MP4를 삭제해야함으로 1건씩 삭제
DELETE FROM product
WHERE prodno = 1;

14. 평균 별점

SELECT a.prodno, a.prodcateno, a.prodgrp_title, AVG(b.score)
FROM product a, review b

SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;
-----------------------------------------------------------------------------------
