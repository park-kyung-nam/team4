2. SQL:  /webapp/WEB-INF/doc/dbms/prodcate_join_c.sql
-------------------------------------------------------------------------------------
1. 2�� �̻��� ���̺� ����: JOIN 
      - PK, FK �÷��� ������� �մϴ�.
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
      
1) FK ���̺� ������ ����
DELETE FROM prodcate;

2) PK ���̺� ������ ����
DELETE FROM prodcategrp;
    
3) PK ���̺� ������ �߰�

INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             'CPU', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '�׷���ī��', 1, 'Y',0 ,sysdate);
   
INSERT INTO prodcategrp(prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_cnt, prodgrp_rdate)   
VALUES((SELECT NVL(MAX(prodcategrpno), 0) + 1 as prodcategrpno FROM prodcategrp),
             '�ü��', 1, 'Y',0 ,sysdate);


SELECT * FROM prodcategrp ORDER BY prodcategrpno ASC;

 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODGRP_VISIBLE PRODGRP_CNT PRODGRP_RDATE
 ------------- ------------- ------------- --------------- ----------- ---------------------
             1 CPU                       1 Y                         0 2019-06-04 17:13:26.0
             2 �׷���ī��                     1 Y                         0 2019-06-04 17:13:27.0
             3 �ü��                      1 Y                         0 2019-06-04 17:13:28.0



4) FK ���̺� ������ �߰�

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                1, 'DDR4 4G', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '������', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
               3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);
   

DELETE FROM prodcate WHERE prodcateno=4; -- ���ڵ� ����

   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
                2, '������', 1, 'Y', 0, 'admin', sysdate);
   
   INSERT INTO prodcate(prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_cnt, prodcate_ids, prodcate_rdate)   
   VALUES((SELECT NVL(MAX(prodcateno), 0) + 1 as prodcateno FROM prodcate),
               3, 'HDD(1TB)', 1, 'Y', 0, 'admin', sysdate);
             
5) PK ���̺� ������ Ȯ��
SELECT prodcategrpno, prodgrp_title, prodgrp_seqno, prodgrp_visible, prodgrp_rdate 
FROM prodcategrp 
ORDER BY prodgrp_seqno ASC;

 PK
 PRODCATEGRPNO PRODGRP_TITLE PRODGRP_SEQNO PRODGRP_VISIBLE PRODGRP_RDATE
 ------------- ------------- ------------- --------------- ---------------------
             1 CPU                       1 Y               2019-06-04 17:13:26.0
             2 �׷���ī��                     1 Y               2019-06-04 17:13:27.0
             3 �ü��                      1 Y               2019-06-04 17:13:28.0

         
6) FK ���̺� ������ Ȯ��
SELECT prodcateno, prodcategrpno, prodcate_title, prodcate_seqno, prodcate_visible, prodcate_ids, prodcate_rdate, prodcate_cnt
FROM prodcate 
ORDER BY prodcateno ASC, prodcate_seqno ASC;

 PRODCATENO PRODCATEGRPNO PRODCATE_TITLE PRODCATE_SEQNO PRODCATE_VISIBLE PRODCATE_IDS PRODCATE_RDATE        PRODCATE_CNT
 ---------- ------------- -------------- -------------- ---------------- ------------ --------------------- ------------
          1             1 DDR4 4G                     1 Y                admin        2019-06-04 17:13:45.0            0
          2             2 ������                         1 Y                admin        2019-06-04 17:13:46.0            0
          3             3 HDD(1TB)                    1 Y                admin        2019-06-04 17:13:47.0            0


2. Cross join
- �����μ��� ��ġ�� �ſ� ������.
- �������� ����.
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
             1 CPU                    2             2 ������                         1 Y                admin                   0
             2 �׷���ī��                  1             1 DDR4 4G                     1 Y                admin                   0
             2 �׷���ī��                  3             3 HDD(1TB)                    1 Y                admin                   0
             2 �׷���ī��                  2             2 ������                         1 Y                admin                   0
             3 �ü��                   3             3 HDD(1TB)                    1 Y                admin                   0
             3 �ü��                   1             1 DDR4 4G                     1 Y                admin                   0
             3 �ü��                   2             2 ������                         1 Y                admin                   0


         
