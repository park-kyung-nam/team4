/**********************************/
/* Table Name: ��ǰ ī�װ� �׷� */
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

COMMENT ON TABLE prodcategrp is '��ǰ ī�װ� �׷�';
COMMENT ON COLUMN prodcategrp.prodcategrpno is '��ǰ �׷� ��ȣ';
COMMENT ON COLUMN prodcategrp.prodgrp_title  is '��ǰ �׷� ����';
COMMENT ON COLUMN prodcategrp.prodgrp_seqno is '��� ����';
COMMENT ON COLUMN prodcategrp.prodgrp_visible is '��� ���';
COMMENT ON COLUMN prodcategrp.prodgrp_cnt is '��ϵ� �ڷ��';
COMMENT ON COLUMN prodcategrp.prodgrp_rdate is '�׷� ������';

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

COMMENT ON TABLE prodcate is '��ǰ ī�װ�';
COMMENT ON COLUMN prodcate.prodcateno is '��ǰ ī�װ� ��ȣ';
COMMENT ON COLUMN prodcate.prodcategrpno is '��ǰ �׷� ��ȣ';
COMMENT ON COLUMN prodcate.prodcate_title is 'ī�װ� ����';
COMMENT ON COLUMN prodcate.prodcate_seqno is '��� ����';
COMMENT ON COLUMN prodcate.prodcate_visible is '��� ���';
COMMENT ON COLUMN prodcate.prodcate_cnt is '��ϵ� �ڷ��';
COMMENT ON COLUMN prodcate.prodcate_ids is '���� ����';
COMMENT ON COLUMN prodcate.prodcate_rdate is 'ī�װ� ������';

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
DROP SEQUENCE prodcategrp_seq;

CREATE SEQUENCE prodcategrp_seq
START WITH   1            --���۹�ȣ
INCREMENT BY 1          --������
MAXVALUE   99999999  --�ִ밪, NUMBER(7) ����
CACHE        2               --������ ����� ���� update�Ǵ� ���� �����ϱ����� ĳ�ð�
NOCYCLE;  

2) insert
- classification: 1-Blog, 2-Gallery, 3-Product
- prodgrp_visible: Y, N

   INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
   VALUES(prodcategrp_seq.nextval, 'CPU', 1, 'Y',0 ,sysdate);
   
   INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
   VALUES(prodcategrp_seq.nextval, '�׷���ī��', 1, 'Y',0 ,sysdate);
   
   INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
   VALUES(prodcategrp_seq.nextval, '�ü��', 1, 'Y',0 ,sysdate);
   
-----------------------------------����: �� �κ� ������� ���ÿ�--------------------------------------------

   
3) Sequence�� ������� �ʴ� �Ϸù�ȣ�� �ڵ� ����
   
SELECT prodcategrpno FROM prodcategrp;

 PRODCATEGRPNO
 -------------

SELECT MAX(prodcategrpno) FROM prodcategrp; -- ���ڵ尡 ������ null

 MAX(PRODCATEGRPNO)
 ------------------
               NULL
           
SELECT MAX(prodcategrpno) + 1 FROM prodcategrp;    -- ���ڵ尡 ������ �ǹ� ����, null       
           
 MAX(PRODCATEGRPNO)+1
 --------------------
                 NULL

-- null�� �÷��� ���� 0���� ������ ����, NVL(�÷���, 0): �÷����� null�̸� 0���� ����
SELECT NVL(MAX(prodcategrpno), 0) + 1 FROM prodcategrp;
                       
 NVL(MAX(PRODCATEGRPNO),0)+1 <-- �÷����� �ʹ� ŭ
 ---------------------------
                           1
                        
-- as: Ŀ�� ���� ����, SELECT�ÿ��� �÷��� ����                       
SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp;                       

 PRODCATEGRPNO
 -------------
             1
         
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             'CPU', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '�׷���ī��', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '�ü��', 1, 'Y',0 ,sysdate);
   
