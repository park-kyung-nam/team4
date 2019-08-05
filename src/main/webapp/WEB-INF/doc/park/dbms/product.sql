�� /webapp/WEB-INF/doc/dbms/product.sql
-----------------------------------------------------------------------------------
DROP TABLE product;
DROP TABLE member;

CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (mno)                  -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);

CREATE TABLE admin (
  adminno       NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (adminno)                  -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);
 
COMMENT ON TABLE member is '����Ʈ ȸ��';
COMMENT ON COLUMN member.mno is '����Ʈ ȸ�� ��ȣ';


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

COMMENT ON TABLE product is '��ǰ';
COMMENT ON COLUMN product.productno is '��ǰ��ȣ';
COMMENT ON COLUMN product.prodcateno is '��ǰ ī�װ� ��ȣ';
COMMENT ON COLUMN product.prod_title is '��ǰ ����';
COMMENT ON COLUMN product.seqno is '��� ����';
COMMENT ON COLUMN product.prod_visible is '��� ���';
COMMENT ON COLUMN product.prod_cnt is '��ǰ����';
COMMENT ON COLUMN product.prod_rdate is '��ǰ ������';
COMMENT ON COLUMN product.prod_price is '����';
COMMENT ON COLUMN product.prod_content is '����';
COMMENT ON COLUMN product.passwd is '�н�����';
COMMENT ON COLUMN product.viewprod_cnt is '��ȸ��';
COMMENT ON COLUMN product.files is '���ϸ�';
COMMENT ON COLUMN product.thumbs is 'Preview �̹���';
COMMENT ON COLUMN product.sizes is '����ũ��';
COMMENT ON COLUMN product.ip is 'IP';

-----------------------------------����: �Ʒ� �κ� ������� ���ÿ�--------------------------------------------

DROP SEQUENCE product_seq;

CREATE SEQUENCE product_seq
START WITH   1            --���۹�ȣ
INCREMENT BY 1          --������
MAXVALUE   99999999  --�ִ밪, NUMBER(7) ����
CACHE        2               --������ ����� ���� update�Ǵ� ���� �����ϱ����� ĳ�ð�
NOCYCLE;  

2. �� �߰�(C: Create) 
SELECT prodcateno, prodcateprod_grpno, prod_title, seqno, prod_visible, prod_cnt, ids, prod_rdate
FROM prodcate
ORDER BY seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
          4             2 ������         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 ������         1 Y         0 admin 2019-05-14 11:39:15.0

INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 1, 'LG������ HDD(1TB)', 1, 'Y', sysdate,
            50000, '�������� ����ǰ��', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 2, '������ 10', 1, 'Y', sysdate,
            50000, '�������� ����ǰ��', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, prod_rdate,
                  prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip)