-- ���̺� ������ ���
-- categrp c: ���̺���� �ʹ� ��� categrp ���̺��� ������ 'c'�� ����.
SELECT c.prodcategrpno, c.prodgrp_title,
          t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno,
          t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt
FROM prodcategrp c, prodcate t  
ORDER BY c.prodcategrpno ASC, t.prodcate_seqno ASC;

 PRODCATEGRPNO PRODGRP_TITLE PRODCATENO PRODCATEGRPNO PRODCATE_TITLE PRODCATE_SEQNO PRODCATE_VISIBLE PRODCATE_IDS PRODCATE_CNT
 ------------- ------------- ---------- ------------- -------------- -------------- ---------------- ------------ ------------
             1 CPU                    1             1 DDR4 4G                     1 Y                admin                   0
             1 CPU                    3             3 HDD(1TB)                    1 Y                admin                   0
             1 CPU                    2             2 ������                         1 Y                admin                   0
             2 �׷���ī��                  1             1 DDR4 4G                     1 Y                admin                   0
             2 �׷���ī��                  3             3 HDD(1TB)                    1 Y                admin                   0
             2 �׷���ī��                  2             2 ������                         1 Y                admin                   0
             3 �ü��                   3             3 HDD(1TB)                    1 Y                admin                   0
             3 �ü��                   1             1 DDR4 4G                     1 Y                admin                   0
             3 �ü��                   2             2 ������                         1 Y                admin                   0


         
          
3. Equal(INNER) JOIN FK ���̺��� �������� �մϴ�.
- WHERE �׷�(�θ�) ���̺� PK = ������(�ڽ�) ���̺� FK
- WHERE c.categrpno = t.categrpno: 2���� ���̺��� categrpno �÷��� ����
  ���ڵ带 �о� �޸𸮻󿡼� �ϳ��� ���ڵ�� �����Ͽ� �޸� ���̺���
  �����մϴ�. (DBMS�� ���� �޸� ���)

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
         1 �ؿ� ����          1                    1           �Ϻ�         1 Y       admin   0
         1 �ؿ� ����          2                    1           ������       2 Y       admin   0
         1 �ؿ� ����          3                    1           ��Ʈ��       3 Y       admin   0
         2 ���� ����          4                    2           ������       1 Y       admin   0
         2 ���� ����          5                    2           ����        2 Y       admin   0

-- seqno �÷��� �ߺ�
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
             2 �׷���ī��                     1          2             2 ������                         1 Y                admin                   0
             3 �ü��                      1          3             3 HDD(1TB)                    1 Y                admin                   0


SELECT c.prodcategrpno, c.prodgrp_title,
               t.prodcateno, t.prodcategrpno, t.prodcate_title, t.prodcate_seqno,
               t.prodcate_visible, t.prodcate_ids, t.prodcate_cnt, t.prodcate_rdate
     FROM prodcategrp c, prodcate t
     WHERE (t.prodcateno = 1) AND (c.prodcategrpno = t.prodcategrpno) 
             

          
-- seqno �÷��� �ߺ�, cate_seqno ó�� �÷� ������ �����Ͽ� �ذ�
    SELECT c.categrpno, c.name, c.seqno,
              t.cateno, t.categrpno, t.title, t.seqno as cate_seqno, t.visible, t.ids, t.cnt
    FROM categrp c, cate t  
    WHERE c.categrpno = t.categrpno
    ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  SEQNO CATENO CATEGRPNO TITLE CATE_SEQNO VISIBLE IDS   CNT
 --------- ----- ----- ---------- --------- ----- -------------- ------- ----- ---
         1 �ؿ� ����     1          1         1 �Ϻ�                 1 Y       admin   0
         1 �ؿ� ����     1          2         1 ������              2 Y       admin   0
         1 �ؿ� ����     1          3         1 ��Ʈ��              3 Y       admin   0
         2 ���� ����     2          4         2 ������              1 Y       admin   0
         2 ���� ����     2          5         2 ����                 2 Y       admin   0

