/**********************************/
/* Table Name: 제품 카테고리 그룹 */
/**********************************/
DROP TABLE prodcategrp;

CREATE TABLE prodcategrp(
		prodcategrpno                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		prodgrp_title                         		VARCHAR2(50)		 NOT NULL,
		prodgrp_seqno                         		NUMBER(5)		 DEFAULT 0		 NOT NULL,
		prodgrp_visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		prodgrp_cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		prodgrp_rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE prodcategrp is '제품 카테고리 그룹';
COMMENT ON COLUMN prodcategrp.prodcategrpno is '제품 그룹 번호';
COMMENT ON COLUMN prodcategrp.prodgrp_title  is '제품 그룹 제목';
COMMENT ON COLUMN prodcategrp.prodgrp_seqno is '출력 순서';
COMMENT ON COLUMN prodcategrp.prodgrp_visible is '출력 모드';
COMMENT ON COLUMN prodcategrp.prodgrp_cnt is '등록된 자료수';
COMMENT ON COLUMN prodcategrp.prodgrp_rdate is '그룹 생성일';

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
             
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '박경남', 1, 'Y',sysdate);
   
-- List
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate
FROM prodcategrp
ORDER BY prodgrp_seqno ASC;

SELECT prodcategrpno, prodgrp_title, prodgrp_cnt
FROM prodcategrp
ORDER BY prodgrp_seqno ASC;

 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODGRP_VISIBLE PRODGRP_CNT PRODGRP_RDATE
 ------------- ------------- ------------- --------------- ----------- ---------------------
             1 CPU                       1 Y                         0 2019-05-31 17:59:58.0
             3 운영체제                      1 Y                         0 2019-05-31 18:00:04.0
             2 그래픽카드                     1 Y                         0 2019-05-31 18:00:01.0

-- Read: 조회
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate
FROM prodcategrp
WHERE prodcategrpno = 1;

 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODGRP_VISIBLE PRODGRP_CNT PRODGRP_RDATE
 ------------- ------------- ------------- --------------- ----------- ---------------------
             1 CPU                       1 Y                         0 2019-05-31 17:59:58.0
    
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
