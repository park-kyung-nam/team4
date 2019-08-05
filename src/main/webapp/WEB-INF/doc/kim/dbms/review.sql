/**********************************/
/* Table Name: �ı� */
/**********************************/
DROP TABLE review;

CREATE TABLE review(
    reviewno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    r_title                             VARCHAR2(200)     NOT NULL,
    r_content                           VARCHAR2(1000)     NOT NULL,
    r_file1                              VARCHAR2(200)    NULL ,
    r_size1                              NUMBER(10)     DEFAULT 0     NULL ,
    r_thumb1                            VARCHAR2(200)    NULL ,
    r_cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    replycnt                           NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                             DATE     NOT NULL,
    rname                              VARCHAR2(20)       NOT NULL,
    grpno                             NUMBER(7)              NOT NULL,
    indent                             NUMBER(2)       DEFAULT 0     NOT NULL,
    ansnum                           NUMBER(5)       DEFAULT 0     NOT NULL,
    word                                VARCHAR2(200)   NULL,
    score                             NUMBER(5)     DEFAULT 0     NOT NULL,
    productno                            NUMBER(10)     NULL ,
    customerno                      NUMBER(10)     NULL ,
  FOREIGN KEY (productno) REFERENCES product (productno),
  FOREIGN KEY (customerno) REFERENCES customer (customerno)
);

COMMENT ON TABLE review is '�ı�';
COMMENT ON COLUMN review.reviewno is '�� ��ȣ';
COMMENT ON COLUMN review.r_title is '����';
COMMENT ON COLUMN review.r_content is '����';
COMMENT ON COLUMN review.r_file1 is '����';
COMMENT ON COLUMN review.r_size1 is '���� ũ��';
COMMENT ON COLUMN review.r_thumb1 is '���� �̹���';
COMMENT ON COLUMN review.r_cnt is '��ȸ��';
COMMENT ON COLUMN review.replycnt is '�亯 ��';
COMMENT ON COLUMN review.rdate is '��¥';
COMMENT ON COLUMN review.rname is '�۾���';
COMMENT ON COLUMN review.grpno is '�׷� ��ȣ'
COMMENT ON COLUMN review.indent is '�亯 ����';
COMMENT ON COLUMN review.ansnum is '�亯 ����';
COMMENT ON COLUMN review.word is '�˻���';
COMMENT ON COLUMN review.score is '����';
COMMENT ON COLUMN review.prodno is '��ǰ ��ȣ';
COMMENT ON COLUMN review.customerno is 'ȸ�� ��ȣ';


--SEQUENCE ��ü ����
DROP SEQUENCE review_seq

CREATE SEQUENCE review_seq
START WITH 1                 -- ���� ��ȣ
INCREMENT BY 1             -- ������
MAXVALUE   99999999     -- �ִ밪, NUMBER(7) ����
CACHE         2                  -- ������ ����� ���� update �Ǵ� ��
NOCYCLE;

--���
INSERT INTO review(reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, grpno, indent, ansnum, word, score, prodno, customerno)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review), '�����ı�', '�����ı�', 
            'review.jpg', 1000, 'review_t.jpg', 0, 0, sysdate,
            '��', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review), 0, 0, '����', 0, 1, 1);
            
INSERT INTO review(reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, indent, ansnum, word, score, prodno, customerno)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review), '�����ı�2', '�����ı�2', 
            'review.jpg', 1000, 'review_t.jpg', 0, 0, sysdate, 
            '��', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review), 0, 0, '����', 0, 1, 1);

INSERT INTO review(reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, indent, ansnum, word, score, prodno, customerno)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review), '�����ı�3', '�����ı�3', 
            'review.jpg', 1000, 'review_t.jpg', 0, 0, sysdate, 
             '��', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review), 0, 0, '����', 0, 1, 1);
            
-- ���
SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
            rname, grpno, indent, ansnum, word, score, prodno, customerno
