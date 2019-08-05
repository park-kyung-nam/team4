2. SQL:  /webapp/WEB-INF/doc/dbms/prodcate_join_c.sql
-------------------------------------------------------------------------------------
1. 2개 이상의 테이블 연결: JOIN 
      - PK, FK 컬럼을 대상으로 합니다.
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
      
1) FK 테이블 데이터 삭제
DELETE FROM prodcate;

2) PK 테이블 데이터 삭제
DELETE FROM prodcategrp;
    
3) PK 테이블 데이터 추가

INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             'CPU', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '그래픽카드', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '운영체제', 1, 'Y',0 ,sysdate);


SELECT * FROM prodcategrp ORDER BY prodcategrpno ASC;

 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODGRP_VISIBLE PRODGRP_CNT PRODGRP_RDATE
 ------------- ------------- ------------- --------------- ----------- ---------------------
             1 CPU                       1 Y                         0 2019-06-04 17:13:26.0
             2 그래픽카드                     1 Y                         0 2019-06-04 17:13:27.0
             3 운영체제                      1 Y                         0 2019-06-04 17:13:28.0



4) FK 테이블 데이터 추가

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '윈도우', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
               3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);
   

DELETE FROM prodcate WHERE prodcateno=4; -- 레코드 삭제

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '윈도우', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
               3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);
             
5) PK 테이블 데이터 확인
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_rdate 
FROM prodcategrp 
ORDER BY prodgrp_seqno ASC;

 PK
 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODGRP_VISIBLE PRODGRP_RDATE
 ------------- ------------- ------------- --------------- ---------------------
             1 CPU                       1 Y               2019-06-04 17:13:26.0
             2 그래픽카드                     1 Y               2019-06-04 17:13:27.0
             3 운영체제                      1 Y               2019-06-04 17:13:28.0

         
6) FK 테이블 데이터 확인
SELECT prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_ids, prodcate_rdate, prodcate_cnt
FROM prodcate 
ORDER BY prodcateno ASC, prodcate_seqno ASC;

 PRODCATENO PRODCATEGRPNO PRODCATE_TITLE PRODCATE_SEQNO PRODCATE_VISIBLE PRODCATE_IDS PRODCATE_RDATE        PRODCATE_CNT
 ---------- ------------- -------------- -------------- ---------------- ------------ --------------------- ------------
          1             1 DDR4 4G                     1 Y                admin        2019-06-04 17:13:45.0            0
          2             2 윈도우                         1 Y                admin        2019-06-04 17:13:46.0            0
          3             3 HDD(1TB)                    1 Y                admin        2019-06-04 17:13:47.0            0


2. Cross join
- 정보로서의 가치가 매우 부족함.
- 권장하지 않음.
SELECT prodcategrp.prodcategrpno, prodcategrp.prodgrp_title,
          prodcate.prodcateno, prodcate.prodcategrpno, prodcate.prodcate_title,
          prodcate.prodcate_seqno, prodcate.prodcate_visible,
          prodcate.prodcate_ids, prodcate.prodcate_cnt
FROM prodcategrp, prodcate
ORDER BY prodcategrp.prodcategrpno ASC, prodcate.prodcate_seqno ASC;

 PRODCATEGRPNO PRODGRP_TITLE PRODCATENO PRODCATEGRPNO PRODCATE_TITLE PRODCATE_SEQNO PRODCATE_VISIBLE PRODCATE_IDS PRODCATE_CNT
 ------------- ------------- ---------- ------------- -------------- -------------- ---------------- ------------ ------------
             1 CPU                    1             1 DDR4 4G                     1 Y                admin                   0
             1 CPU                    3             3 HDD(1TB)                    1 Y                admin                   0
             1 CPU                    2             2 윈도우                         1 Y                admin                   0
             2 그래픽카드                  1             1 DDR4 4G                     1 Y                admin                   0
             2 그래픽카드                  3             3 HDD(1TB)                    1 Y                admin                   0
             2 그래픽카드                  2             2 윈도우                         1 Y                admin                   0
             3 운영체제                   3             3 HDD(1TB)                    1 Y                admin                   0
             3 운영체제                   1             1 DDR4 4G                     1 Y                admin                   0
             3 운영체제                   2             2 윈도우                         1 Y                admin                   0


         
