¢¹ /webapp/WEB-INF/doc/dbms/product.sql
-----------------------------------------------------------------------------------
DROP TABLE product;
DROP TABLE member;

CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- È¸¿ø ¹øÈ£, ·¹ÄÚµå¸¦ ±¸ºÐÇÏ´Â ÄÃ·³ 
  PRIMARY KEY (mno)                  -- ÇÑ¹ø µî·ÏµÈ °ªÀº Áßº¹ ¾ÈµÊ
);

CREATE TABLE admin (
  adminno       NUMBER(6) NOT NULL, -- È¸¿ø ¹øÈ£, ·¹ÄÚµå¸¦ ±¸ºÐÇÏ´Â ÄÃ·³ 
  PRIMARY KEY (adminno)                  -- ÇÑ¹ø µî·ÏµÈ °ªÀº Áßº¹ ¾ÈµÊ
);
 
COMMENT ON TABLE member is '¸®Á¶Æ® È¸¿ø';
COMMENT ON COLUMN member.mno is '¸®Á¶Æ® È¸¿ø ¹øÈ£';


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

COMMENT ON TABLE product is 'Á¦Ç°';
COMMENT ON COLUMN product.productno is 'Á¦Ç°¹øÈ£';
COMMENT ON COLUMN product.prodcateno is 'Á¦Ç° Ä«Å×°í¸® ¹øÈ£';
COMMENT ON COLUMN product.prod_title is 'Á¦Ç° Á¦¸ñ';
COMMENT ON COLUMN product.seqno is 'Ãâ·Â ¼ø¼­';
COMMENT ON COLUMN product.prod_visible is 'Ãâ·Â ¸ðµå';
COMMENT ON COLUMN product.prod_cnt is 'Á¦Ç°°¹¼ö';
COMMENT ON COLUMN product.prod_rdate is 'Á¦Ç° »ý¼ºÀÏ';
COMMENT ON COLUMN product.prod_price is '°¡°Ý';
COMMENT ON COLUMN product.prod_content is '³»¿ë';
COMMENT ON COLUMN product.passwd is 'ÆÐ½º¿öµå';
COMMENT ON COLUMN product.viewprod_cnt is 'Á¶È¸¼ö';
COMMENT ON COLUMN product.files is 'ÆÄÀÏ¸í';
COMMENT ON COLUMN product.thumbs is 'Preview ÀÌ¹ÌÁö';
COMMENT ON COLUMN product.sizes is 'ÆÄÀÏÅ©±â';
COMMENT ON COLUMN product.ip is 'IP';

-----------------------------------ºñÃß: ¾Æ·¡ ºÎºÐ »ç¿ëÇÏÁö ¸¶½Ã¿À--------------------------------------------

DROP SEQUENCE product_seq;

CREATE SEQUENCE product_seq
START WITH   1            --½ÃÀÛ¹øÈ£
INCREMENT BY 1          --Áõ°¡°ª
MAXVALUE   99999999  --ÃÖ´ë°ª, NUMBER(7) ´ëÀÀ
CACHE        2               --½ÃÄõ½º º¯°æ½Ã ÀÚÁÖ updateµÇ´Â °ÍÀ» ¹æÁöÇÏ±âÀ§ÇÑ Ä³½Ã°ª
NOCYCLE;  

2. ±Û Ãß°¡(C: Create) 
SELECT prodcateno, prodcateprod_grpno, prod_title, seqno, prod_visible, prod_cnt, ids, prod_rdate
FROM prodcate
ORDER BY seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
          4             2 À©µµ¿ì         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 À©µµ¿ì         1 Y         0 admin 2019-05-14 11:39:15.0

INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 1, 'LG·ÎÁöÅØ HDD(1TB)', 1, 'Y', sysdate,
            50000, 'ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 2, 'À©µµ¿ì 10', 1, 'Y', sysdate,
            50000, 'ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 3, '»ï¼ºÀüÀÚ DDR4 4G', 1, 'Y', sysdate,
            50000, 'ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');

-----------------------------------ºñÃß: À­ ºÎºÐ »ç¿ëÇÏÁö ¸¶½Ã¿À--------------------------------------------

            
--   ºÎ¸ðÅ° prodcateprod_grpno°¡ ¾øÀ» °æ¿ì
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
             1, 'LG·ÎÁöÅØ HDD(1TB)', 'ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
             