FROM review
ORDER BY reviewno ASC;

 REVIEWNO R_TITLE R_CONTENT R_FILE1    R_SIZE1 R_THUMB1     R_CNT REPLYCNT RDATE      RNAME PASSWD INDENT ANSNUM WORD SCORE PRODNO CUSTOMERNO
 -------- ------- --------- ---------- ------- ------------ ----- -------- ---------- ----- ------ ------ ------ ---- ----- ------ ----------
        8 �����ı�    �����ı�      review.jpg    1000 review_t.jpg     0        0 2019-07-26 ��     123         0      0 ����       0      1          1
        9 �����ı�2   �����ı�2     review.jpg    1000 review_t.jpg     0        0 2019-07-26 ��     123         0      0 ����       0      1          1
       10 �����ı�3   �����ı�3     review.jpg    1000 review_t.jpg     0        0 2019-07-26 ��     123         0      0 ����       0      1          1

      
--��ȸ
SELECT reviewno, r_title, r_file1, r_size1, r_thumb1, r_cnt, replycnt, rdate, 
           rname, grpno, indent, ansnum, word, score, prodno, customerno
FROM review
WHERE reviewno = 1;

REVIEWNO R_TITLE R_FILE1    R_SIZE1 R_THUMB1     R_CNT RDATE                 SCORE PRODNO
 -------- ------- ---------- ------- ------------ ----- --------------------- ----- ------
        1 �����ı�    review.jpg    1000 review_t.jpg     0 2019-05-23 18:13:23.0     0      1


        
-- ����
UPDATE review
SET r_title='ù ���� �ı�', r_content='ù ���� �ı�'
WHERE reviewno =1;

-- �Ѱ��� ���ڵ� ����
DELETE FROM review
WHERE reviewno=3;

-- ��� ���ڵ� ����
DELETE FROM review;

SELECT r_content
FROM review;

-- ��¼����� ����(���߿� �� ��)
UPDATE review
SET seqno = seqno + 1
WHERE reviewno= 1;
 
-- ��� ������ ����(���� ���)
UPDATE review
SET seqno = seqno - 1
WHERE reviewno= 1;

-- �ִ밪
SELECT MAX(seqno)+1 as seqno 
FROM review;
 
-- MAX �Լ��� ���ڵ尡 ������ null�� ��������� ��Ģ������ �Ұ�����.
SELECT MAX(seqno)+1 as seqno 
FROM review;
 
-- NVL �Լ��� ������� null ���ϰ�� 0���� ����Ǿ� 1�� ��µ�.
SELECT NVL(MAX(seqno), 0)+1 as seqno 
FROM event;
     
     -- ��ϵ� �� �� ����
UPDATE review
SET r_cnt = r_cnt + 1
WHERE reviewno=1;
 
-- ��ϵ� �� �� ����
UPDATE review
SET r_cnt = r_cnt - 1
WHERE reviewno=1;

-- ����¡

SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, rdate, word, score, prodno, customerno, r 
FROM(
          SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt,  rdate, word, score, prodno, customerno, rownum as r
          FROM(
                    SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, replycnt, r_cnt, rdate, word, score, prodno, customerno
                    FROM review
                    WHERE reviewno=1
                    ORDER BY reviewno DESC
           )
)
WHERE r >=1 AND r <=3;

-- �˻� + ����¡

SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, rdate, word, score, prodno, customerno, r 
FROM(
          SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, rdate, word, score, prodno, customerno, rownum as r
          FROM(
                    SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, replycnt, r_cnt, rdate, word, score, prodno, customerno
                    FROM review
                    WHERE reviewno=1 AND word LIKE '%��%'
                    ORDER BY reviewno DESC
           )
)
WHERE r >=1 AND r <=3;

-- �亯

SELECT * FROM review;

�� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;
 
 
�� �亯 ���
-- cateno: FK, mno: FK
 
INSERT INTO review(reviewno, prodno,
                             r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, grpno, word, indent, ansnum)  
VALUES((SELECT NVL(MAX(reviewno), 0) + 1 as reviewno FROM review), 
            1, '�����ı�', '�����ı�', 'review.jpg', 1000, 'review_t.jpg', 0, 0, 
             sysdate, '��s', 1, '', 1, 1);
 
 
�� �亯�� ���� ���� ���� ����    
SELECT reviewno, prodno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
           rdate, rname, grpno, indent, ansnum, r 
FROM(
         SELECT reviewno, prodno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                    rdate, rname, grpno, indent, ansnum, rownum as r
          FROM(
                  SELECT reviewno, prodno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, grpno, indent, ansnum
                    FROM review
                    WHERE reviewno=1 word LIKE '%����%'
                    ORDER BY reviewno DESC
         )
)
WHERE r >=1 AND r <= 3;

