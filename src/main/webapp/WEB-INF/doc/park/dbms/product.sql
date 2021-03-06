▷ /webapp/WEB-INF/doc/dbms/product.sql
-----------------------------------------------------------------------------------
DROP TABLE product;
DROP TABLE member;

CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (mno)                  -- 한번 등록된 값은 중복 안됨
);

CREATE TABLE admin (
  adminno       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (adminno)                  -- 한번 등록된 값은 중복 안됨
);
 
COMMENT ON TABLE member is '리조트 회원';
COMMENT ON COLUMN member.mno is '리조트 회원 번호';


DROP TABLE product;

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
    prod_viewcnt               NUMBER(8)    DEFAULT 0     NOT NULL,
    ip                      VARCHAR2(15)     NOT NULL,
  FOREIGN KEY (prodcateno) REFERENCES prodcate (prodcateno),
  FOREIGN KEY (adminno) REFERENCES ADMIN (adminno)
);

ALTER TABLE product RENAME COLUMN viewprod_cnt  TO prod_viewcnt;

viewprod_cnt 

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

DROP SEQUENCE product_seq;

CREATE SEQUENCE product_seq
START WITH   1            --시작번호
INCREMENT BY 1          --증가값
MAXVALUE   99999999  --최대값, NUMBER(7) 대응
CACHE        2               --시쿼스 변경시 자주 update되는 것을 방지하기위한 캐시값
NOCYCLE;  

2. 글 추가(C: Create) 
SELECT prodcateno, prodcateprod_grpno, prod_title, seqno, prod_visible, prod_cnt, ids, prod_rdate
FROM prodcate
ORDER BY seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
          4             2 윈도우         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 윈도우         1 Y         0 admin 2019-05-14 11:39:15.0

INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 1, 'LG로지텍 HDD(1TB)', 1, 'Y', sysdate,
            50000, '좋은가격 좋은품질', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 2, '윈도우 10', 1, 'Y', sysdate,
            50000, '좋은가격 좋은품질', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 3, '삼성전자 DDR4 4G', 1, 'Y', sysdate,
            50000, '좋은가격 좋은품질', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');

-----------------------------------비추: 윗 부분 사용하지 마시오--------------------------------------------

            
--   부모키 prodcateprod_grpno가 없을 경우
--   ORA-02291: integrity constraint (AI4.SYS_C007705) violated - parent key not found
--   (0 rows affected)
DELETE FROM product
            
SELECT prodcateno FROM prodcate

INSERT INTO product(productno, 
                                prodcateno, prod_title, prod_content, prod_good,
                                thumbs, files, sizes, prod_cnt, prod_rdate, 
                                prod_grpno, prod_indent,
                                prod_price, prod_visible, ip)
