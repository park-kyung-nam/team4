/**********************************/
/* Table Name: 관리자 게시판 */
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

COMMENT ON TABLE adminboard is '관리자 게시판';
COMMENT ON COLUMN adminboard.adminboardno is '관리자 게시판 번호';
COMMENT ON COLUMN adminboard.title is '제목';
COMMENT ON COLUMN adminboard.content is '내용';
COMMENT ON COLUMN adminboard.files is '파일';
COMMENT ON COLUMN adminboard.sizes is '파일 크기';
COMMENT ON COLUMN adminboard.rdate is '등록일';
COMMENT ON COLUMN adminboard.ddate is '마감일';
COMMENT ON COLUMN adminboard.word is '태그';
COMMENT ON COLUMN adminboard.cnt is '조회수';
COMMENT ON COLUMN adminboard.adminno is '관리자 번호';


ALTER TABLE adminboard ADD CONSTRAINT IDX_adminboard_PK PRIMARY KEY (adminboardno);
ALTER TABLE adminboard ADD CONSTRAINT IDX_adminboard_FK0 FOREIGN KEY (adminno) REFERENCES admin (adminno);



4) contents 등록             
- 새로운 글, 답변 글에따라 등록 SQL차이가 있습니다.
- 새로운 글 등록은 새로운 그룹이 만들어지는 기능이 있습니다. MAX + 1
- cateno 컬럼 1번 기준
- mno 컬럼 1번 기준

INSERT INTO adminboard(adminboardno, adminno,
    title, content, files, sizes, 
    cnt, rdate, ddate, word)  
VALUES((SELECT NVL(MAX(adminboardno), 0) + 1 as adminboardno FROM adminboard), 0,
    '직원 공지사항 제목','두근두근', null, null,
    0, sysdate, sysdate + 7, null
);

select adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word
from adminboard
order by adminboardno desc
            
5) 전체 목록(댓글 구현)

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

 
7) 전체 카운트
SELECT COUNT(*) as count
FROM adminboard;
 
8) 조회
select adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word
from adminboard
where adminboardno = 1
 
9) 수정
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
 
10) 삭제
DELETE FROM adminboard
WHERE adminboardno=1

update adminboard
set 
  adminno = -1
where adminno = 1

DELETE FROM adminboard
WHERE adminboardno=1
 
11) 검색(%: 없거나 하나 이상의 모든 문자)
-- word LIKE '스위스' → word = '스위스'
   ^스위스$
-- word LIKE '%스위스' → word = '잊지 못할 스위스'
   .*스위스$
-- word LIKE '스위스%' → word = '스위스에서~'
   ^스위스.*
-- word LIKE '%스위스%' → word = '유럽 여행은 스위스 꼭 방문해야~'
   .*스위스.*
 
-- '스위스' 컬럼으로 검색
SELECT contentsno,
          cateno, mno, title, good, thumbs, files, sizes, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM contents
WHERE cateno=6 AND word LIKE '%스위스%'
ORDER BY contentsno DESC;
 
-- '스의스' 컬럼으로 검색
SELECT contentsno,
          cateno, mno, title, good, thumbs, files, sizes, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM contents
WHERE cateno=6 AND word LIKE '%스의스%'
ORDER BY contentsno DESC;
 
-- '수의스' 컬럼으로 검색
SELECT contentsno,
          cateno, mno, title, good, thumbs, files, sizes, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM contents
WHERE cateno=6 AND word LIKE '%수의스%'
ORDER BY contentsno DESC;
 
-- 'swiss' 컬럼으로 검색

select adminboardno, adminno, title, content, files, sizes, cnt, rdate, ddate, word
from adminboard
WHERE word LIKE '%swiss%'
order by adminboardno desc
 
 
12) 검색 및 전체 레코드 갯수
-- '스위스' 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM adminboard
WHERE word LIKE '%스위스%';
 
13) 페이징
 
DROP TABLE PG;
 