-- 테이블 별명의 사용
-- categrp c: 테이블명이 너무 길어 categrp 테이블의 별명을 'c'로 붙임.
SELECT c.prodcategrpno, c.prodgrp_title,
          t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno,
          t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt
FROM prodcategrp c, prodcate t  
ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC;

 PRODCATEGRPNO PRODGRP_TITLE PRODCATENO PRODCATEGRPNO PRODCATE_TITLE PRODCATE_SEQNO PRODCATE_VISIBLE PRODCATE_IDS PRODCATE_CNT
 ------------- ------------- ---------- ------------- -------------- -------------- ---------------- ------------ ------------
             1 CPU                    1             1 DDR4 4G                     1 Y                admin                   0
             1 CPU                    3             3 HDD(1TB)                    1 Y                admin                   0
             1 CPU                    2             2 윈도우                         1 Y                admin                   0
             2 그래픽카드                  1             1 DDR4 4G                     1 Y                admin                   0
             2 그래픽카드                  3             3 HDD(1TB)                    1 Y                admin                   0
             2 그래픽카드                  2             2 윈도우                         1 Y                admin                   0
             3 운영체제                   3             3 HDD(1TB)                    1 Y                admin                   0
             3 운영체제                   1             1 DDR4 4G                     1 Y                admin                   0
             3 운영체제                   2             2 윈도우                         1 Y                admin                   0


         
          
3. Equal(INNER) JOIN FK 테이블을 기준으로 합니다.
- WHERE 그룹(부모) 테이블 PK = 데이터(자식) 테이블 FK
- WHERE c.categrpno = t.categrpno: 2개의 테이블에서 categrpno 컬럼이 같은
  레코드를 읽어 메모리상에서 하나의 레코드로 결합하여 메모리 테이블을
  생성합니다. (DBMS는 많은 메모리 사용)

SELECT c.categrpno, c.title,
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, cate t  
WHERE c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

         categrp                                                cate
 -----------------------      ------------------------------------------------------------------------
        PK                          PK                 FK
 CATEGRPNO NAME       CATENO  CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ----------    -----------------  --------------- ------ -------- --------  ----   -----
         1 해외 여행          1                    1           일본         1 Y       admin   0
         1 해외 여행          2                    1           스위스       2 Y       admin   0
         1 해외 여행          3                    1           베트남       3 Y       admin   0
         2 국내 여행          4                    2           강원도       1 Y       admin   0
         2 국내 여행          5                    2           북한        2 Y       admin   0

-- seqno 컬럼의 중복
    SELECT c.prodcategrpno, c.prodgrp_title, c.prodgrp_seqno,
              t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno,
              t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt
    FROM prodcategrp c, prodcate t  
    WHERE c.prodcategrpno = t.prodcategrpno
    ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC;
    
    SELECT c.prodcategrpno, c.prodgrp_title,
              t.prodcateno, t.prodcate_title
    FROM prodcategrp c, prodcate t  
    WHERE c.prodcategrpno = t.prodcategrpno
    ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC;

 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODCATENO PRODCATEGRPNO PRODCATE_TITLE PRODCATE_SEQNO PRODCATE_VISIBLE PRODCATE_IDS PRODCATE_CNT
 ------------- ------------- ------------- ---------- ------------- -------------- -------------- ---------------- ------------ ------------
             1 CPU                       1          1             1 DDR4 4G                     1 Y                admin                   0
             2 그래픽카드                     1          2             2 윈도우                         1 Y                admin                   0
             3 운영체제                      1          3             3 HDD(1TB)                    1 Y                admin                   0


SELECT c.prodcategrpno, c.prodgrp_title,
               t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno,
               t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt, t.prodcate_rdate
     FROM prodcategrp c, prodcate t
     WHERE (t.prodcateno = 1) AND (c.prodcategrpno = t.prodcategrpno) 
             

          