VALUES((SELECT NVL(MAX(productno), 0) + 1 as productno FROM product), 
             1, 'LG로지텍 HDD(1TB)', '좋은가격 좋은품질', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
             
INSERT INTO product(productno, 
                                prodcateno, prod_title, prod_content, prod_good,
                                thumbs, files, sizes, prod_cnt, prod_rdate, 
                                prod_grpno, prod_indent,
                                prod_price, prod_visible, ip)
VALUES((SELECT NVL(MAX(productno), 0) + 1 as productno FROM product), 
             2, 'LG로지텍 HDD(2TB)', '좋은가격 좋은품질', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
             
INSERT INTO product(productno, 
                                prodcateno, prod_title, prod_content, prod_good,
                                thumbs, files, sizes, prod_cnt, prod_rdate, 
                                prod_grpno, prod_indent,
                                prod_price, prod_visible, ip)
VALUES((SELECT NVL(MAX(productno), 0) + 1 as productno FROM product), 
             3, 'LG로지텍 HDD(3TB)', '좋은가격 좋은품질', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
            
3. 전체 글 목록(S:Total Select List), 최신글 먼저 출력 
   - ASC: 오름 차순, DESC: 내림 차순 
   - substring(컬럼명, 시작위치, 길이), 시작위치 1부터 시작: 문자열 일부만 선택
   - 함수 사용시 컬럼명이 매우 길어짐으로 
     'SUBSTR(prod_rdate, 1, 10)' 문장을 as 키워드로 'prod_rdate' 변환합니다.
     
-- 모든 카테고리
SELECT productno, prodcateno, prod_title, prod_content, prod_good,
           thumbs, files, sizes, prod_cnt, prod_rdate, prod_grpno,
           prod_indent, prod_price, prod_visible, ip
FROM product
ORDER BY productno DESC;

SELECT* FROM product
 PRODUCTNO PRODCATENO PROD_TITLE     PROD_CONTENT PROD_GOOD THUMBS     FILES    SIZES PROD_CNT PROD_RDATE            PROD_GRPNO PROD_INDENT PROD_PRICE PROD_VISIBLE IP
 --------- ---------- -------------- ------------ --------- ---------- -------- ----- -------- --------------------- ---------- ----------- ---------- ------------ -------
         3          3 LG로지텍 HDD(3TB) 좋은가격 좋은품질           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:31.0          3           0          0 Y            http://
         2          2 LG로지텍 HDD(2TB) 좋은가격 좋은품질           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:26.0          2           0          0 Y            http://
         1          1 LG로지텍 HDD(1TB) 좋은가격 좋은품질           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:16.0          1           0          0 Y            http://

-- 목록 출력시 prod_content, passwd 컬럼은 생략하여 구현
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- ------- -------- ------------ ----- ------- ----
      3          2 윈도우 10             1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0

SELECT productno, prodcateno, prod_title, files, thumbs, sizes
FROM product
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          FILE1    THUMB1       SIZE1
 ------ ---------- -------------- -------- ------------ -----
      3          2 윈도우 10         cafe.jpg spring_t.jpg  1000
      2          1 LG로지텍 HDD(1TB) cafe.jpg spring_t.jpg  1000

-- 'LG로지텍 HDD(1TB)'만 출력
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE productno = 2
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0

-- '국내 여행'만 출력, prod_content 컬럼의 출력
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, SUBSTR(prod_content, 1, 150) as prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE productno = 2
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0

4. product 조회

1) 조회수 증가 
UPDATE product
SET prod_cnt = prod_cnt + 1
WHERE productno=1;

2) 1건의 글 보기(R:Read, PK 사용) 
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE productno = 2;

SELECT productno, prod_title, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes
FROM product
WHERE productno = 3;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG로지텍 HDD(1TB)     1 Y         0 2019-05-14 50000 좋은가격 좋은품질 123          0 cafe.jpg spring_t.jpg  1000 http://    0

5. 패스워드 검사
   - COUNT(): 발생한 레코드의 수를 계산, 레코드가 없으면 0 출력
   
SELECT COUNT(*) as prod_cnt 
FROM product
WHERE productno=2 AND passwd='123';

 CNT
 ---
   1

   
6. 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음. 
    
1) 글만 수정 
UPDATE product
SET prod_content='내용 변경'
WHERE productno=2;

UPDATE product
SET prod_cnt=0;


UPDATE product
SET prod_title='내용 변경', prod_content='내용 변경',
      thumbs='aaa', files='aaaa', sizes='aaaaa', prod_word='aaaaaa',
      ip='http'
WHERE productno=2;

  
2) Visible 수정
UPDATE product
SET prod_visible = 'Y'
WHERE productno=1;

UPDATE product
SET prod_good = prod_good + 1
WHERE productno=1;

UPDATE product
SET prod_viewcnt = prod_viewcnt + 1
WHERE productno=1;

3) 파일 삭제, 폴더에서 실제 파일 삭제 진행, DBMS는 파일명만 삭제
UPDATE product
SET files='', thumbs='', sizes=0
WHERE productno=1;

4) 새로운 파일 등록
UPDATE product
SET files='test.jpg', thumbs='test_m.jpg', sizes=123
WHERE productno=1;

5) 파일 교체
UPDATE product
SET files='new.jpg', thumbs='new_m.jpg', sizes=123
WHERE productno=1;
 
7. 글 삭제(D:Delete) 

SELECT productno, prodcateno
FROM product
ORDER BY productno DESC;

SELECT productno, prod_good
FROM product
WHERE productno = 1;

SELECT productno, prod_viewcnt
FROM product
WHERE productno = 2;

DELETE FROM product
WHERE prodcateno = 3;

DELETE FROM product
WHERE productno = 1;

DELETE FROM product
WHERE productno <= 4;

DELETE FROM product
WHERE productno >= 71;


8. 검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - rname, prod_title, prod_content 컬럼 대상

1) 선언: 
    - WHERE prod_title LIKE '삼성'
       prod_title 컬럼의 값이 '삼성'인 레코드 전부 출력

    - WHERE prod_title LIKE '%삼성%'
      prod_title 컬럼의 값중 '삼성'가 들어간 레코드 전부 출력

    - WHERE prod_title LIKE '삼성%'
      prod_title 컬럼의 값중 '삼성'로 시작하는 레코드 전부 출력

    - WHERE prod_title LIKE '%삼성'
      prod_title 컬럼의 값중 '삼성'로 종료하는 레코드 전부 출력
   

    SELECT productno,
        prodcateno, prod_title, prod_content, prod_cnt
    FROM product
    WHERE prodcateno=10
    ORDER BY prod_grpno DESC, prod_ansnum ASC
      
      
