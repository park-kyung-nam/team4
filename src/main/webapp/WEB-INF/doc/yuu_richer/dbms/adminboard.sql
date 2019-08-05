/**********************************/
/* Table Name: ������ �Խ��� */
/**********************************/
CREATE TABLE adminboard(
    adminboardno                      NUMBER(10)     NOT NULL,
    title                             VARCHAR2(1000)     NOT NULL,
    content                           CLOB     NULL ,
    files                             VARCHAR2(3000)     NULL ,
    sizes                             VARCHAR2(2000)     NULL ,
    rdate                             DATE     DEFAULT sysdate     NOT NULL,
    ddate                             DATE     NULL ,
    word                              VARCHAR2(1000)     NULL ,
    cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    adminno                           NUMBER(10)     NOT NULL 
);

COMMENT ON TABLE adminboard is '������ �Խ���';
COMMENT ON COLUMN adminboard.adminboardno is '������ �Խ��� ��ȣ';
COMMENT ON COLUMN adminboard.title is '����';
COMMENT ON COLUMN adminboard.content is '����';
COMMENT ON COLUMN adminboard.files is '����';
COMMENT ON COLUMN adminboard.sizes is '���� ũ��';
COMMENT ON COLUMN adminboard.rdate is '�����';
COMMENT ON COLUMN adminboard.ddate is '������';
COMMENT ON COLUMN adminboard.word is '�±�';
COMMENT ON COLUMN adminboard.cnt is '��ȸ��';
COMMENT ON COLUMN adminboard.adminno is '������ ��ȣ';


ALTER TABLE adminboard ADD CONSTRAINT IDX_adminboard_PK PRIMARY KEY (adminboardno);
ALTER TABLE adminboard ADD CONSTRAINT IDX_adminboard_FK0 FOREIGN KEY (adminno) REFERENCES admin (adminno);



4) contents ���             
- ���ο� ��, �亯 �ۿ����� ��� SQL���̰� �ֽ��ϴ�.
- ���ο� �� ����� ���ο� �׷��� ��������� ����� �ֽ��ϴ�. MAX + 1
- cateno �÷� 1�� ����
- mno �÷� 1�� ����

INSERT INTO adminboard(adminboardno, adminno,
    title, content, files, sizes, 
    cnt, rdate, ddate, word)  
VALUES((SELECT NVL(MAX(adminboardno), 0) + 1 as adminboardno FROM adminboard), 0,
    '���� �������� ����','�αٵα�', null, null,
    0, sysdate, sysdate + 7, null
);

select adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word
from adminboard
order by adminboardno desc
            
5) ��ü ���(��� ����)

select adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word
from adminboard
order by adminboardno desc

SELECT adminboardno, files, sizes
FROM adminboard
order by adminboardno desc


select 
  b.adminboardno, b.adminno, b.title, b.content, b.files, b.sizes, b.cnt, b.rdate, b.ddate, b.word,
  a.adminno as a_adminno, a.name, a.id, a.img, a.profileimg, a.admincodeno, a.phone1, a.phone2, a.email
from adminboard b, admin a
where a.adminno = b.adminno
order by adminboardno desc

 
7) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM adminboard;
 
8) ��ȸ
select adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word
from adminboard
where adminboardno = 1
 
9) ����
update adminboard
set 
  adminno=adminno, 
  title=title, 
  content=content, 
  files=files, 
  sizes=sizes,
  ddate=ddate, 
  word=word
where adminboardno = 1
 
10) ����
DELETE FROM adminboard
WHERE adminboardno=1

update adminboard
set 
  adminno = -1
where adminno = 1

DELETE FROM adminboard
WHERE adminboardno=1
 
11) �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- word LIKE '������' �� word = '������'
   ^������$
-- word LIKE '%������' �� word = '���� ���� ������'
   .*������$
-- word LIKE '������%' �� word = '����������~'
   ^������.*
-- word LIKE '%������%' �� word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*
 
-- '������' �÷����� �˻�
SELECT contentsno,
          cateno, mno, title, good, thumbs, files, sizes, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM contents