INSERT INTO product(productno, 
                                prodcateno, prod_title, prod_content, prod_good,
                                thumbs, files, sizes, prod_cnt, prod_rdate, 
                                prod_grpno, prod_indent,
                                prod_price, prod_visible, ip)
VALUES((SELECT NVL(MAX(productno), 0) + 1 as productno FROM product), 
             2, 'LG·ÎÁöÅØ HDD(2TB)', 'ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
             
INSERT INTO product(productno, 
                                prodcateno, prod_title, prod_content, prod_good,
                                thumbs, files, sizes, prod_cnt, prod_rdate, 
                                prod_grpno, prod_indent,
                                prod_price, prod_visible, ip)
VALUES((SELECT NVL(MAX(productno), 0) + 1 as productno FROM product), 
             3, 'LG·ÎÁöÅØ HDD(3TB)', 'ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
            
3. ÀüÃ¼ ±Û ¸ñ·Ï(S:Total Select List), ÃÖ½Å±Û ¸ÕÀú Ãâ·Â 
   - ASC: ¿À¸§ Â÷¼ø, DESC: ³»¸² Â÷¼ø 
   - substring(ÄÃ·³¸í, ½ÃÀÛÀ§Ä¡, ±æÀÌ), ½ÃÀÛÀ§Ä¡ 1ºÎÅÍ ½ÃÀÛ: ¹®ÀÚ¿­ ÀÏºÎ¸¸ ¼±ÅÃ
   - ÇÔ¼ö »ç¿ë½Ã ÄÃ·³¸íÀÌ ¸Å¿ì ±æ¾îÁüÀ¸·Î 
     'SUBSTR(prod_rdate, 1, 10)' ¹®ÀåÀ» as Å°¿öµå·Î 'prod_rdate' º¯È¯ÇÕ´Ï´Ù.
     
-- ¸ðµç Ä«Å×°í¸®
SELECT productno, prodcateno, prod_title, prod_content, prod_good,
           thumbs, files, sizes, prod_cnt, prod_rdate, prod_grpno,
           prod_indent, prod_price, prod_visible, ip
FROM product
ORDER BY productno DESC;

SELECT* FROM product
 PRODUCTNO PRODCATENO PROD_TITLE     PROD_CONTENT PROD_GOOD THUMBS     FILES    SIZES PROD_CNT PROD_RDATE            PROD_GRPNO PROD_INDENT PROD_PRICE PROD_VISIBLE IP
 --------- ---------- -------------- ------------ --------- ---------- -------- ----- -------- --------------------- ---------- ----------- ---------- ------------ -------
         3          3 LG·ÎÁöÅØ HDD(3TB) ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:31.0          3           0          0 Y            http://
         2          2 LG·ÎÁöÅØ HDD(2TB) ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:26.0          2           0          0 Y            http://
         1          1 LG·ÎÁöÅØ HDD(1TB) ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:16.0          1           0          0 Y            http://

-- ¸ñ·Ï Ãâ·Â½Ã prod_content, passwd ÄÃ·³Àº »ý·«ÇÏ¿© ±¸Çö
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- ------- -------- ------------ ----- ------- ----
      3          2 À©µµ¿ì 10             1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0
      2          1 LG·ÎÁöÅØ HDD(1TB)     1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0

SELECT productno, prodcateno, prod_title, files, thumbs, sizes
FROM product
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          FILE1    THUMB1       SIZE1
 ------ ---------- -------------- -------- ------------ -----
      3          2 À©µµ¿ì 10         cafe.jpg spring_t.jpg  1000
      2          1 LG·ÎÁöÅØ HDD(1TB) cafe.jpg spring_t.jpg  1000

-- 'LG·ÎÁöÅØ HDD(1TB)'¸¸ Ãâ·Â
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE productno = 2
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG·ÎÁöÅØ HDD(1TB)     1 Y         0 2019-05-14 50000 ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú 123          0 cafe.jpg spring_t.jpg  1000 http://    0

-- '±¹³» ¿©Çà'¸¸ Ãâ·Â, prod_content ÄÃ·³ÀÇ Ãâ·Â
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, SUBSTR(prod_content, 1, 150) as prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE productno = 2
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG·ÎÁöÅØ HDD(1TB)     1 Y         0 2019-05-14 50000 ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú 123          0 cafe.jpg spring_t.jpg  1000 http://    0

4. product Á¶È¸

1) Á¶È¸¼ö Áõ°¡ 
UPDATE product
SET prod_cnt = prod_cnt + 1
WHERE productno=1;

2) 1°ÇÀÇ ±Û º¸±â(R:Read, PK »ç¿ë) 
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
      2          1 LG·ÎÁöÅØ HDD(1TB)     1 Y         0 2019-05-14 50000 ÁÁÀº°¡°Ý ÁÁÀºÇ°Áú 123          0 cafe.jpg spring_t.jpg  1000 http://    0

