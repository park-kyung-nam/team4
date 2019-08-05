/**********************************/
/* Table Name: �� */
/**********************************/
CREATE TABLE customer(
       customerno                       NUMBER(10)   NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE customer is '��';
COMMENT ON COLUMN customer.customerno is ' �� ��ȣ';

INSERT INTO customer(customerno)
VALUES(1);

SELECT customerno
FROM customer
WHERE customerno = 1;

/**********************************/
/* Table Name: �߰� */
/**********************************/
DROP TABLE used;

CREATE TABLE used(
    usedno                            NUMBER(10)     NOT NULL   PRIMARY KEY,
    u_title                              VARCHAR2(200)     NOT NULL,
    u_content                         CLOB    NOT NULL,
    u_file1                              VARCHAR2(200)    NULL ,
    u_size1                             NUMBER(10)     DEFAULT 0     NULL ,
    u_thumb1                          VARCHAR2(200)    NULL ,
    u_cnt                                NUMBER(10)     DEFAULT 0     NOT NULL,
    replycnt                             NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                                 DATE     NOT NULL,
    rname                                VARCHAR2(20)     NOT NULL,
    grpno                             NUMBER(7)              NOT NULL,
    indent                               NUMBER(2)       DEFAULT 0     NOT NULL,
    ansnum                              NUMBER(5)       DEFAULT 0     NOT NULL,
    word                                  VARCHAR2(200)   NULL,
    customerno                         NUMBER(10)     NULL, 
   FOREIGN KEY (customerno) REFERENCES customer(customerno)
);

COMMENT ON TABLE used is '�߰�';
COMMENT ON COLUMN used.usedno is '�߰� ��ȣ';
COMMENT ON COLUMN used.u_title is '�߰� �� ����';
COMMENT ON COLUMN used.u_content is '�߰� ����';
COMMENT ON COLUMN used.u_file1 is '�߰� ����';
COMMENT ON COLUMN used.u_size1 is '�߰� ���� ũ��';
COMMENT ON COLUMN used.u_thumb1 is '�߰� ���� �̹���';
COMMENT ON COLUMN used.u_cnt is '��ȸ��';
COMMENT ON COLUMN used.replycnt is '�亯 ��';
COMMENT ON COLUMN used.rdate is '��¥';
COMMENT ON COLUMN used.rname is '�߰� �۾���';
COMMENT ON COLUMN used.grpno is '�׷� ��ȣ';
COMMENT ON COLUMN used.indent is '�亯 ����';
COMMENT ON COLUMN used.ansnum is '�亯 ����';
COMMENT ON COLUMN used.word is '�˻���';
COMMENT ON COLUMN used.customerno is '�� ��ȣ';

-- ���
INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word, customerno)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '�߰����1', '�߰����1',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '��', 
             (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM used), 0, 0, '�߰����', 1);

INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word, customerno)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '�߰����2', '�߰����2',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '��',
             (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM used), 0, 0, '�߰����', 1);

INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word, customerno)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '�߰����3', '�߰����',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '��',
             (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM used), 0, 0, '�߰����', 1);

-- ���
SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           TO_CHAR(rdate, 'yyyy-mm-dd') as rdate, rname, grpno, indent, ansnum, word, customerno
FROM used
ORDER BY usedno ASC;

 USEDNO U_TITLE U_CONTENT U_FILE1  U_SIZE1 U_THUMB1   U_CNT REPLYCNT RDATE      RNAME INDENT ANSNUM WORD CUSTOMERNO
 ------ ------- --------- -------- ------- ---------- ----- -------- ---------- ----- ------ ------ ---- ----------
      1 �߰����    �߰����      used.jpg    1000 used_t.jpg     0        0 2019-07-30 ��          0      0 �߰����          1
      2 �߰����2   �߰����2     used.jpg    1000 used_t.jpg     0        0 2019-07-30 ��          0      0 �߰����          1
      3 �߰����3   �߰����      used.jpg    1000 used_t.jpg     0        0 2019-07-30 ��          0      0 �߰����          1

-- ��ȸ
SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           rdate, rname, grpno, indent, ansnum, word, customerno
FROM used
WHERE usedno = 1;

 USEDNO U_TITLE U_CONTENT U_FILE1  U_SIZE1 U_THUMB1   U_CNT REPLYCNT RDATE                 RNAME INDENT ANSNUM WORD CUSTOMERNO
 ------ ------- --------- -------- ------- ---------- ----- -------- --------------------- ----- ------ ------ ---- ----------
      1 �߰����    �߰����      used.jpg    1000 used_t.jpg     0        0 2019-07-30 15:08:21.0 ��          0      0 �߰����          1

-- ����
UPDATE used
SET u_title='�߰� PC �Ǹ�', u_content='�߰� PC �Ǹ�'
WHERE usedno = 1;

-- �� ���� ���ڵ� ����
DELETE FROM used
WHERE usedno = 3;

-- ��� ���ڵ� ����
DELETE FROM used;

-- ����¡

SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           rdate, rname, indent, ansnum, word, customerno, r
FROM(
         SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                     rdate, rname, indent, ansnum, word, customerno, rownum as r
         FROM(
                   SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                              rdate, rname, indent, ansnum, word, customerno
                   FROM used
                   WHERE usedno =1
                   ORDER BY usedno DESC
         )
)
WHERE r >=1 AND r <=3;

-- �˻� + ����¡

SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           rdate, rname, indent, ansnum, word, customerno, r
FROM(
         SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                     rdate, rname, indent, ansnum, word, customerno, rownum as r
         FROM(
                   SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                              rdate, rname, indent, ansnum, word, customerno
                   FROM used
                   WHERE usedno =1 AND word LIKE '%�߰�%'
                   ORDER BY usedno DESC
         )
)
WHERE r >=1 AND r <=3;

-- �亯

SELECT * FROM used;

�� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;

�� �亯 ���

INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '�߰����1', '�߰����1',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '��', 1, 0, 0, '�߰����');

�� �亯�� ���� ���� ���� ����    

SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           rdate, rname, grpno, indent, ansnum, word, customerno, r
FROM(
         SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                     rdate, rname, grpno, indent, ansnum, word, customerno, rownum as r
         FROM(
                   SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                              rdate, rname, grpno, indent, ansnum, word, customerno
                   FROM used
                   WHERE usedno =1 AND word LIKE '%�߰�%'
                   ORDER BY usedno DESC
         )
)
WHERE r >=1 AND r <=3;


