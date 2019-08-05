
CREATE TABLE admin(
		adminno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE admin is '������';
COMMENT ON COLUMN admin.adminno is '������ ��ȣ';

SELECT adminno
FROM admin
WHERE adminno = 1;

/**********************************/
/* Table Name: �������� */
/**********************************/
DROP TABLE notice;

select * from notice

CREATE TABLE notice(
		noticeno                      	NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		n_title                         		VARCHAR2(100)		 NOT NULL,
		n_content                        CLOB	 NOT NULL,
		n_file1                          		VARCHAR2(200)		 NULL ,
		n_size1                          		NUMBER(10)		 DEFAULT 0		 NULL ,
		n_cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		rdate                         	DATE		 NOT NULL,
		word                                VARCHAR2(200)     NULL,
		adminno                       NUMBER(10)		 NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE notice is '��������';
COMMENT ON COLUMN notice.noticeno is '�� ��ȣ';
COMMENT ON COLUMN notice.n_title is '����';
COMMENT ON COLUMN notice.n_content is '����';
COMMENT ON COLUMN notice.n_file1 is '����';
COMMENT ON COLUMN notice.n_size1 is '���� ũ��';
COMMENT ON COLUMN notice.n_cnt is '��ȸ��';
COMMENT ON COLUMN notice.rdate is '��¥';
COMMENT ON COLUMN notice.word is '�˻���';
COMMENT ON COLUMN notice.adminno is '������ ��ȣ';

--SEQUENCE ��ü ����
DROP SEQUENCE notice_seq;

CREATE SEQUENCE notice_seq
START WITH 1                 -- ���� ��ȣ
INCREMENT BY 1             -- ������
MAXVALUE   99999999     -- �ִ밪, NUMBER(7) ����
CACHE         2                  -- ������ ����� ���� update �Ǵ� ��
NOCYCLE;

-- ���
INSERT INTO notice(noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno)
VALUES( (SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice),
             '[��������] ���ݿ����� ��û �ȳ�����', '���ݿ����� ��û �ȳ�����',             
            'notice.jpg', 1000, 0, sysdate, '��������', 1);

INSERT INTO notice(noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno)
VALUES( (SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice), 
            '[��������] �Ľ�Ŭ�� ����湮 "��� �� �湮����" �������� �Դϴ�.', '[��������] �Ľ�Ŭ�� ����湮 "��� �� �湮����" �������� �Դϴ�.',
            'notice.jpg', 1000, 0, sysdate, '��������', 1);

INSERT INTO notice(noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno)
VALUES( (SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice),
            '[��������] īī���� 1:1��� �÷���ģ�� ����!', 'īī���� 1:1��� �÷���ģ�� ����', 
            'notice.jpg', 1000, 0, sysdate, '��������', 1);
-- ���
SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
           word, adminno
FROM notice
ORDER BY noticeno ASC;
           
SELECT *
FROM notice

 NOTICENO N_TITLE                                N_CONTENT                              N_FILE1    N_SIZE1 N_CNT RDATE      ADMINNO
 -------- -------------------------------------- -------------------------------------- ---------- ------- ----- ---------- -------
        1 [��������] ���ݿ����� ��û �ȳ�����                   ���ݿ����� ��û �ȳ�����                          notice.jpg    1000     0 2019-05-23       1
        2 [��������] �Ľ�Ŭ�� ����湮 "��� �� �湮����" �������� �Դϴ�. [��������] �Ľ�Ŭ�� ����湮 "��� �� �湮����" �������� �Դϴ�. notice.jpg    1000     0 2019-05-23       1
        3 [��������] īī���� 1:1��� �÷���ģ�� ����!            īī���� 1:1��� �÷���ģ�� ����                    notice.jpg    1000     0 2019-05-23       1
--��ȸ
/*
 * n_content ���� �� ��ȸ
 */
SELECT noticeno, n_title, n_file1, n_size1, n_cnt, rdate, word, adminno 
FROM notice
WHERE noticeno = 1;

NOTICENO N_TITLE              N_FILE1    N_SIZE1 N_CNT RDATE                 ADMINNO
 -------- -------------------- ---------- ------- ----- --------------------- -------
        1 [��������] ���ݿ����� ��û �ȳ����� notice.jpg    1000     0 2019-05-23 18:08:40.0       1
   
-- ����
UPDATE notice
SET n_title='[��������] ȸ�� ���� �ȳ�', n_content='ȸ�� ���� �ȳ�'
WHERE noticeno =1;

-- �Ѱ��� ���ڵ� ����
DELETE FROM notice
WHERE noticeno=3;

-- ��� ���ڵ� ����
DELETE FROM notice;

-- �˻�
SELECT noticeno, n_title, n_file1, n_size1, n_cnt, rdate, adminno 
FROM notice 
WHERE word LIKE '%��������%'
ORDER BY noticeno DESC;

-- �˻� �� ��ü ���ڵ� ����
SELECT COUNT(*) as cnt
FROM notice
WHERE noticeno = 1;

SELECT COUNT(*) as cnt
FROM notice
WHERE word LIKE '%����%';

-- ��¼����� ����(���߿� �� ��)
UPDATE notice
SET seqno = seqno + 1
WHERE noticeno= 1;
 
-- ��� ������ ����(���� ���)
UPDATE notice
SET seqno = seqno - 1
WHERE noticeno= 1;

-- �ִ밪
SELECT MAX(seqno)+1 as seqno 
FROM notice;
 
-- MAX �Լ��� ���ڵ尡 ������ null�� ��������� ��Ģ������ �Ұ�����.
SELECT MAX(seqno)+1 as seqno 
FROM notice;
 
-- NVL �Լ��� ������� null ���ϰ�� 0���� ����Ǿ� 1�� ��µ�.
SELECT NVL(MAX(seqno), 0)+1 as seqno 
FROM notice;
     
     -- ��ϵ� �� �� ����
UPDATE notice
SET n_cnt = n_cnt + 1
WHERE noticeno=1;
 
-- ��ϵ� �� �� ����
UPDATE notice
SET n_cnt = n_cnt - 1
WHERE noticeno=1;

 -- ����¡
        
SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno, r
FROM(
         SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno, rownum as r
         FROM(
                  SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate,  word, adminno
                  FROM notice
                  WHERE noticeno=1
                  ORDER BY noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;

-- �˻� + ����¡
SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno, r
FROM(
         SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno, rownum as r
         FROM(
                  SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate,  word, adminno
                  FROM notice
                  WHERE noticeno=1 AND word LIKE '%��%'
                  ORDER BY noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;

/**********************************/
/* Table Name: ��ǰ */
/**********************************/
CREATE TABLE prodno(


		prodno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE prodno is '��ǰ';
COMMENT ON COLUMN prodno.prodno is '��ǰ ��ȣ';



