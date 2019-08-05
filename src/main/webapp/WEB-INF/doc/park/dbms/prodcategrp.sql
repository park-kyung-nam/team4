/**********************************/
/* Table Name: ��ǰ ī�װ� �׷� */
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

COMMENT ON TABLE prodcategrp is '��ǰ ī�װ� �׷�';
COMMENT ON COLUMN prodcategrp.prodcategrpno is '��ǰ �׷� ��ȣ';
COMMENT ON COLUMN prodcategrp.prodgrp_title  is '��ǰ �׷� ����';
COMMENT ON COLUMN prodcategrp.prodgrp_seqno is '��� ����';
COMMENT ON COLUMN prodcategrp.prodgrp_visible is '��� ���';
COMMENT ON COLUMN prodcategrp.prodgrp_cnt is '��ϵ� �ڷ��';
COMMENT ON COLUMN prodcategrp.prodgrp_rdate is '�׷� ������';

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
             
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '�ڰ泲', 1, 'Y',sysdate);
   
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
             3 �ü��                      1 Y                         0 2019-05-31 18:00:04.0
             2 �׷���ī��                     1 Y                         0 2019-05-31 18:00:01.0

-- Read: ��ȸ
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate
FROM prodcategrp
WHERE prodcategrpno = 1;

 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODGRP_VISIBLE PRODGRP_CNT PRODGRP_RDATE
 ------------- ------------- ------------- --------------- ----------- ---------------------
             1 CPU                       1 Y                         0 2019-05-31 17:59:58.0
    
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