-- List
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate
FROM prodcategrp
ORDER BY prodgrp_seqno ASC;

 PRODCATEGRPNO TITLE SEQNO VISIBLE CNT RDATE
 ------------- ----- ----- ------- --- ---------------------
             1 CPU       1 Y         0 2019-05-14 11:16:21.0
             3 �ü��      1 Y         0 2019-05-14 11:16:23.0
             2 �׷���ī��     1 Y         0 2019-05-14 11:16:22.0

-- Read: ��ȸ
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate
FROM prodcategrp
WHERE prodcategrpno = 1;

 PRODCATEGRPNO TITLE SEQNO VISIBLE CNT RDATE
 ------------- ----- ----- ------- --- ---------------------
             1 CPU       1 Y         0 2019-05-14 11:16:21.0
        
-- ����
UPDATE prodcategrp
SET prodgrp_title='�׷���ī��', prodgrp_seqno=1, prodgrp_visible='Y', prodgrp_cnt=0
WHERE prodcategrpno=1;

-- �Ѱ��� ���ڵ� ����
DELETE FROM prodcategrp
WHERE prodcategrpno=3;

-- ��� ���ڵ� ����
DELETE FROM prodcategrp;

-- ��¼����� ����(���߿� ���)
UPDATE prodcategrp
SET prodgrp_seqno = prodgrp_seqno + 1
WHERE prodcategrpno=1;

-- ��� ������ ����(���� ���)
UPDATE prodcategrp
SET prodgrp_seqno = prodgrp_seqno - 1
WHERE prodcategrpno=1;

-- ��� ����
UPDATE prodcategrp
SET prodgrp_visible='Y' -- ���
WHERE prodcategrpno=1;

UPDATE prodcategrp
SET prodgrp_visible='N' -- �����
WHERE prodcategrpno=1;

-- �ִ밪
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcategrp;

 SEQNO
 -----
     2
     
-- MAX �Լ��� ���ڵ尡 ������ null�� ��������� ��Ģ������ �Ұ�����.
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcategrp;

 prodgrp_seqno
 -------
    null

-- NVL �Լ��� ������� null ���ϰ�� 0���� ����Ǿ� 1�� ��µ�.
SELECT NVL(MAX(prodgrp_seqno), 0)+1 as prodgrp_seqno 
FROM prodcategrp;

 prodgrp_seqno
 -----
     1    

-- ��ϵ� �� �� ����
UPDATE prodcategrp
SET prodgrp_cnt = prodgrp_cnt + 1
WHERE prodcategrpno=1;

-- ��ϵ� �� �� ����
UPDATE prodcategrp
SET prodgrp_cnt = prodgrp_cnt - 1
WHERE prodcategrpno=1;


8) �˻�

         
9) ����¡

-- FOREIGN KEY (prodcategrpno) REFERENCES prodcategrp (prodcategrpno):
-- prodcategrpno �÷��� ���� prodcategrp ���̺��� prodcategrpno �÷��� ��ϵ� ����
-- ����� �� �ֽ��ϴ�.  
-- PK ������ FK ���ڵ� �ڵ� ����(���� �ƴ�)
-- FOREIGN KEY (prodcategrpno) REFERENCES prodcategrp (prodcategrpno) ON DELETE CASCADE
/**********************************/
/* Table Name: ī�װ� */
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

COMMENT ON TABLE prodcate is '��ǰ ī�װ�';
COMMENT ON COLUMN prodcate.prodcateno is '��ǰ ī�װ� ��ȣ';
COMMENT ON COLUMN prodcate.prodcategrpno is '��ǰ �׷� ��ȣ';
COMMENT ON COLUMN prodcate.prodgrp_title is 'ī�װ� ����';
COMMENT ON COLUMN prodcate.prodgrp_seqno is '��� ����';
COMMENT ON COLUMN prodcate.prodgrp_visible is '��� ���';
COMMENT ON COLUMN prodcate.prodgrp_cnt is '��ϵ� �ڷ��';
COMMENT ON COLUMN prodcate.ids is '���� ����';
COMMENT ON COLUMN prodcate.prodgrp_rdate is 'ī�װ� ������';