2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;

4) 제목으로 검색  
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_title LIKE '%삼성%'
ORDER BY productno DESC;

5) 내용으로 검색
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_content LIKE '%PC%'
ORDER BY productno DESC;

6) 제목, 내용으로 검색
SELECT productno, prodcateno, prod_title, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_title LIKE '%삼성%' OR prod_content LIKE '%PC%'
ORDER BY productno DESC;
 
7) 카테고리별 검색
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno=11 AND (prod_title LIKE '%삼성%' OR prod_content LIKE '%PC%')
ORDER BY productno DESC;
 
조인

SELECT c.prodcateno, c.prodcate_title,
               t.productno, t.prodcateno, t.prod_title,
               t.prod_visible, t.prod_cnt, t.prod_rdate
     FROM prodcate c, product t
     WHERE (t.productno = 10) AND (c.prodcateno = 10)

 
9. 페이징 
-- 페이징이 안되는 SQL
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno = 1
ORDER BY productno DESC;

-- Step 1: 정렬
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno = 1
ORDER BY productno DESC;

-- Step 2: rownum 발생
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
FROM (
          SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
          FROM product
          WHERE prodcateno = 1
          ORDER BY productno DESC
);         

------------------------------------------------------중요------------------------------
-- 낮은 가격순
SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product 
                      ORDER BY prod_price ASC
             )
    )
    WHERE r >=1 AND r <= 3
    <!-- WHERE r >=1 AND r <= 3 -->

    -- 높은 가격순
    SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product
                      ORDER BY prod_price DESC
             )
    )
    WHERE r >=1 AND r <= 3
    
    -- 상품명 순 가->힣
    SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product
                          WHERE prodcateno=10 AND prod_word LIKE '%북해%'  
                      ORDER BY prod_title ASC
             )
    )
    WHERE r >=1 AND r <= 3
    
    --인기순
    SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product
                          WHERE prodcateno=10 AND prod_word LIKE '%북해%'  
                      ORDER BY prod_cnt ASC
             )
    )
    WHERE r >=1 AND r <= 3
    <!-- WHERE r >=1 AND r <= 3 -->
------------------------------------------------------중요------------------------------
-- Step 3: 1 페이지
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
FROM (
          SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
          FROM product
          WHERE prodcateno = 1
          ORDER BY productno DESC
);        

SELECT productno, prodcateno, prod_title, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, r
FROM (
          SELECT productno, prodcateno, prod_title, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
          FROM (
                     SELECT productno, prodcateno, prod_title, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                                prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
                     FROM product
                     WHERE prodcateno = 10
                     ORDER BY productno DESC
          )   
)
WHERE r >= 1 AND r <= 3;


-- Step 3: 2 페이지
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, r
FROM (
          SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
          FROM (
                     SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                                prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
                     FROM product
                     WHERE prodcateno = 1
                     ORDER BY productno DESC
          )   
)
WHERE r >= 4 AND r <= 6;


-- Step 3: 3 페이지
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, r
FROM (
          SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
          FROM (
                     SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                                prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
                     FROM product
                     WHERE prodcateno = 1
                     ORDER BY productno DESC
          )   
)
WHERE r >= 7 AND r <= 9;


       
10. 검색된 레코드 갯수
SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND prod_title LIKE '%삼성%'
ORDER BY productno DESC;

SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND prod_content LIKE '%PC%'
ORDER BY productno DESC;

SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND (prod_title LIKE '%삼성%' OR prod_content LIKE '%PC%')
ORDER BY productno DESC;
 
 
11. 펼쳐보기
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, r
FROM (
          SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
          FROM (
                     SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                                prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
                     FROM product
                     WHERE prodcateno = 1
                     ORDER BY productno DESC
          )   
)
WHERE r >= 1 AND r <= 1;


13. 카테고리의 삭제
-- 1번 카테고리의 등록 글수 카운트
SELECT COUNT(productno) as prod_cnt
FROM product
WHERE prodcateno=1;
 
-- 삭제, 첨부 파일, Thumb 파일, MP3, MP4를 삭제해야함으로 1건씩 삭제
DELETE FROM product
WHERE productno = 1;

14. 평균 별점
SELECT a.productno, a.prodcateno, a.prod_title, AVG(b.score)
FROM product a, review b

SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;
-----------------------------------------------------------------------------------