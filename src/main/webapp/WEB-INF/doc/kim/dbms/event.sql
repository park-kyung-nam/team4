/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE admin;

CREATE TABLE admin(
    adminno                           NUMBER(10)     NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE admin is '������';
COMMENT ON COLUMN admin.adminno is '������ ��ȣ';

SELECT adminno
FROM admin;

INSERT INTO admin(adminno)
VALUES(1);


/**********************************/
/* Table Name: ��ǰ */
/**********************************/
DROP TABLE prodno;

CREATE TABLE prodno(
    prodno                            NUMBER(10)     NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE prodno is '��ǰ';
COMMENT ON COLUMN prodno.prodno is '��ǰ ��ȣ';

--SEQUENCE ��ü ����
DROP SEQUENCE product_seq

CREATE SEQUENCE product_seq
START WITH 1                 -- ���� ��ȣ
INCREMENT BY 1             -- ������
MAXVALUE   99999999     -- �ִ밪, NUMBER(7) ����
CACHE         2                  -- ������ ����� ���� update �Ǵ� ��
NOCYCLE;

INSERT INTO prodno(prodno)
VALUES(product_seq.nextval);


/**********************************/
/* Table Name: �̺�Ʈ */
/**********************************/
DROP TABLE event;

CREATE TABLE event(
    eventno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    e_title                             VARCHAR2(200)     NOT NULL,
    e_content                           VARCHAR2(1000)     NOT NULL,
    e_file1                              VARCHAR2(200)    NULL ,
    e_size1                              NUMBER(10)     DEFAULT 0     NULL ,
    e_thumb1                             VARCHAR2(200)    NULL ,
    e_cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    replycnt                           NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                             DATE     NOT NULL,
    indent                             NUMBER(2)       DEFAULT 0     NOT NULL,
    ansnum                           NUMBER(5)       DEFAULT 0     NOT NULL,
    word                                VARCHAR2(200)   NULL,
    adminno                           NUMBER(10)     NULL ,
    productno                            NUMBER(10)     NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (productno) REFERENCES product (productno)
);

COMMENT ON TABLE event is '�̺�Ʈ';
COMMENT ON COLUMN event.eventno is '�� ��ȣ';
COMMENT ON COLUMN event.e_title is '����';
COMMENT ON COLUMN event.e_content is '����';
COMMENT ON COLUMN event.e_file1 is '����';
COMMENT ON COLUMN event.e_size1 is '���� ũ��';
COMMENT ON COLUMN event.e_thumb1 is '���� �̹���';
COMMENT ON COLUMN event.e_cnt is '��ȸ��';
COMMENT ON COLUMN event.replycnt is '�亯 ��';
COMMENT ON COLUMN event.rdate is '��¥';
COMMENT ON COLUMN event.indent is '�亯 ����';
COMMENT ON COLUMN event.ansnum is '�亯 ����';
COMMENT ON COLUMN event.word is '�˻���';
COMMENT ON COLUMN event.adminno is '������ ��ȣ';
COMMENT ON COLUMN event.prodno is '��ǰ ��ȣ';

--SEQUENCE ��ü ����
DROP SEQUENCE event_seq

CREATE SEQUENCE event_seq
START WITH 1                 -- ���� ��ȣ
INCREMENT BY 1             -- ������
MAXVALUE   99999999     -- �ִ밪, NUMBER(7) ����
CACHE         2                  -- ������ ����� ���� update �Ǵ� ��
NOCYCLE;

-- ���
INSERT INTO event(eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                            rdate, indent, ansnum, word, adminno, prodno)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event), '[����ǰ] �÷�Ǯ �׷���ī�� SSD 1:1 ���� �̺�Ʈ', 'COLORFUL iGAME ������ GTX 1660 �����ϰ� SSD ���� !', 
            'event.jpg', 1000, 'event_t.jpg', 0, 0, sysdate, 0, 0, '�̺�Ʈ', 1, 1);

INSERT INTO event(eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt,
                            rdate, indent, ansnum, word, adminno, prodno)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event), '[Ư��] ASRock Z390 ��ƿ������ ���� ���� �Ǹ� �̺�Ʈ !', 'ASRock Z390 ��ƿ������ ��ص���',
            'event.jpg', 1000, 'event_t.jpg', 0, 0, sysdate, 0, 0, '�̺�Ʈ', 1, 1);

INSERT INTO event(eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt,
                            rdate, indent, ansnum, word, adminno, prodno)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event), '[��� �̺�Ʈ] ShockWave SK-POP ����� ��� ��� �̺�Ʈ !', '��ǰ�� ���Ͽ� �����ο� �ǰ��� �޾��ּ���! (��ǰ�� ����, ����, �ٶ���� �� ��������� �����ּ���!!) ��÷�� ���Ͽ� 3�в� ��ǰ�� �帮�ڽ��ϴ�~!', 
            'event.jpg', 1000, 'event_t.jpg', 0, 0, sysdate, 0, 0, '�̺�Ʈ', 1, 1);
            
-- ���
SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
           indent, ansnum, word, adminno, prodno