5. ÆÐ½º¿öµå °Ë»ç
   - COUNT(): ¹ß»ýÇÑ ·¹ÄÚµåÀÇ ¼ö¸¦ °è»ê, ·¹ÄÚµå°¡ ¾øÀ¸¸é 0 Ãâ·Â
   
SELECT COUNT(*) as prod_cnt 
FROM product
WHERE productno=2 AND passwd='123';

 CNT
 ---
   1

   
6. ±Û ¼öÁ¤(U:Update), PK´Â ·¹ÄÚµå¸¦ ±¸ºÐÇÏ´Â °íÀ¯ ±â´ÉÀ» °¡Áö°í ÀÖÀ½À¸·Î 
   ¼öÁ¤ÇÏ´Â °ÍÀº ±ÇÀåÇÏÁö ¾ÊÀ½. 
    
1) ±Û¸¸ ¼öÁ¤ 
UPDATE product
SET prod_content='³»¿ë º¯°æ'
WHERE productno=2;

UPDATE product
SET prod_cnt=0;


UPDATE product
SET prod_title='³»¿ë º¯°æ', prod_content='³»¿ë º¯°æ',
      thumbs='aaa', files='aaaa', sizes='aaaaa', prod_word='aaaaaa',
      ip='http'
WHERE productno=2;

  
2) Visible ¼öÁ¤
UPDATE product
SET prod_visible = 'Y'
WHERE productno=1;

UPDATE product
SET prod_good = prod_good + 1
WHERE productno=1;

UPDATE product
SET prod_viewcnt = prod_viewcnt + 1
WHERE productno=1;

3) ÆÄÀÏ »èÁ¦, Æú´õ¿¡¼­ ½ÇÁ¦ ÆÄÀÏ »èÁ¦ ÁøÇà, DBMS´Â ÆÄÀÏ¸í¸¸ »èÁ¦
UPDATE product
SET files='', thumbs='', sizes=0
WHERE productno=1;

4) »õ·Î¿î ÆÄÀÏ µî·Ï
UPDATE product
SET files='test.jpg', thumbs='test_m.jpg', sizes=123
WHERE productno=1;

5) ÆÄÀÏ ±³Ã¼
UPDATE product
SET files='new.jpg', thumbs='new_m.jpg', sizes=123
WHERE productno=1;
 
7. ±Û »èÁ¦(D:Delete) 

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


8. °Ë»ö ±Û ¸ñ·Ï(S:Search List) 
    - ¸ñ·ÏÀº Á¦ÀÛ½Ã °Ë»öÀ» ±â¹ÝÀ¸·Î Á¦ÀÛÇÏ¸ç ÀüÃ¼ ³»¿ëÀº
      ÀüÃ¼ °Ë»ö°úµµ °°½À´Ï´Ù.
    - rname, prod_title, prod_content ÄÃ·³ ´ë»ó

1) ¼±¾ð: 
    - WHERE prod_title LIKE '»ï¼º'
       prod_title ÄÃ·³ÀÇ °ªÀÌ '»ï¼º'ÀÎ ·¹ÄÚµå ÀüºÎ Ãâ·Â

    - WHERE prod_title LIKE '%»ï¼º%'
      prod_title ÄÃ·³ÀÇ °ªÁß '»ï¼º'°¡ µé¾î°£ ·¹ÄÚµå ÀüºÎ Ãâ·Â

    - WHERE prod_title LIKE '»ï¼º%'
      prod_title ÄÃ·³ÀÇ °ªÁß '»ï¼º'·Î ½ÃÀÛÇÏ´Â ·¹ÄÚµå ÀüºÎ Ãâ·Â

    - WHERE prod_title LIKE '%»ï¼º'
      prod_title ÄÃ·³ÀÇ °ªÁß '»ï¼º'·Î Á¾·áÇÏ´Â ·¹ÄÚµå ÀüºÎ Ãâ·Â
   

    SELECT productno,
        prodcateno, prod_title, prod_content, prod_cnt
    FROM product
    WHERE prodcateno=10
    ORDER BY prod_grpno DESC, prod_ansnum ASC
      
      