VALUES(product_seq.nextval, 3, '�Ｚ���� DDR4 4G', 1, 'Y', sysdate,
            50000, '�������� ����ǰ��', '123', 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');

-----------------------------------����: �� �κ� ������� ���ÿ�--------------------------------------------

            
--   �θ�Ű prodcateprod_grpno�� ���� ���
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
             1, 'LG������ HDD(1TB)', '�������� ����ǰ��', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
             
INSERT INTO product(productno, 
                                prodcateno, prod_title, prod_content, prod_good,
                                thumbs, files, sizes, prod_cnt, prod_rdate, 
                                prod_grpno, prod_indent,
                                prod_price, prod_visible, ip)
VALUES((SELECT NVL(MAX(productno), 0) + 1 as productno FROM product), 
             2, 'LG������ HDD(2TB)', '�������� ����ǰ��', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
             
INSERT INTO product(productno, 
                                prodcateno, prod_title, prod_content, prod_good,
                                thumbs, files, sizes, prod_cnt, prod_rdate, 
                                prod_grpno, prod_indent,
                                prod_price, prod_visible, ip)
VALUES((SELECT NVL(MAX(productno), 0) + 1 as productno FROM product), 
             3, 'LG������ HDD(3TB)', '�������� ����ǰ��', 10,
             'fall_m.jpg', 'fall.jpg', 0, 0, sysdate,
             (SELECT NVL(MAX(prod_grpno), 0) + 1 as prod_grpno FROM product), 0,
             0, 'Y', 'http://');
            
3. ��ü �� ���(S:Total Select List), �ֽű� ���� ��� 
   - ASC: ���� ����, DESC: ���� ���� 
   - substring(�÷���, ������ġ, ����), ������ġ 1���� ����: ���ڿ� �Ϻθ� ����
   - �Լ� ���� �÷����� �ſ� ��������� 
     'SUBSTR(prod_rdate, 1, 10)' ������ as Ű����� 'prod_rdate' ��ȯ�մϴ�.
     
-- ��� ī�װ�
SELECT productno, prodcateno, prod_title, prod_content, prod_good,
           thumbs, files, sizes, prod_cnt, prod_rdate, prod_grpno,
           prod_indent, prod_price, prod_visible, ip
FROM product
ORDER BY productno DESC;

SELECT* FROM product
 PRODUCTNO PRODCATENO PROD_TITLE     PROD_CONTENT PROD_GOOD THUMBS     FILES    SIZES PROD_CNT PROD_RDATE            PROD_GRPNO PROD_INDENT PROD_PRICE PROD_VISIBLE IP
 --------- ---------- -------------- ------------ --------- ---------- -------- ----- -------- --------------------- ---------- ----------- ---------- ------------ -------
         3          3 LG������ HDD(3TB) �������� ����ǰ��           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:31.0          3           0          0 Y            http://
         2          2 LG������ HDD(2TB) �������� ����ǰ��           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:26.0          2           0          0 Y            http://
         1          1 LG������ HDD(1TB) �������� ����ǰ��           10 fall_m.jpg fall.jpg 0            0 2019-06-12 18:10:16.0          1           0          0 Y            http://

-- ��� ��½� prod_content, passwd �÷��� �����Ͽ� ����
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- ------- -------- ------------ ----- ------- ----
      3          2 ������ 10             1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0

SELECT productno, prodcateno, prod_title, files, thumbs, sizes
FROM product
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          FILE1    THUMB1       SIZE1
 ------ ---------- -------------- -------- ------------ -----
      3          2 ������ 10         cafe.jpg spring_t.jpg  1000
      2          1 LG������ HDD(1TB) cafe.jpg spring_t.jpg  1000

-- 'LG������ HDD(1TB)'�� ���
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE productno = 2
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0

-- '���� ����'�� ���, prod_content �÷��� ���
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, SUBSTR(prod_content, 1, 150) as prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE productno = 2
ORDER BY productno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0

4. product ��ȸ

1) ��ȸ�� ���� 
UPDATE product
SET prod_cnt = prod_cnt + 1
WHERE productno=1;

2) 1���� �� ����(R:Read, PK ���) 
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
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0

5. �н����� �˻�
   - COUNT(): �߻��� ���ڵ��� ���� ���, ���ڵ尡 ������ 0 ���
   
SELECT COUNT(*) as prod_cnt 
FROM product
WHERE productno=2 AND passwd='123';

 CNT
 ---
   1

   
6. �� ����(U:Update), PK�� ���ڵ带 �����ϴ� ���� ����� ������ �������� 
   �����ϴ� ���� �������� ����. 
    
1) �۸� ���� 
UPDATE product
SET prod_content='���� ����'
WHERE productno=2;

UPDATE product
SET prod_cnt=0;


UPDATE product
SET prod_title='���� ����', prod_content='���� ����',
      thumbs='aaa', files='aaaa', sizes='aaaaa', prod_word='aaaaaa',
      ip='http'
WHERE productno=2;

  
2) Visible ����
UPDATE product
SET prod_visible = 'Y'
WHERE productno=1;

UPDATE product
SET prod_good = prod_good + 1
WHERE productno=1;

UPDATE product
SET prod_viewcnt = prod_viewcnt + 1
WHERE productno=1;

3) ���� ����, �������� ���� ���� ���� ����, DBMS�� ���ϸ� ����
UPDATE product
SET files='', thumbs='', sizes=0
WHERE productno=1;

4) ���ο� ���� ���
UPDATE product
SET files='test.jpg', thumbs='test_m.jpg', sizes=123
WHERE productno=1;

5) ���� ��ü
UPDATE product
SET files='new.jpg', thumbs='new_m.jpg', sizes=123
WHERE productno=1;
 
7. �� ����(D:Delete) 

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


8. �˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - rname, prod_title, prod_content �÷� ���

1) ����: 
    - WHERE prod_title LIKE '�Ｚ'
       prod_title �÷��� ���� '�Ｚ'�� ���ڵ� ���� ���

    - WHERE prod_title LIKE '%�Ｚ%'
      prod_title �÷��� ���� '�Ｚ'�� �� ���ڵ� ���� ���

    - WHERE prod_title LIKE '�Ｚ%'
      prod_title �÷��� ���� '�Ｚ'�� �����ϴ� ���ڵ� ���� ���

    - WHERE prod_title LIKE '%�Ｚ'
      prod_title �÷��� ���� '�Ｚ'�� �����ϴ� ���ڵ� ���� ���
   

    SELECT productno,
        prodcateno, prod_title, prod_content, prod_cnt
    FROM product
    WHERE prodcateno=10
    ORDER BY prod_grpno DESC, prod_ansnum ASC
      
      
2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;

4) �������� �˻�  
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_title LIKE '%�Ｚ%'
ORDER BY productno DESC;

5) �������� �˻�
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_content LIKE '%PC%'
ORDER BY productno DESC;

6) ����, �������� �˻�
SELECT productno, prodcateno, prod_title, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prod_title LIKE '%�Ｚ%' OR prod_content LIKE '%PC%'
ORDER BY productno DESC;
 
7) ī�װ��� �˻�
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno=11 AND (prod_title LIKE '%�Ｚ%' OR prod_content LIKE '%PC%')
ORDER BY productno DESC;
 
����

SELECT c.prodcateno, c.prodcate_title,
               t.productno, t.prodcateno, t.prod_title,
               t.prod_visible, t.prod_cnt, t.prod_rdate
     FROM prodcate c, product t
     WHERE (t.productno = 10) AND (c.prodcateno = 10)

 
9. ����¡ 
-- ����¡�� �ȵǴ� SQL
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno = 1
ORDER BY productno DESC;

-- Step 1: ����
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
WHERE prodcateno = 1
ORDER BY productno DESC;

-- Step 2: rownum �߻�
SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip, rownum as r
FROM (
          SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
                     prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
          FROM product
          WHERE prodcateno = 1
          ORDER BY productno DESC
);         

------------------------------------------------------�߿�------------------------------
-- ���� ���ݼ�
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

    -- ���� ���ݼ�
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
    
    -- ��ǰ�� �� ��->�R
    SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product
                          WHERE prodcateno=10 AND prod_word LIKE '%����%'  
                      ORDER BY prod_title ASC
             )
    )
    WHERE r >=1 AND r <= 3
    
    --�α��
    SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
              replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, r
    FROM(
             SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                       replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum, rownum as r
             FROM(
                      SELECT productno, prodcateno, prod_title, prod_price, prod_content, prod_good, thumbs, files, sizes, prod_cnt,
                                replyprod_cnt, prod_rdate, prod_word, prod_grpno, prod_indent, prod_ansnum
                      FROM product
                          WHERE prodcateno=10 AND prod_word LIKE '%����%'  
                      ORDER BY prod_cnt ASC
             )
    )
    WHERE r >=1 AND r <= 3
    <!-- WHERE r >=1 AND r <= 3 -->
------------------------------------------------------�߿�------------------------------
-- Step 3: 1 ������
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


-- Step 3: 2 ������
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


-- Step 3: 3 ������
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


       
10. �˻��� ���ڵ� ����
SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND prod_title LIKE '%�Ｚ%'
ORDER BY productno DESC;

SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND prod_content LIKE '%PC%'
ORDER BY productno DESC;

SELECT COUNT(*) as prod_cnt 
FROM product
WHERE prodcateno = 1 AND (prod_title LIKE '%�Ｚ%' OR prod_content LIKE '%PC%')
ORDER BY productno DESC;
 
 
11. ���ĺ���
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


13. ī�װ��� ����
-- 1�� ī�װ��� ��� �ۼ� ī��Ʈ
SELECT COUNT(productno) as prod_cnt
FROM product
WHERE prodcateno=1;
 
-- ����, ÷�� ����, Thumb ����, MP3, MP4�� �����ؾ������� 1�Ǿ� ����
DELETE FROM product
WHERE productno = 1;

14. ��� ����
SELECT a.productno, a.prodcateno, a.prod_title, AVG(b.score)
FROM product a, review b

SELECT productno, prodcateno, prod_title, seqno, prod_visible, prod_cnt, TO_CHAR(prod_rdate, 'yyyy-mm-dd') as prod_rdate,
           prod_price, prod_content,  viewprod_cnt, files, thumbs, sizes, ip
FROM product
ORDER BY productno DESC;
-----------------------------------------------------------------------------------