CREATE TABLE PG(
  num NUMBER(5) NOT NULL,
  title  VARCHAR(20) NOT NULL,
  PRIMARY KEY(num)
);
 
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '01월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '04월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '05월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '06월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '07월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '08월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '09월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '10월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '11월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '12월');
 
SELECT num, title FROM pg;
 
 NUM TITLE
 --- -----
   1 01월
   2 02월
   3 03월
   4 04월
   5 05월
   6 06월
   7 07월
   8 08월
   9 09월
  10 10월
  11 11월
  12 12월
 
-- 분기별로 분할하여 레코드를 추출하는 경우(페이징)
SELECT num, title FROM pg;
 
-- rownum: oralce system에서 select시에 자동으로 붙여주는 일련번호
SELECT num, title, rownum FROM pg;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   2 02월        2
   3 03월        3
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
 
-- 2,3월 삭제
DELETE FROM pg WHERE num=2 or num=3;
 
SELECT num, title, rownum FROM pg;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        2
   5 05월        3
   6 06월        4
   7 07월        5
   8 08월        6
   9 09월        7
  10 10월        8
  11 11월        9
  12 12월       10
 
 
-- 페이징시는 일정한 순차값이 생성되는 rownum 값을 사용합니다.
-- rownum주의: rownum은 정렬(ORDER BY ~)보다 먼저 생성됨으로
   정렬을 한 후 rownum 컬럼을 사용합니다.
 
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '봄');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '여름');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '가을');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '겨울');
 
-- Paging Step 1
-- SELECT → ROWNUM → ORDER BY ~
SELECT num, title, rownum 
FROM pg
ORDER BY title ASC;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
  15 가을         2
  16 겨울         3
  13 봄         13
  14 여름        14
  
  
-- Paging Step 2, subquery
SELECT num, title, rownum
FROM (
           SELECT num, title 
           FROM pg
           ORDER BY num ASC
);
 
  NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        2
   5 05월        3
   6 06월        4
   7 07월        5
   8 08월        6
   9 09월        7
  10 10월        8
  11 11월        9
  12 12월       10
  13 봄         11
  14 여름        12
  15 가을        13
  16 겨울        14
  
-- 2,3 월을 추가하세요.
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03월');
 
-- 목록 다시 출력, ☆ rownum이 생성되고 정렬 기능이 작동함
SELECT num, title, rownum
FROM pg
ORDER BY title ASC;
  
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  17 02월       15
  18 03월       16
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
  15 가을         2
  16 겨울         3
  13 봄          13
  14 여름        14
  
-- Subquery에서 정렬후 rownum을 사용
SELECT num, title, rownum
FROM (
           SELECT num, title
           FROM pg
           ORDER BY title ASC
);
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  17 02월        2
  18 03월        3
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
  15 가을        13
  16 겨울        14
  13 봄          15
  14 여름        16
 
-- Paging Step 3, subquery
-- 1 분기
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
   1 01월   1
  17 02월   2
  18 03월   3
   
-- 2 분기
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
   4 04월   4
   5 05월   5
   6 06월   6
 
 
   
* rownum은 최초 1페이지만 정상 처리되고 2페이부터는 WHERE문에서 
  인식이안됩니다. 따라서 3단 쿼리를 사용해야합니다.   
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=1 AND rownum <=3;
 
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  17 02월        2
  18 03월        3
 
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=4 AND rownum <=6;
 
 NUM TITLE ROWNUM
 --- ----- ------
 
 
14) 페이징 구현
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
 
-- 검색        
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
          4          6 바다건너  크리스마스에 갔던곳    0 sw17_t.jpg sw17.jpg 218754   0        0 2018-05-30 17:08:42.0 swiss 1
 
      
15) 답변
[답변 쓰기]
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM cate;
 
① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 5;
 
 
② 답변 등록
- cateno: FK, mno: FK
 