WHERE cateno=6 AND word LIKE '%������%'
ORDER BY contentsno DESC;
 
-- '���ǽ�' �÷����� �˻�
SELECT contentsno,
          cateno, mno, title, good, thumbs, files, sizes, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM contents
WHERE cateno=6 AND word LIKE '%���ǽ�%'
ORDER BY contentsno DESC;
 
-- '���ǽ�' �÷����� �˻�
SELECT contentsno,
          cateno, mno, title, good, thumbs, files, sizes, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM contents
WHERE cateno=6 AND word LIKE '%���ǽ�%'
ORDER BY contentsno DESC;
 
-- 'swiss' �÷����� �˻�

select adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word
from adminboard
WHERE word LIKE '%swiss%'
order by adminboardno desc
 
 
12) �˻� �� ��ü ���ڵ� ����
-- '������' �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM adminboard
WHERE word LIKE '%������%';
 
13) ����¡
 
DROP TABLE PG;
 
CREATE TABLE PG(
  num NUMBER(5) NOT NULL,
  title  VARCHAR(20) NOT NULL,
  PRIMARY KEY(num)
);
 
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '01��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '04��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '05��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '06��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '07��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '08��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '09��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '10��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '11��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '12��');
 
SELECT num, title FROM pg;
 
 NUM TITLE
 --- -----
   1 01��
   2 02��
   3 03��
   4 04��
   5 05��
   6 06��
   7 07��
   8 08��
   9 09��
  10 10��
  11 11��
  12 12��
 
-- �б⺰�� �����Ͽ� ���ڵ带 �����ϴ� ���(����¡)
SELECT num, title FROM pg;
 
-- rownum: oralce system���� select�ÿ� �ڵ����� �ٿ��ִ� �Ϸù�ȣ
SELECT num, title, rownum FROM pg;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   2 02��        2
   3 03��        3
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
 
-- 2,3�� ����
DELETE FROM pg WHERE num=2 or num=3;
 
SELECT num, title, rownum FROM pg;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   4 04��        2
   5 05��        3
   6 06��        4
   7 07��        5
   8 08��        6
   9 09��        7
  10 10��        8
  11 11��        9
  12 12��       10
 
 
-- ����¡�ô� ������ �������� �����Ǵ� rownum ���� ����մϴ�.
-- rownum����: rownum�� ����(ORDER BY ~)���� ���� ����������
   ������ �� �� rownum �÷��� ����մϴ�.
 
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '����');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '����');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '�ܿ�');
 
-- Paging Step 1
-- SELECT �� ROWNUM �� ORDER BY ~
SELECT num, title, rownum 
FROM pg
ORDER BY title ASC;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
  15 ����         2
  16 �ܿ�         3
  13 ��         13
  14 ����        14
  
  
-- Paging Step 2, subquery
SELECT num, title, rownum
FROM (
           SELECT num, title 
           FROM pg
           ORDER BY num ASC
);
 
  NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   4 04��        2
   5 05��        3
   6 06��        4
   7 07��        5
   8 08��        6
   9 09��        7
  10 10��        8
  11 11��        9
  12 12��       10
  13 ��         11
  14 ����        12
  15 ����        13
  16 �ܿ�        14
  
-- 2,3 ���� �߰��ϼ���.
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03��');
 
-- ��� �ٽ� ���, �� rownum�� �����ǰ� ���� ����� �۵���
SELECT num, title, rownum
FROM pg
ORDER BY title ASC;
  
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  17 02��       15
  18 03��       16
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
  15 ����         2
  16 �ܿ�         3
  13 ��          13
  14 ����        14
  
-- Subquery���� ������ rownum�� ���
SELECT num, title, rownum
FROM (
           SELECT num, title
           FROM pg
           ORDER BY title ASC
);
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  17 02��        2
  18 03��        3
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
  15 ����        13
  16 �ܿ�        14
  13 ��          15
  14 ����        16
 