2) ���̺� ����: �ڽ� -> �θ�
�� DROP TABLE prodcategrp; : ORA-02449: unique/primary keys in table referenced by foreign keys
�� �ڽ� ���̺� ����: DROP TABLE prodcate;
�� �θ� ���̺� ����: DROP TABLE prodcategrp;


3) ���̺� ����: �θ� -> �ڽ�
�� FK cate ������ ���� �߻�: ORA-00942: table or view does not exist
�� �θ� ���̺� ���� ����: prodcategrp
�� �ڽ� ���̺� ����: prodcate


4) �θ� ���̺��� ���� ����(���� ���� ����), ���� ���ǵ� �Բ� ������.
DROP TABLE prodcategrp CASCADE CONSTRAINTS;


5) ���ڵ� �߰�, ERROR, �θ� ���̺� PK �÷��� ���� ���� ���
SELECT * FROM prodcategrp ORDER BY prodgrp_seqno ASC;
 PRODCATEGRPNO   SORT     SEQNO
 ----------  ---------   ---------
 PK ���̺� ���ڵ� ����.

 -----------------------------------����: �Ʒ� �κ� ������� ���ÿ�--------------------------------------------
DROP SEQUENCE prodcate_seq;

CREATE SEQUENCE prodcate_seq
START WITH   1            --���۹�ȣ
INCREMENT BY 1          --������
MAXVALUE   99999999  --�ִ밪, NUMBER(7) ����
CACHE        2               --������ ����� ���� update�Ǵ� ���� �����ϱ����� ĳ�ð�
NOCYCLE;  

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES(prodcate_seq.nextval, 1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES(prodcate_seq.nextval, 2, '������', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES(prodcate_seq.nextval, 3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);

-----------------------------------����: �� �κ� ������� ���ÿ�--------------------------------------------

   
--   �θ�Ű prodcategrpno�� ���� ���
--   ORA-02291: integrity constraint (AI4.SYS_C007705) violated - parent key not found
--   (0 rows affected)
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '������', 1, 'Y', 0, 'admin', sysdate);
   
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
          4             2 ������         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 ������         1 Y         0 admin 2019-05-14 11:39:15.0

          
�� �׷캰�� �����Ͽ� ��� 

SELECT prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate
FROM prodcate 
ORDER BY prodcategrpno ASC, prodgrp_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- -------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G      1 Y         0 admin 2019-05-27 17:15:03.0
          2             2 ������          1 Y         0 admin 2019-05-27 17:15:28.0
          3             3 HDD(1TB)     1 Y         0 admin 2019-05-27 17:15:29.0
          
-- ��� �׷���  join
    SELECT c.prodcategrpno, c.prodgrp_title,
              t.prodcateno, t.prodcategrpno, t.prodgrp_title, t.prodgrp_seqno, t.prodgrp_visible, t.ids, t.prodgrp_cnt, t.prodgrp_rdate
    FROM prodcategrp c, prodcate t  
    WHERE c.prodcategrpno = t.prodcategrpno 
    ORDER BY c.prodcategrpno ASC, t.prodgrp_seqno ASC
    
     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- -------- ----- ------- ----- --- ---------------------
             1 CPU               1             1 DDR4 4G      1 Y       admin   0 2019-05-27 17:15:03.0
             2 �׷���ī��             2             2 ������          1 Y       admin   0 2019-05-27 17:15:28.0
             3 �ü��              3             3 HDD(1TB)     1 Y       admin   0 2019-05-27 17:15:29.0

-- 1�� �׷츸 ���, �ؿܿ��� �׷츸 JOIN ���(���� ����)         
    SELECT c.prodcategrpno, c.prodgrp_title,
              t.prodcateno, t.prodcategrpno, t.prodgrp_title, t.prodgrp_seqno, t.prodgrp_visible, t.ids, t.prodgrp_cnt, t.prodgrp_rdate
    FROM prodcategrp c, prodcate t   
    WHERE (c.prodcategrpno = 1) AND (c.prodcategrpno = t.prodcategrpno) 
    ORDER BY c.prodcategrpno ASC, t.prodgrp_seqno ASC

     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- ------- ----- ------- ----- --- ---------------------
             1 CPU              1             1 DDR4 4G     1 Y       admin   0 2019-05-27 17:15:03.0

             
-- Read: ��ȸ
SELECT prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate
FROM prodcate
WHERE prodcateno = 1;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
    
-- ����
UPDATE prodcate
SET prodgrp_title='DDR4 8G', prodgrp_seqno=1, prodgrp_visible='Y', prodgrp_cnt=0, ids='manager'
WHERE prodcateno=1;

-- �Ѱ��� ���ڵ� ����
DELETE FROM prodcate
WHERE prodcateno=1;

-- ��� ���ڵ� ����
DELETE FROM prodcate;

13) ����
- ���ڵ� ���� ����: �ڽ� cate -> �θ� categrp 