2) °Ë»öÀ» ÇÏÁö ¾Ê´Â °æ¿ì ¸ðµç ·¹ÄÚµå Ãâ·Â 
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;

4) Á¦¸ñÀ¸·Î °Ë»ö  
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_title LIKE '%»ï¼º%'
ORDER BY productno DESC;

5) ³»¿ëÀ¸·Î °Ë»ö
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_content LIKE '%PC%'
ORDER BY productno DESC;

6) Á¦¸ñ, ³»¿ëÀ¸·Î °Ë»ö
SELECT productno, prodcateno, prod_title, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_title LIKE '%»ï¼º%' OR prod_content LIKE '%PC%'
ORDER BY productno DESC;
 
7) Ä«Å×°í¸®º° °Ë»ö
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno=11 AND (prod_title LIKE '%»ï¼º%' OR prod_content LIKE '%PC%')
ORDER BY productno DESC;
 
Á¶ÀÎ

SELECT c.prodcateno, c.prodcate_title,
               t.productno, t.prodcateno, t.prod_title,
               t.prod_visible, t.prod_cnt, t.prod_rdate
     FROM prodcate c, product t
     WHERE (t.productno = 10) AND (c.prodcateno = 10)

 
9. ÆäÀÌÂ¡ 
-- ÆäÀÌÂ¡ÀÌ ¾ÈµÇ´Â SQL
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno = 1
ORDER BY productno DESC;

-- Step 1: Á¤·Ä
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno = 1
ORDER BY productno DESC;

-- Step 2: rownum ¹ß»ý
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
FROM (
          SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
          FROM product
          WHERE prodcateno = 1
          ORDER BY productno DESC
);         

------------------------------------------------------Áß¿ä------------------------------
-- ³·Àº °¡°Ý¼ø
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

    -- ³ôÀº °¡°Ý¼ø
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
    
    -- »óÇ°¸í ¼ø °¡->ÆR
    SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product
                          WHERE prodcateno=10 AND prod_word LIKE '%ºÏÇØ%'  
                      ORDER BY prod_title ASC
             )
    )
    WHERE r >=1 AND r <= 3
    
    --ÀÎ±â¼ø
    SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product
                          WHERE prodcateno=10 AND prod_word LIKE '%ºÏÇØ%'  
                      ORDER BY prod_cnt ASC
             )
    )
    WHERE r >=1 AND r <= 3
    <!-- WHERE r >=1 AND r <= 3 -->
------------------------------------------------------Áß¿ä------------------------------
-- Step 3: 1 ÆäÀÌÁö
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


-- Step 3: 2 ÆäÀÌÁö
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


-- Step 3: 3 ÆäÀÌÁö
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


       
10. °Ë»öµÈ ·¹ÄÚµå °¹¼ö
SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND prod_title LIKE '%»ï¼º%'
ORDER BY productno DESC;

SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND prod_content LIKE '%PC%'
ORDER BY productno DESC;

SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND (prod_title LIKE '%»ï¼º%' OR prod_content LIKE '%PC%')
ORDER BY productno DESC;
 
 
11. ÆîÃÄº¸±â
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


13. Ä«Å×°í¸®ÀÇ »èÁ¦
-- 1¹ø Ä«Å×°í¸®ÀÇ µî·Ï ±Û¼ö Ä«¿îÆ®
SELECT COUNT(productno) as prod_cnt
FROM product
WHERE prodcateno=1;
 
-- »èÁ¦, Ã·ºÎ ÆÄÀÏ, Thumb ÆÄÀÏ, MP3, MP4¸¦ »èÁ¦ÇØ¾ßÇÔÀ¸·Î 1°Ç¾¿ »èÁ¦
DELETE FROM product
WHERE productno = 1;

14. Æò±Õ º°Á¡
SELECT a.productno, a.prodcateno, a.prod_title, AVG(b.score)
FROM product a, review b

SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;
-----------------------------------------------------------------------------------