INSERT INTO contents(contentsno,
                          cateno, mno, title, content, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '제목', '내용',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
③ 답변에 따른 정렬 순서 변경    
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
 
 
16) Join을 통한 id의 출력
-- id 가 출력되지 않는 경우
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
          1          1 Alps  크리스마스에 갔던곳    0 japan05_t.jpg japan05.jpg 80215   0        0 2018-12-06 10:01:04.0 여행,동해,서해,남해,단풍,첫눈     1      0      0 1
 
 
-- mno, id 가 출력되는 경우
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
 
-- mno, id 가 출력되고 검색하는 경우
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
 
-- 날짜 처리(insert)
DELETE FROM contents;

INSERT INTO contents(contentsno,
                  cateno, mno, title, content, rdate, grpno,
                  startdate, enddate)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '프린터', '잉크', sysdate, 0,
            TO_DATE('2017-05-25 06:00:00', 'YYYY-MM-DD HH:MI:SS'),
            TO_DATE('2017-05-26 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
            
SELECT  contentsno, startdate, enddate
FROM contents
WHERE cateno=1
ORDER BY contentsno ASC;

 CONTENTSNO STARTDATE             ENDDATE
 ---------- --------------------- ---------------------
          1 2017-05-25 06:00:00.0 2017-05-26 18:00:00.0
           
-- 날짜 처리(update)
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
/* Table Name: 관리자 게시판 댓글 */
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

COMMENT ON TABLE admincomment is '관리자 게시판 댓글';
COMMENT ON COLUMN admincomment.admincommentno is '댓글 번호';
COMMENT ON COLUMN admincomment.comments is '댓글 내용';
COMMENT ON COLUMN admincomment.rdate is '등록 시간';
COMMENT ON COLUMN admincomment.grpno is '그룹 번호';
COMMENT ON COLUMN admincomment.indent is '칸 수';
COMMENT ON COLUMN admincomment.ansnum is '들여쓰기';
COMMENT ON COLUMN admincomment.adminno is '관리자 번호';
COMMENT ON COLUMN admincomment.adminboardno is '관리자 게시판 번호';


ALTER TABLE admincomment ADD CONSTRAINT IDX_admincomment_PK PRIMARY KEY (admincommentno);
ALTER TABLE admincomment ADD CONSTRAINT IDX_admincomment_FK0 FOREIGN KEY (adminno) REFERENCES admin (adminno);
ALTER TABLE admincomment ADD CONSTRAINT IDX_admincomment_FK1 FOREIGN KEY (adminboardno) REFERENCES adminboard (adminboardno);


    insert into admincomment(
      admincommentno, adminboardno, adminno,
      comments,
      grpno, indent, ansnum
    ) values(
      (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 1, 1,
      '리셰쨩',
      0,0,0
    )
    
    insert into admincomment(
      admincommentno, adminboardno, adminno,
      comments,
      grpno, indent, ansnum
    ) values(
      (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 2, 2,
      '리라쨩',
      0,0,0
    )
    
    insert into admincomment(
      admincommentno, adminboardno, adminno,
      comments,
      grpno, indent, ansnum
    ) values(
      (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 3, 3,
      '리논쨩',
      0,0,0
    )


insert into admincomment(
  admincommentno, adminboardno, adminno,
  comments,
  grpno, indent, ansnum
) values(
  (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 1, 1,
  '리셰쨩',
  1,1,1
)


insert into admincomment(
  admincommentno, adminboardno, adminno,
  comments,
  grpno, indent, ansnum
) values(
  (SELECT NVL(MAX(admincommentno), 0) + 1 as admincommentno FROM admincomment), 1, 1,
  '리셰쨩',
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


15) 답변
[답변 쓰기]
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM cate;
 
① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE contents
SET ansnum = ansnum + 1
WHERE cateno=1 AND grpno = 1 AND ansnum > 5;
 
 
② 답변 등록
- cateno: FK, mno: FK
 
INSERT INTO contents(contentsno,
                          cateno, mno, title, content, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '제목', '내용',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
③ 답변에 따른 정렬 순서 변경    
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