1) �ϳ��� ���ڵ� ����
DELETE FROM prodcate WHERE prodcateno = 4;

2) categrp(��з�) ���� ��ġ�ϴ� �ټ��� ���ڵ� ����(���� ���ڵ尡 ���� �� �� ����)
DELETE FROM prodcate WHERE prodcategrpno = 1;

-- ��¼����� ����(���߿� ���)
UPDATE prodcate
SET prodgrp_seqno = prodgrp_seqno + 1
WHERE prodcateno=1;

-- ��� ������ ����(���� ���)
UPDATE prodcate
SET prodgrp_seqno = prodgrp_seqno - 1
WHERE prodcateno=1;

-- ��� ����
UPDATE prodcate
SET prodgrp_visible='Y' -- ���
WHERE prodcateno=1;

UPDATE prodcate
SET prodgrp_visible='N' -- �����
WHERE prodcateno=1;

-- �ִ밪
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcate;

 SEQNO
 -----
     2
     
-- MAX �Լ��� ���ڵ尡 ������ null�� ��������� ��Ģ������ �Ұ�����.
SELECT MAX(prodgrp_seqno)+1 as prodgrp_seqno 
FROM prodcate;

 prodgrp_seqno
 -------
    null

-- NVL �Լ��� ������� null ���ϰ�� 0���� ����Ǿ� 1�� ��µ�.
SELECT NVL(MAX(prodgrp_seqno), 0)+1 as prodgrp_seqno 
FROM prodcate;

 prodgrp_seqno
 -----
     1    

-- ��ϵ� �� �� ����
UPDATE prodcate
SET prodgrp_cnt = prodgrp_cnt + 1
WHERE prodcateno=1;

-- ��ϵ� �� �� ����
UPDATE prodcate
SET prodgrp_cnt = prodgrp_cnt - 1
WHERE prodcateno=1;

12) prodcategrp(��з�) ���� ���� ���� ����
SELECT COUNT(*) as prodgrp_cnt
FROM prodcate
WHERE prodcategrpno = 1;
 CNT
 -----
   1
   
 �� /webapp/WEB-INF/doc/dbms/product.sql
-----------------------------------------------------------------------------------
DROP TABLE product;
DROP TABLE member;
 
CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (mno)                  -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);
 
COMMENT ON TABLE member is '����Ʈ ȸ��';
COMMENT ON COLUMN member.mno is '����Ʈ ȸ�� ��ȣ';


-----------------------------------����: �Ʒ� �κ� ������� ���ÿ�--------------------------------------------

DROP SEQUENCE product_seq;

CREATE SEQUENCE product_seq
START WITH   1            --���۹�ȣ
INCREMENT BY 1          --������
MAXVALUE   99999999  --�ִ밪, NUMBER(7) ����
CACHE        2               --������ ����� ���� update�Ǵ� ���� �����ϱ����� ĳ�ð�
NOCYCLE;  