FROM event
ORDER BY eventno ASC;

 EVENTNO E_TITLE                                    E_CONTENT                                                                           E_FILE1   E_SIZE1 E_THUMB1    E_CNT RDATE      ADMINNO PRODNO
 ------- ------------------------------------------ ----------------------------------------------------------------------------------- --------- ------- ----------- ----- ---------- ------- ------
       1 [����ǰ] �÷�Ǯ �׷���ī�� SSD 1:1 ���� �̺�Ʈ             COLORFUL iGAME ������ GTX 1660 �����ϰ� SSD ���� !                                           event.jpg    1000 event_t.jpg     0 2019-05-23       1      1
       2 [Ư��] ASRock Z390 ��ƿ������ ���� ���� �Ǹ� �̺�Ʈ !      ASRock Z390 ��ƿ������ ��ص���                                                              event.jpg    1000 event_t.jpg     0 2019-05-23       1      1
       3 [��� �̺�Ʈ] ShockWave SK-POP ����� ��� ��� �̺�Ʈ ! ��ǰ�� ���Ͽ� �����ο� �ǰ��� �޾��ּ���! (��ǰ�� ����, ����, �ٶ���� �� ��������� �����ּ���!!) ��÷�� ���Ͽ� 3�в� ��ǰ�� �帮�ڽ��ϴ�~! event.jpg    1000 event_t.jpg     0 2019-05-23       1      1


--��ȸ
/*
 * e_content ���� �� ��ȸ
 */
SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
           indent, ansnum, word, adminno, prodno
FROM event
WHERE eventno = 1;
      
EVENTNO E_TITLE                        E_FILE1   E_SIZE1 E_THUMB1    E_CNT RDATE                 ADMINNO PRODNO
 ------- ------------------------------ --------- ------- ----------- ----- --------------------- ------- ------
       1 [����ǰ] �÷�Ǯ �׷���ī�� SSD 1:1 ���� �̺�Ʈ event.jpg    1000 event_t.jpg     0 2019-05-23 18:11:04.0       1      1

-- ����
UPDATE event
SET e_title='[�̺�Ʈ] ������ �̺�Ʈ', e_content='������',
      e_file1='event_f.jpg', e_thumb1='event.jpg', e_size1 = 1500
WHERE eventno =1;

-- �Ѱ��� ���ڵ� ����
DELETE FROM event
WHERE eventno=1;

-- ��� ���ڵ� ����
DELETE FROM event;

-- ��¼����� ����(���߿� �� ��)
UPDATE event
SET seqno = seqno + 1
WHERE eventno= 1;
 
-- ��� ������ ����(���� ���)
UPDATE event
SET seqno = seqno - 1
WHERE eventno= 1;

-- �ִ밪
SELECT MAX(seqno)+1 as seqno 
FROM event;
 
-- MAX �Լ��� ���ڵ尡 ������ null�� ��������� ��Ģ������ �Ұ�����.
SELECT MAX(seqno)+1 as seqno 
FROM event;
 
-- NVL �Լ��� ������� null ���ϰ�� 0���� ����Ǿ� 1�� ��µ�.
SELECT NVL(MAX(seqno), 0)+1 as seqno 
FROM event;
     
     -- ��ϵ� �� �� ����
UPDATE event
SET e_cnt = e_cnt + 1
WHERE eventno=1;
 
-- ��ϵ� �� �� ����
UPDATE event
SET e_cnt = e_cnt - 1
WHERE eventno=1;

-- ����¡

SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno, r 
FROM(
          SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno, rownum as r
          FROM(
                    SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno
                    FROM event
                    WHERE eventno=1
                    ORDER BY eventno DESC
           )
)
WHERE r >=1 AND r <=3;

-- �˻� + ����¡

SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno, r 
FROM(
          SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno, rownum as r
          FROM(
                    SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno
                    FROM event
                    WHERE eventno=1 AND word LIKE '%��%'
                    ORDER BY eventno DESC
           )
)
WHERE r >=1 AND r <=3;

--�亯

SELECT * FROM event;

�� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 0;

-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 2;

UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 5;
 
�� �亯 ���

INSERT INTO event(eventno, adminno, prodno, 
                             e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                             rdate, word, indent, ansnum)  
VALUES((SELECT NVL(MAX(eventno), 0) + 1 as eventno FROM event), 
            1, 1, '�̺�Ʈ', '�̺�Ʈ', 'event.jpg', 1000, 'event_t.jpg', 0, 0, 
             sysdate, '', 1, 1);
 
�� �亯�� ���� ���� ���� ����    
SELECT eventno, prodno, adminno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
           rdate, indent, ansnum, r 
FROM(
         SELECT eventno, prodno, adminno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                    rdate, indent, ansnum, rownum as r
          FROM(
                  SELECT eventno, prodno, adminno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                             rdate, indent, ansnum
                    FROM event
                    WHERE eventno=1 word LIKE '%�̺�Ʈ%'
                    ORDER BY eventno DESC
         )
)
WHERE r >=1 AND r <= 3;