-- Paging Step 3, subquery
-- 1 �б�
SELECT num, title, r
FROM(
         SELECT num, title, rownum as r
         FROM (
                   SELECT num, title 
                   FROM pg
                   ORDER BY title ASC
         )  
)
WHERE r>=1 AND r <=3;
 
 NUM TITLE R
 --- ----- -
   1 01��   1
  17 02��   2
  18 03��   3
   
-- 2 �б�
SELECT num, title, r
FROM(
         SELECT num, title, rownum as r
         FROM (
                   SELECT num, title 
                   FROM pg
                   ORDER BY title ASC
         )  
)
WHERE r>=4 AND r <=6;
   
 NUM TITLE R
 --- ----- -
   4 04��   4
   5 05��   5
   6 06��   6
 
 
   
* rownum�� ���� 1�������� ���� ó���ǰ� 2���̺��ʹ� WHERE������ 
  �ν��̾ȵ˴ϴ�. ���� 3�� ������ ����ؾ��մϴ�.   
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=1 AND rownum <=3;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  17 02��        2
  18 03��        3
 
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=4 AND rownum <=6;
 
 NUM TITLE ROWNUM
 --- ----- ------
 
 
14) ����¡ ����
-- step 1
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes,
          cnt, replycnt, rdate, word
FROM contents
WHERE cateno=1
ORDER BY contentsno DESC;


select 
  b.adminboardno, b.adminno, b.title, b.content, b.files, b.sizes, b.cnt, b.rdate, b.ddate, b.word,
  a.adminno as a_adminno, a.name, a.id, a.img, a.profileimg, a.admincodeno, a.phone1, a.phone2, a.email
from adminboard b, admin a
where a.adminno = b.adminno
order by adminboardno desc
 
-- step 2         
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes,
          cnt, replycnt, rdate, word, rownum as r
FROM(
         SELECT contentsno, cateno, title, content, good, thumbs, files, sizes,
                   cnt, replycnt, rdate, word
         FROM contents
         WHERE cateno=1
         ORDER BY contentsno DESC
);

select
  rownum as r,
  adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word,
  a_adminno, name, id, img, profileimg, admincodeno, phone1, phone2, email
from(
  select 
    b.adminboardno, b.adminno, b.title, b.content, b.files, b.sizes, b.cnt, b.rdate, b.ddate, b.word,
    a.adminno as a_adminno, a.name, a.id, a.img, a.profileimg, a.admincodeno, a.phone1, a.phone2, a.email
  from adminboard b, admin a
  where a.adminno = b.adminno
  order by adminboardno desc
)
 
-- step 3         
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, r
FROM(
         SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, rownum as r
         FROM(
                  SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word
                  FROM contents
                  WHERE cateno=1
                  ORDER BY contentsno DESC
         )
)
WHERE r >=1 AND r <= 3;

select
  rownum as r,
  adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word,
  a_adminno, name, id, img, profileimg, admincodeno, phone1, phone2, email
from(
  select
    rownum as r,
    adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word,
    a_adminno, name, id, img, profileimg, admincodeno, phone1, phone2, email
  from(
    select 
      b.adminboardno, b.adminno, b.title, b.content, b.files, b.sizes, b.cnt, b.rdate, b.ddate, b.word,
      a.adminno as a_adminno, a.name, a.id, a.img, a.profileimg, a.admincodeno, a.phone1, a.phone2, a.email
    from adminboard b, admin a
    where a.adminno = b.adminno
    order by adminboardno desc
  )
)
WHERE r >=1 AND r <= 3
 
-- �˻�        
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, r
FROM(
         SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, rownum as r
         FROM(
                  SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word
                  FROM contents
                  WHERE cateno=6 AND word LIKE '%swiss%'
                  ORDER BY contentsno DESC
         )
)
WHERE r >=1 AND r <= 3;
 
 CONTENTSNO CATENO TITLE CONTENT    GOOD THUMBS     FILES    SIZES  CNT REPLYCNT RDATE                 WORD  R
 ---------- ---------- ----- ---------- ---- ---------- -------- ------ --- -------- --------------------- ----- -
          4          6 �ٴٰǳ�  ũ���������� ������    0 sw17_t.jpg sw17.jpg 218754   0        0 2018-05-30 17:08:42.0 swiss 1
 
      