2. �� �߰�(C: Create) 
SELECT prodcateno, prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, ids, prodgrp_rdate
FROM prodcate
ORDER BY prodgrp_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
          4             2 ������         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 ������         1 Y         0 admin 2019-05-14 11:39:15.0

INSERT INTO product(prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate,
                  price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip)
VALUES(product_seq.nextval, 1, 'LG������ HDD(1TB)', 1, 'Y', 0, sysdate,
            50000, '�������� ����ǰ��', '123', 0, 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate,
                  price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip)
VALUES(product_seq.nextval, 2, '������ 10', 1, 'Y', 0, sysdate,
            50000, '�������� ����ǰ��', '123', 0, 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');
            
INSERT INTO product(prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate,
                  price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip)
VALUES(product_seq.nextval, 3, '�Ｚ���� DDR4 4G', 1, 'Y', 0, sysdate,
            50000, '�������� ����ǰ��', '123', 0, 'cafe.jpg', 'spring_t.jpg', 1000, 'http://');

-----------------------------------����: �� �κ� ������� ���ÿ�--------------------------------------------

            
--   �θ�Ű prodcategrpno�� ���� ���
--   ORA-02291: integrity constraint (AI4.SYS_C007705) violated - parent key not found
--   (0 rows affected)
            
            
3. ��ü �� ���(S:Total Select List), �ֽű� ���� ��� 
   - ASC: ���� ����, DESC: ���� ���� 
   - substring(�÷���, ������ġ, ����), ������ġ 1���� ����: ���ڿ� �Ϻθ� ����
   - �Լ� ���� �÷����� �ſ� ��������� 
     'SUBSTR(prodgrp_rdate, 1, 10)' ������ as Ű����� 'prodgrp_rdate' ��ȯ�մϴ�.
     
-- ��� ī�װ�
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      3          2 ������ 10             1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0

-- ��� ��½� content, passwd �÷��� �����Ͽ� ����
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- ------- -------- ------------ ----- ------- ----
      3          2 ������ 10             1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000       0 cafe.jpg spring_t.jpg  1000 http://    0

SELECT prodno, prodcateno, prodgrp_title, file1, thumb1, size1
FROM product
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          FILE1    THUMB1       SIZE1
 ------ ---------- -------------- -------- ------------ -----
      3          2 ������ 10         cafe.jpg spring_t.jpg  1000
      2          1 LG������ HDD(1TB) cafe.jpg spring_t.jpg  1000

-- 'LG������ HDD(1TB)'�� ���
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodno = 2
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0

-- '���� ����'�� ���, content �÷��� ���
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, SUBSTR(content, 1, 150) as content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodno = 2
ORDER BY prodno DESC;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0

4. product ��ȸ

1) ��ȸ�� ���� 
UPDATE product
SET prodgrp_cnt = prodgrp_cnt + 1
WHERE prodno=1;

2) 1���� �� ����(R:Read, PK ���) 
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodno = 2;

 PRODNO PRODCATENO TITLE          SEQNO VISIBLE CNT RDATE      PRICE CONTENT   PASSWD VIEWCNT FILE1    THUMB1       SIZE1 IP      GOOD
 ------ ---------- -------------- ----- ------- --- ---------- ----- --------- ------ ------- -------- ------------ ----- ------- ----
      2          1 LG������ HDD(1TB)     1 Y         0 2019-05-14 50000 �������� ����ǰ�� 123          0 cafe.jpg spring_t.jpg  1000 http://    0

5. �н����� �˻�
   - COUNT(): �߻��� ���ڵ��� ���� ���, ���ڵ尡 ������ 0 ���
   
SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodno=2 AND passwd='123';

 CNT
 ---
   1

   
6. �� ����(U:Update), PK�� ���ڵ带 �����ϴ� ���� ����� ������ �������� 
   �����ϴ� ���� �������� ����. 
    
1) �۸� ���� 
UPDATE product
SET content='���� ����'
WHERE prodno=2;
  
2) Visible ����
UPDATE product
SET prodgrp_visible = 'Y'
WHERE prodno=1;