-- seqno 컬럼의 중복, cate_seqno 처럼 컬럼 별명을 지정하여 해결
    SELECT c.categrpno, c.name, c.seqno,
              t.cateno, t.categrpno, t.title, t.seqno as cate_seqno, t.visible, t.ids, t.cnt
    FROM categrp c, cate t  
    WHERE c.categrpno = t.categrpno
    ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  SEQNO CATENO CATEGRPNO TITLE CATE_SEQNO VISIBLE IDS   CNT
 --------- ----- ----- ---------- --------- ----- -------------- ------- ----- ---
         1 해외 여행     1          1         1 일본                 1 Y       admin   0
         1 해외 여행     1          2         1 스위스              2 Y       admin   0
         1 해외 여행     1          3         1 베트남              3 Y       admin   0
         2 국내 여행     2          4         2 강원도              1 Y       admin   0
         2 국내 여행     2          5         2 북한                 2 Y       admin   0

4. LEFT Outer JOIN
- 부모테이블에만 있고 자식 테이블에는 대응하는 레코드가 없는 경우의 출력
- cate FK 테이블에 '+' 선언을하면 레코드 대응이 없어도 
  NULL 값으로 대응하여 출력

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '기타', 3, 'Y', sysdate);

SELECT * FROM categrp ORDER BY categrpno ASC;

 CATEGRPNO NAME  SEQNO VISIBLE RDATE
 --------- ----- ----- ------- ---------------------
         1 해외 여행     1 Y       2019-05-17 09:55:52.0
         2 국내 여행     2 Y       2019-05-17 09:55:53.0
         3 기타           3 Y       2019-05-17 10:57:16.0

-- FK 테이블에 '+' 기호를 선언하면 PK 테이블이 모두 출력됨 
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, cate t  
WHERE c.categrpno = t.categrpno(+)
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ----
         1 해외 여행          1         1 일본        1 Y       admin    0
         1 해외 여행          2         1 스위스       2 Y       admin    0
         1 해외 여행          3         1 베트남       3 Y       admin    0
         2 국내 여행          4         2 강원도       1 Y       admin    0
         2 국내 여행          5         2 북한        2 Y       admin    0
         3 기타             NULL      NULL NULL   NULL NULL    NULL  NULL
         

-- ANSI Left Outer Join: 왼쪽 테이블 모두 출력
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c LEFT OUTER JOIN cate t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ----
         1 해외 여행          1         1 일본        1 Y       admin    0
         1 해외 여행          2         1 스위스       2 Y       admin    0
         1 해외 여행          3         1 베트남       3 Y       admin    0
         2 국내 여행          4         2 강원도       1 Y       admin    0
         2 국내 여행          5         2 북한        2 Y       admin    0
         3 기타          NULL      NULL NULL   NULL NULL    NULL  NULL

-- ANSI Right Outer Join, 
-- 무결성 제약조건의 손상으로 PK 없는 FK는 등록 불가하여 Equal(동등)과 같은 결과를
-- 출력함, 정보로서의 가치는 없음. 
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c RIGHT OUTER JOIN cate t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ---
         1 해외 여행          1         1 일본        1 Y       admin   0
         1 해외 여행          2         1 스위스       2 Y       admin   0
         1 해외 여행          3         1 베트남       3 Y       admin   0
         2 국내 여행          4         2 강원도       1 Y       admin   0
         2 국내 여행          5         2 북한        2 Y       admin   0
          
-- from절의 테이블의 위치를 변경함.
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM cate t RIGHT OUTER JOIN categrp c 
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ----
         1 해외 여행          1         1 일본        1 Y       admin    0
         1 해외 여행          2         1 스위스       2 Y       admin    0
         1 해외 여행          3         1 베트남       3 Y       admin    0
         2 국내 여행          4         2 강원도       1 Y       admin    0
         2 국내 여행          5         2 북한        2 Y       admin    0
         3 기타             NULL      NULL NULL   NULL NULL    NULL  NULL
  
          
5. SELF JOIN
-- 첫번째 레코드 등록시 생성될 PK 값을 FK 값으로 사용해야 최초 등록 가능. 
-- 두번째부터는 FK값으로 생성될 PK을 사용할 수는 있으나 정보로서의 의미는 없음.
           