15) �亯
[�亯 ����]
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM cate;
 
�� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 5;
 
 
�� �亯 ���
- cateno: FK, mno: FK
 
INSERT INTO contents(contentsno,
                          cateno, mno, title, content, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '����', '����',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
�� �亯�� ���� ���� ���� ����    
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word, grpno, indent, ansnum
                  FROM contents
                  WHERE cateno=1 AND word LIKE '%swiss%'
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
 
16) Join�� ���� id�� ���
-- id �� ��µ��� �ʴ� ���
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word, grpno, indent, ansnum
                  FROM contents
                  WHERE cateno=1
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
 CONTENTSNO CATENO TITLE CONTENT    GOOD THUMBS        FILES       SIZES CNT REPLYCNT RDATE                 WORD              GRPNO INDENT ANSNUM R
 ---------- ---------- ----- ---------- ---- ------------- ----------- ----- --- -------- --------------------- ----------------- ----- ------ ------ -
          1          1 Alps  ũ���������� ������    0 japan05_t.jpg japan05.jpg 80215   0        0 2018-12-06 10:01:04.0 ����,����,����,����,��ǳ,ù��     1      0      0 1
 
 
-- mno, id �� ��µǴ� ���
SELECT mno, id,
          contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT mno, id, 
                   contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT m.mno, m.id,
                            c.contentsno, c.cateno, c.title, c.content, c.good, 
                            c.thumbs, c.files, c.sizes, c.cnt,
                            c.replycnt, c.rdate, c.word, c.grpno, c.indent, c.ansnum
                  FROM member m, contents c 
                  WHERE m.mno = c.mno AND c.cateno=1
                  ORDER BY c.grpno DESC, c.ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
-- mno, id �� ��µǰ� �˻��ϴ� ���
SELECT mno, id,
          contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT mno, id, 
                   contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT m.mno, m.id,
                            c.contentsno, c.cateno, c.title, c.content, c.good, 
                            c.thumbs, c.files, c.sizes, c.cnt,
                            c.replycnt, c.rdate, c.word, c.grpno, c.indent, c.ansnum
                  FROM member m, contents c 
                  WHERE m.mno = c.mno AND c.cateno=1 AND word LIKE '%alps%'
                  ORDER BY c.grpno DESC, c.ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
DELETE FROM contents;
DELETE FROM cate;
DELETE FROM categrp;
 
-- ��¥ ó��(insert)
DELETE FROM contents;