3) ���� ����, �������� ���� ���� ���� ����, DBMS�� ���ϸ� ����
UPDATE product
SET file1='', thumb1='', size1=0
WHERE prodno=1;

4) ���ο� ���� ���
UPDATE product
SET file1='test.jpg', thumb1='test_m.jpg', size1=123
WHERE prodno=1;

5) ���� ��ü
UPDATE product
SET file1='new.jpg', thumb1='new_m.jpg', size1=123
WHERE prodno=1;
 
7. �� ����(D:Delete) 
DELETE FROM product
WHERE prodno = 1;

DELETE FROM product
WHERE prodno <= 4;

DELETE FROM product
WHERE prodno >= 71;


8. �˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - rname, prodgrp_title, content �÷� ���

1) ����: 
    - WHERE prodgrp_title LIKE '�Ｚ'
       prodgrp_title �÷��� ���� '�Ｚ'�� ���ڵ� ���� ���

    - WHERE prodgrp_title LIKE '%�Ｚ%'
      prodgrp_title �÷��� ���� '�Ｚ'�� �� ���ڵ� ���� ���

    - WHERE prodgrp_title LIKE '�Ｚ%'
      prodgrp_title �÷��� ���� '�Ｚ'�� �����ϴ� ���ڵ� ���� ���

    - WHERE prodgrp_title LIKE '%�Ｚ'
      prodgrp_title �÷��� ���� '�Ｚ'�� �����ϴ� ���ڵ� ���� ���
   

2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;

4) �������� �˻�  
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodgrp_title LIKE '%�Ｚ%'
ORDER BY prodno DESC;

5) �������� �˻�
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE content LIKE '%PC%'
ORDER BY prodno DESC;

6) ����, �������� �˻�
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodgrp_title LIKE '%�Ｚ%' OR content LIKE '%PC%'
ORDER BY prodno DESC;
 
7) ī�װ��� �˻�
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodcateno=11 AND (prodgrp_title LIKE '%�Ｚ%' OR content LIKE '%PC%')
ORDER BY prodno DESC;
  
 
9. ����¡ 
-- ����¡�� �ȵǴ� SQL
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodcateno = 1
ORDER BY prodno DESC;

-- Step 1: ����
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
WHERE prodcateno = 1
ORDER BY prodno DESC;

-- Step 2: rownum �߻�
SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip, rownum as r
FROM (
          SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
                     price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
          FROM product
          WHERE prodcateno = 1
          ORDER BY prodno DESC
);         

-- Step 3: 1 ������
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


-- Step 3: 2 ������
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


-- Step 3: 3 ������
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


       
10. �˻��� ���ڵ� ����
SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodcateno = 1 AND prodgrp_title LIKE '%�Ｚ%'
ORDER BY prodno DESC;

SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodcateno = 1 AND content LIKE '%PC%'
ORDER BY prodno DESC;

SELECT COUNT(*) as prodgrp_cnt 
FROM product
WHERE prodcateno = 1 AND (prodgrp_title LIKE '%�Ｚ%' OR content LIKE '%PC%')
ORDER BY prodno DESC;
 
 
11. ���ĺ���
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


13. ī�װ��� ����
-- 1�� ī�װ��� ��� �ۼ� ī��Ʈ
SELECT COUNT(prodno) as prodgrp_cnt
FROM product
WHERE prodcateno=1;
 
-- ����, ÷�� ����, Thumb ����, MP3, MP4�� �����ؾ������� 1�Ǿ� ����
DELETE FROM product
WHERE prodno = 1;

14. ��� ����

SELECT a.prodno, a.prodcateno, a.prodgrp_title, AVG(b.score)
FROM product a, review b

SELECT prodno, prodcateno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, TO_CHAR(prodgrp_rdate, 'yyyy-mm-dd') as prodgrp_rdate,
           price, content, passwd, viewprodgrp_cnt, file1, thumb1, size1, ip
FROM product
ORDER BY prodno DESC;
-----------------------------------------------------------------------------------