4. LEFT Outer JOIN
- �θ����̺��� �ְ� �ڽ� ���̺��� �����ϴ� ���ڵ尡 ���� ����� ���
- cate FK ���̺� '+' �������ϸ� ���ڵ� ������ ��� 
  NULL ������ �����Ͽ� ���

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '��Ÿ', 3, 'Y', sysdate);

SELECT * FROM categrp ORDER BY categrpno ASC;

 CATEGRPNO NAME  SEQNO VISIBLE RDATE
 --------- ----- ----- ------- ---------------------
         1 �ؿ� ����     1 Y       2019-05-17 09:55:52.0
         2 ���� ����     2 Y       2019-05-17 09:55:53.0
         3 ��Ÿ           3 Y       2019-05-17 10:57:16.0

-- FK ���̺� '+' ��ȣ�� �����ϸ� PK ���̺��� ��� ��µ� 
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, cate t  
WHERE c.categrpno = t.categrpno(+)
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ----
         1 �ؿ� ����          1         1 �Ϻ�        1 Y       admin    0
         1 �ؿ� ����          2         1 ������       2 Y       admin    0
         1 �ؿ� ����          3         1 ��Ʈ��       3 Y       admin    0
         2 ���� ����          4         2 ������       1 Y       admin    0
         2 ���� ����          5         2 ����        2 Y       admin    0
         3 ��Ÿ             NULL      NULL NULL   NULL NULL    NULL  NULL
         

-- ANSI Left Outer Join: ���� ���̺� ��� ���
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c LEFT OUTER JOIN cate t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ----
         1 �ؿ� ����          1         1 �Ϻ�        1 Y       admin    0
         1 �ؿ� ����          2         1 ������       2 Y       admin    0
         1 �ؿ� ����          3         1 ��Ʈ��       3 Y       admin    0
         2 ���� ����          4         2 ������       1 Y       admin    0
         2 ���� ����          5         2 ����        2 Y       admin    0
         3 ��Ÿ          NULL      NULL NULL   NULL NULL    NULL  NULL

-- ANSI Right Outer Join, 
-- ���Ἲ ���������� �ջ����� PK ���� FK�� ��� �Ұ��Ͽ� Equal(����)�� ���� �����
-- �����, �����μ��� ��ġ�� ����. 
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c RIGHT OUTER JOIN cate t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ---
         1 �ؿ� ����          1         1 �Ϻ�        1 Y       admin   0
         1 �ؿ� ����          2         1 ������       2 Y       admin   0
         1 �ؿ� ����          3         1 ��Ʈ��       3 Y       admin   0
         2 ���� ����          4         2 ������       1 Y       admin   0
         2 ���� ����          5         2 ����        2 Y       admin   0
          
-- from���� ���̺��� ��ġ�� ������.
SELECT c.categrpno, c.name,  
          t.cateno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM cate t RIGHT OUTER JOIN categrp c 
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME  CATENO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ----- ---------- --------- ----- ----- ------- ----- ----
         1 �ؿ� ����          1         1 �Ϻ�        1 Y       admin    0
         1 �ؿ� ����          2         1 ������       2 Y       admin    0
         1 �ؿ� ����          3         1 ��Ʈ��       3 Y       admin    0
         2 ���� ����          4         2 ������       1 Y       admin    0
         2 ���� ����          5         2 ����        2 Y       admin    0
         3 ��Ÿ             NULL      NULL NULL   NULL NULL    NULL  NULL
  
          
5. SELF JOIN
-- ù��° ���ڵ� ��Ͻ� ������ PK ���� FK ������ ����ؾ� ���� ��� ����. 
-- �ι�°���ʹ� FK������ ������ PK�� ����� ���� ������ �����μ��� �ǹ̴� ����.
           
DROP TABLE position;

CREATE TABLE position(
  positionno NUMBER(5) NOT NULL,
  name       VARCHAR(30) NOT NULL, 
  employee  VARCHAR(30) NOT NULL,
  officer     NUMBER(5) NOT NULL,
  PRIMARY KEY(positionno),
  FOREIGN KEY(officer) REFERENCES position(positionno)
);

COMMENT ON TABLE position is '��å';
COMMENT ON COLUMN position.positionno is '��å ��ȣ';
COMMENT ON COLUMN position.name is '��å �̸�';
COMMENT ON COLUMN position.employee is '�����';
COMMENT ON COLUMN position.officer is '��� ��å �����';