INSERT INTO contents(contentsno,
                  cateno, mno, title, content, rdate, grpno,
                  startdate, enddate)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '������', '��ũ', sysdate, 0,
            TO_DATE('2017-05-25 06:00:00', 'YYYY-MM-DD HH:MI:SS'),
            TO_DATE('2017-05-26 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
            
SELECT  contentsno, startdate, enddate
FROM contents
WHERE cateno=1
ORDER BY contentsno ASC;

 CONTENTSNO STARTDATE             ENDDATE
 ---------- --------------------- ---------------------
          1 2017-05-25 06:00:00.0 2017-05-26 18:00:00.0
           
-- ��¥ ó��(update)
DELETE FROM contents;

UPDATE contents
SET startdate=TO_DATE('2019-05-25 06:00:00', 'YYYY-MM-DD HH:MI:SS'),
      enddate=TO_DATE('2019-05-26 06:00:00', 'YYYY-MM-DD HH:MI:SS')
WHERE contentsno=1;

SELECT  contentsno, startdate, enddate
FROM contents
WHERE cateno=1
ORDER BY contentsno ASC;

 CONTENTSNO STARTDATE             ENDDATE
 ---------- --------------------- ---------------------
          1 2019-05-25 06:00:00.0 2019-05-26 06:00:00.0


-----------------------------------------------------------------------------------


/**********************************/
/* Table Name: ������ �Խ��� ��� */
/**********************************/
CREATE TABLE admincomment(
    admincommentno                    NUMBER(10)    NOT NULL,
    comments                           CLOB     NOT NULL,
    rdate                             DATE     DEFAULT sysdate     NOT NULL,
    grpno                             NUMBER(10)    DEFAULT 0     NOT NULL,
    indent                            NUMBER(10)    DEFAULT 0     NOT NULL,
    ansnum                            NUMBER(10)    DEFAULT 0     NOT NULL,
    adminno                           NUMBER(10)     NOT NULL ,
    adminboardno                      NUMBER(10)     NOT NULL 
);

COMMENT ON TABLE admincomment is '������ �Խ��� ���';
COMMENT ON COLUMN admincomment.admincommentno is '��� ��ȣ';
COMMENT ON COLUMN admincomment.comments is '��� ����';
COMMENT ON COLUMN admincomment.rdate is '��� �ð�';
COMMENT ON COLUMN admincomment.grpno is '�׷� ��ȣ';
COMMENT ON COLUMN admincomment.indent is 'ĭ ��';
COMMENT ON COLUMN admincomment.ansnum is '�鿩����';
COMMENT ON COLUMN admincomment.adminno is '������ ��ȣ';
COMMENT ON COLUMN admincomment.adminboardno is '������ �Խ��� ��ȣ';


ALTER TABLE admincomment ADD CONSTRAINT IDX_admincomment_PK PRIMARY KEY (admincommentno);
ALTER TABLE admincomment ADD CONSTRAINT IDX_admincomment_FK0 FOREIGN KEY (adminno) REFERENCES admin (adminno);
ALTER TABLE admincomment ADD CONSTRAINT IDX_admincomment_FK1 FOREIGN KEY (adminboardno) REFERENCES adminboard (adminboardno);


    insert into admincomment(
      admincommentno, adminboardno, adminno,
      comments,
      grpno, indent, ansnum
    ) values(
      (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 1, 1,
      '����»',
      0,0,0
    )
    
    insert into admincomment(
      admincommentno, adminboardno, adminno,
      comments,
      grpno, indent, ansnum
    ) values(
      (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 2, 2,
      '����»',
      0,0,0
    )
    
    insert into admincomment(
      admincommentno, adminboardno, adminno,
      comments,
      grpno, indent, ansnum
    ) values(
      (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 3, 3,
      '����»',
      0,0,0
    )


insert into admincomment(
  admincommentno, adminboardno, adminno,
  comments,
  grpno, indent, ansnum
) values(
  (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 1, 1,
  '����»',
  1,1,1
)


insert into admincomment(
  admincommentno, adminboardno, adminno,
  comments,
  grpno, indent, ansnum
) values(
  (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 1, 1,
  '����»',
  1,1,1
)

update admincomment
set ansnum = ansnum + 1
where grpno = #{grpno} AND ansnum > #{ansnum}


    SELECT 
      rownum as r,
      a.adminno as a_adminno, a.name, a.id, a.profileimg, a.admincodeno, a.email,
      s.admincodeno as s_admincodeno, s.privchar, s.privdesc,
      b.adminboardno as adminboardno, b.adminno as b_adminno, b.title,
      c.admincommentno,
      c.adminboardno as c_adminboardno, c.adminno,
      c.comments,
      c.grpno, c.indent, c.ansnum
    FROM admin a, adminboard b, admincomment c, admincode s
    where 
      a.admincodeno = s.admincodeno
      and a.adminno = b.adminno
      and c.adminboardno = b.adminboardno
      
    ORDER BY grpno DESC, ansnum ASC


15) �亯
[�亯 ����]
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM cate;
 
�� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 5;
 
 
�� �亯 ���
- cateno: FK, mno: FK
 
INSERT INTO contents(contentsno,
                          cateno, mno, title, content, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '����', '����',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
�� �亯�� ���� ���� ���� ����    
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word, grpno, indent, ansnum
                  FROM contents
                  WHERE cateno=1 AND word LIKE '%swiss%'
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;



