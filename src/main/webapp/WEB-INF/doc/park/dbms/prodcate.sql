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
SELECT * FROM prodcategrp ORDER BY prodcate_seqno ASC;
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

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES(prodcate_seq.nextval, 1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES(prodcate_seq.nextval, 2, '������', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES(prodcate_seq.nextval, 3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);

-----------------------------------����: �� �κ� ������� ���ÿ�--------------------------------------------

   
--   �θ�Ű prodcategrpno�� ���� ���
--   ORA-02291: integrity constraint (AI4.SYS_C007705) violated - parent key not found
--   (0 rows affected)
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '������', 1, 'Y', 0, 'admin', sysdate);
   
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
          4             2 ������         1 Y         0 admin 2019-05-14 11:39:24.0
          2             2 ������         1 Y         0 admin 2019-05-14 11:39:15.0

          
�� �׷캰�� �����Ͽ� ��� 

SELECT prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate
FROM prodcate 
ORDER BY prodcategrpno ASC, prodcate_seqno ASC;

 PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- -------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G      1 Y         0 admin 2019-05-27 17:15:03.0
          2             2 ������          1 Y         0 admin 2019-05-27 17:15:28.0
          3             3 HDD(1TB)     1 Y         0 admin 2019-05-27 17:15:29.0
          
-- ��� �׷���  join
    SELECT c.prodcategrpno, c.prodcate_title,
              t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno, t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt, t.prodcate_rdate
    FROM prodcategrp c, prodcate t  
    WHERE c.prodcategrpno = t.prodcategrpno 
    ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC
    
     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE    SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- -------- ----- ------- ----- --- ---------------------
             1 CPU               1             1 DDR4 4G      1 Y       admin   0 2019-05-27 17:15:03.0
             2 �׷���ī��             2             2 ������          1 Y       admin   0 2019-05-27 17:15:28.0
             3 �ü��              3             3 HDD(1TB)     1 Y       admin   0 2019-05-27 17:15:29.0

-- 1�� �׷츸 ���, �ؿܿ��� �׷츸 JOIN ���(���� ����)         
    SELECT c.prodcategrpno, c.prodcate_title,
              t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno, t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt, t.prodcate_rdate
    FROM prodcategrp c, prodcate t   
    WHERE (c.prodcategrpno = 1) AND (c.prodcategrpno = t.prodcategrpno) 
    ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC

     PRODCATEGRPNO TITLE PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE IDS   CNT RDATE
 ------------- ----- ---------- ------------- ------- ----- ------- ----- --- ---------------------
             1 CPU              1             1 DDR4 4G     1 Y       admin   0 2019-05-27 17:15:03.0

             
-- Read: ��ȸ
SELECT prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate
FROM prodcate
WHERE prodcateno = 1;

 PRODCATENO PRODCATEGRPNO TITLE   SEQNO VISIBLE CNT IDS   RDATE
 ---------- ------------- ------- ----- ------- --- ----- ---------------------
          1             1 DDR4 4G     1 Y         0 admin 2019-05-14 11:38:42.0
    
-- ����
UPDATE prodcate
SET prodcate_title='DDR4 8G', prodcate_seqno=1, prodcate_visible='Y', prodcate_cnt=0, prodcate_ids='manager'
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
SET prodcate_seqno = prodcate_seqno + 1
WHERE prodcateno=1;

-- ��� ������ ����(���� ���)
UPDATE prodcate
SET prodcate_seqno = prodcate_seqno - 1
WHERE prodcateno=1;

UPDATE prodcate
SET prodcate_cnt = 1
WHERE prodcateno=10;


-- ��� ����
UPDATE prodcate
SET prodcate_visible='Y' -- ���
WHERE prodcateno=1;

UPDATE prodcate
SET prodcate_visible='N' -- �����
WHERE prodcateno=1;

-- �ִ밪
SELECT MAX(prodcate_seqno)+1 as prodcate_seqno 
FROM prodcate;

 SEQNO
 -----
     2
     
-- MAX �Լ��� ���ڵ尡 ������ null�� ��������� ��Ģ������ �Ұ�����.
SELECT MAX(prodcate_seqno)+1 as prodcate_seqno 
FROM prodcate;

 prodcate_seqno
 -------
    null

-- NVL �Լ��� ������� null ���ϰ�� 0���� ����Ǿ� 1�� ��µ�.
SELECT NVL(MAX(prodcate_seqno), 0)+1 as prodcate_seqno 
FROM prodcate;

 prodcate_seqno
 -----
     1    

-- ��ϵ� �� �� ����
UPDATE prodcate
SET prodcate_cnt = prodcate_cnt + 1
WHERE prodcateno=1;

UPDATE prodcate
SET prodcategrpno = 2
WHERE prodcateno=11;

-- ��ϵ� �� �� ����
UPDATE prodcate
SET prodcate_cnt = prodcate_cnt - 1
WHERE prodcateno=1;

12) prodcategrp(��з�) ���� ���� ���� ����
SELECT COUNT(*) as count
FROM prodcate
WHERE prodcategrpno = 1;
 CNT
 -----
   1