-- FK�� ������ PK�� �������ϴ� ���, ù��° ���ڵ常 ���������� ���� ��� ����
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '��ǥ�̻�', '�Ʒι�', 1);
            
SELECT positionno,name, employee, officer
FROM position
ORDER BY positionno ASC;

 POSITIONNO NAME     EMPLOYEE OFFICER
 ---------------- -------     ------------- ----------
          1        ��ǥ�̻�  �Ʒι�            1
          
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '�̻�', '�Ǿ', 10);
-- ORA-02291: integrity constraint (AI3.SYS_C007082) violated - parent key not found

-- �̻��� ����� ��ǥ�̻�           
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '�̻�', '�մ���', 1);

SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 ��ǥ�̻� �Ʒι�            1
          2 �̻�   �մ���            1

-- ���� ����� �̻�     
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '��', '���浿', 2);

SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 ��ǥ�̻� �Ʒι�            1
          2 �̻�   �մ���            1
          3 ��   ���浿            2

-- DELETE FROM position WHERE positionno = 5;   

-- ������ ����� ��            
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '����', '���浿', 3);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 ��ǥ�̻� �Ʒι�         1
          2 �̻�   �մ���            1
          3 ��   ���浿            2
          4 ����   ���浿            3

INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '����', '�ٱ浿', 4);

-- ������ ����� ����   
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 ��ǥ�̻� �Ʒι�         1
          2 �̻�   �մ���            1
          3 ��   ���浿            2
          4 ����   ���浿            3
          5 ����   �ٱ浿            4

-- ������ ����� ����
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '����', '��浿', 5);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 ��ǥ�̻� �Ʒι�         1
          2 �̻�   �մ���            1
          3 ��   ���浿            2
          4 ����   ���浿            3
          5 ����   �ٱ浿            4
          6 ����   ��浿            5

-- �븮�� ����� ����
INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '�븮', '���浿', 6);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 ��ǥ�̻� �Ʒι�         1
          2 �̻�   �մ���            1
          3 ��   ���浿            2
          4 ����   ���浿            3
          5 ����   �ٱ浿            4
          6 ����   ��浿            5
          7 �븮   ���浿            6

INSERT INTO position(positionno,
                              name, employee, officer)
VALUES((SELECT NVL(MAX(positionno), 0) + 1 as positionno FROM position),
            '�븮2', 'ȫ���', 6);
       
SELECT * FROM position ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER
 ---------- ---- -------- -------
          1 ��ǥ�̻� �Ʒι�         1
          2 �̻�   �մ���            1
          3 ��   ���浿            2
          4 ����   ���浿            3
          5 ����   �ٱ浿            4
          6 ����   ��浿            5
          7 �븮   ���浿            6
          8 �븮2  ȫ���            6
          
-- Self join
SELECT p.positionno, p.name, p.employee, p.officer,
          c.name, c.employee
FROM position p, position c
WHERE p.officer = c.positionno 
ORDER BY positionno ASC;

 POSITIONNO NAME EMPLOYEE OFFICER NAME EMPLOYEE
 ---------- ---- -------- ------- ---- --------
          1 ��ǥ�̻� �Ʒι�         1 ��ǥ�̻� �Ʒι�
          2 �̻�   �մ���            1 ��ǥ�̻� �Ʒι�
          3 ��   ���浿            2 �̻�   �մ���
          4 ����   ���浿            3 ��   ���浿
          5 ����   �ٱ浿            4 ����   ���浿
          6 ����   ��浿            5 ����   �ٱ浿
          7 �븮   ���浿            6 ����   ��浿
          8 �븮2  ȫ���            6 ����   ��浿

          
          
-- ����: FK ���� ���̺� ������ �ϳ��� ������ ���ڵ�(���� ���) �Է¼� FK ���� ���� �߰�             
ALTER TABLE cate ADD CONSTRAINT cate_pk PRIMARY KEY (cateno);
ALTER TABLE cate ADD CONSTRAINT cate_officer_fk FOREIGN KEY (categrpno) REFERENCES categrp (categrpno);


-------------------------------------------------------------------------------------
         