DROP TABLE position;

CREATE TABLE position(
  positionno NUMBER(5) NOT NULL,
  name       VARCHAR(30) NOT NULL, 
  employee  VARCHAR(30) NOT NULL,
  officer     NUMBER(5) NOT NULL,
  PRIMARY KEY(positionno),
  FOREIGN KEY(officer) REFERENCES position(positionno)
);

COMMENT ON TABLE position is '직책';
COMMENT ON COLUMN position.positionno is '직책 번호';
COMMENT ON COLUMN position.name is '직책 이름';
COMMENT ON COLUMN position.employee is '사원명';
COMMENT ON COLUMN position.officer is '상급 직책 사원명';

-- FK가 생성될 PK를 값으로하는 경우, 첫번째 레코드만 예외적으로 최초 등록 가능
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '대표이사', '아로미', 1);
            
SELECT positionno,name, employee, officer
FROM position
ORDER BY positionno ASC;

 POSITIONNO NAME     EMPLOYEE OFFICER
 ---------------- -------     ------------- ----------
          1        대표이사  아로미            1
          
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '이사', '피어스', 10);
-- ORA-02291: integrity constraint (AI3.SYS_C007082) violated - parent key not found

-- 이사의 상관은 대표이사           
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '이사', '왕눈이', 1);

SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 대표이사 아로미            1
          2 이사   왕눈이            1

-- 상무의 상관은 이사     
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '상무', '가길동', 2);

SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 대표이사 아로미            1
          2 이사   왕눈이            1
          3 상무   가길동            2

-- DELETE FROM position WHERE positionno = 5;   

-- 부장의 상관은 상무            
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '부장', '나길동', 3);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 대표이사 아로미         1
          2 이사   왕눈이            1
          3 상무   가길동            2
          4 부장   나길동            3

INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '차장', '다길동', 4);

-- 차장의 상관은 부장   
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 대표이사 아로미         1
          2 이사   왕눈이            1
          3 상무   가길동            2
          4 부장   나길동            3
          5 차장   다길동            4

-- 과장의 상관은 차장
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '과장', '라길동', 5);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 대표이사 아로미         1
          2 이사   왕눈이            1
          3 상무   가길동            2
          4 부장   나길동            3
          5 차장   다길동            4
          6 과장   라길동            5

-- 대리의 상관은 과장
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '대리', '마길동', 6);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 대표이사 아로미         1
          2 이사   왕눈이            1
          3 상무   가길동            2
          4 부장   나길동            3
          5 차장   다길동            4
          6 과장   라길동            5
          7 대리   마길동            6

INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '대리2', '홍길순', 6);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 대표이사 아로미         1
          2 이사   왕눈이            1
          3 상무   가길동            2
          4 부장   나길동            3
          5 차장   다길동            4
          6 과장   라길동            5
          7 대리   마길동            6
          8 대리2  홍길순            6
          
-- Self join
SELECT p.positionno, p.name, p.employee, p.officer,
          c.name, c.employee
FROM position p, position c
WHERE p.officer = c.positionno 
ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER NAME EMPLOYEE
 ---------- ---- -------- ------- ---- --------
          1 대표이사 아로미         1 대표이사 아로미
          2 이사   왕눈이            1 대표이사 아로미
          3 상무   가길동            2 이사   왕눈이
          4 부장   나길동            3 상무   가길동
          5 차장   다길동            4 부장   나길동
          6 과장   라길동            5 차장   다길동
          7 대리   마길동            6 과장   라길동
          8 대리2  홍길순            6 과장   라길동

          
          
-- 참고: FK 없이 테이블 생성후 하나의 마스터 레코드(최초 등록) 입력수 FK 제약 조건 추가             
ALTER TABLE cate ADD CONSTRAINT cate_pk PRIMARY KEY (cateno);
ALTER TABLE cate ADD CONSTRAINT cate_officer_fk FOREIGN KEY (categrpno) REFERENCES categrp (categrpno);


-------------------------------------------------------------------------------------
         




