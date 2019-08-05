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
SELECT * FROM prodcategrp ORDER BY prodcate_seqno ASC;
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

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES(prodcate_seq.nextval, 1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES(prodcate_seq.nextval, 2, '윈도우', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES(prodcate_seq.nextval, 3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);

-----------------------------------비추: 윗 부분 사용하지 마시오--------------------------------------------

   
--   부모키 prodcategrpno가 없을 경우
--   ORA-02291: integrity constraint (AI4.SYS_C007705) violated - parent key not found
--   (0 rows affected)
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '윈도우', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
               3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);
   
-- List
SELECT prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate
FROM prodcate
ORDER BY prodcate_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
          4             2 윈도우         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 윈도우         1 Y         0 admin 2019-05-14 11:39:15.0

          
③ 그룹별로 정렬하여 출력 

SELECT prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate
FROM prodcate 
ORDER BY prodcategrpno ASC, prodcate_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- -------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G      1 Y         0 admin 2019-05-27 17:15:03.0
          2             2 윈도우          1 Y         0 admin 2019-05-27 17:15:28.0
          3             3 HDD(1TB)     1 Y         0 admin 2019-05-27 17:15:29.0
          
-- 모든 그룹의  join
    SELECT c.prodcategrpno, c.prodcate_title,
              t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno, t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt, t.prodcate_rdate
    FROM prodcategrp c, prodcate t  
    WHERE c.prodcategrpno = t.prodcategrpno 
    ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC
    
     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- -------- ----- ------- ----- --- ---------------------
             1 CPU               1             1 DDR4 4G      1 Y       admin   0 2019-05-27 17:15:03.0
             2 그래픽카드             2             2 윈도우          1 Y       admin   0 2019-05-27 17:15:28.0
             3 운영체제              3             3 HDD(1TB)     1 Y       admin   0 2019-05-27 17:15:29.0

-- 1번 그룹만 출력, 해외여행 그룹만 JOIN 출력(사용빈도 높음)         
    SELECT c.prodcategrpno, c.prodcate_title,
              t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno, t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt, t.prodcate_rdate
    FROM prodcategrp c, prodcate t   
    WHERE (c.prodcategrpno = 1) AND (c.prodcategrpno = t.prodcategrpno) 
    ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC

     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- ------- ----- ------- ----- --- ---------------------
             1 CPU              1             1 DDR4 4G     1 Y       admin   0 2019-05-27 17:15:03.0

             
-- Read: 조회
SELECT prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate
FROM prodcate
WHERE prodcateno = 1;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
    
-- 수정
UPDATE prodcate
SET prodcate_title='DDR4 8G', prodcate_seqno=1, prodcate_visible='Y', prodcate_cnt=0, prodcate_ids='manager'
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
SET prodcate_seqno = prodcate_seqno + 1
WHERE prodcateno=1;

-- 출력 순서의 높임(먼저 출력)
UPDATE prodcate
SET prodcate_seqno = prodcate_seqno - 1
WHERE prodcateno=1;

UPDATE prodcate
SET prodcate_cnt = 1
WHERE prodcateno=10;


-- 출력 변경
UPDATE prodcate
SET prodcate_visible='Y' -- 출력
WHERE prodcateno=1;

UPDATE prodcate
SET prodcate_visible='N' -- 숨기기
WHERE prodcateno=1;

-- 최대값
SELECT MAX(prodcate_seqno)+1 as prodcate_seqno 
FROM prodcate;

 SEQNO
 -----
     2
     
-- MAX 함수는 레코드가 없으면 null을 출력함으로 사칙연산이 불가능함.
SELECT MAX(prodcate_seqno)+1 as prodcate_seqno 
FROM prodcate;

 prodcate_seqno
 -------
    null

-- NVL 함수의 사용으로 null 값일경우 0으로 변경되어 1이 출력됨.
SELECT NVL(MAX(prodcate_seqno), 0)+1 as prodcate_seqno 
FROM prodcate;

 prodcate_seqno
 -----
     1    

-- 등록된 글 수 증가
UPDATE prodcate
SET prodcate_cnt = prodcate_cnt + 1
WHERE prodcateno=1;

UPDATE prodcate
SET prodcategrpno = 2
WHERE prodcateno=11;

-- 등록된 글 수 감소
UPDATE prodcate
SET prodcate_cnt = prodcate_cnt - 1
WHERE prodcateno=1;

12) prodcategrp(대분류) 값에 따른 갯수 산출
SELECT COUNT(*) as count
FROM prodcate
WHERE prodcategrpno = 1;
 CNT
 -----
   1