/**********************************/
/* Table Name: 고객 */
/**********************************/
CREATE TABLE customer(
       customerno                       NUMBER(10)   NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE customer is '고객';
COMMENT ON COLUMN customer.customerno is ' 고객 번호';

INSERT INTO customer(customerno)
VALUES(1);

SELECT customerno
FROM customer
WHERE customerno = 1;

/**********************************/
/* Table Name: 중고 */
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

COMMENT ON TABLE used is '중고';
COMMENT ON COLUMN used.usedno is '중고 번호';
COMMENT ON COLUMN used.u_title is '중고 글 제목';
COMMENT ON COLUMN used.u_content is '중고 내용';
COMMENT ON COLUMN used.u_file1 is '중고 파일';
COMMENT ON COLUMN used.u_size1 is '중고 파일 크기';
COMMENT ON COLUMN used.u_thumb1 is '중고 작은 이미지';
COMMENT ON COLUMN used.u_cnt is '조회수';
COMMENT ON COLUMN used.replycnt is '답변 수';
COMMENT ON COLUMN used.rdate is '날짜';
COMMENT ON COLUMN used.rname is '중고 글쓴이';
COMMENT ON COLUMN used.grpno is '그룹 번호';
COMMENT ON COLUMN used.indent is '답변 차수';
COMMENT ON COLUMN used.ansnum is '답변 순서';
COMMENT ON COLUMN used.word is '검색어';
COMMENT ON COLUMN used.customerno is '고객 번호';

-- 등록
INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word, customerno)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '중고매입1', '중고매입1',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '가', 
             (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM used), 0, 0, '중고매입', 1);

INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word, customerno)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '중고매입2', '중고매입2',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '나',
             (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM used), 0, 0, '중고매입', 1);

INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word, customerno)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '중고매입3', '중고매입',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '다',
             (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM used), 0, 0, '중고매입', 1);

-- 목록
SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           TO_CHAR(rdate, 'yyyy-mm-dd') as rdate, rname, grpno, indent, ansnum, word, customerno
FROM used
ORDER BY usedno ASC;

 USEDNO U_TITLE U_CONTENT U_FILE1  U_SIZE1 U_THUMB1   U_CNT REPLYCNT RDATE      RNAME INDENT ANSNUM WORD CUSTOMERNO
 ------ ------- --------- -------- ------- ---------- ----- -------- ---------- ----- ------ ------ ---- ----------
      1 중고매입    중고매입      used.jpg    1000 used_t.jpg     0        0 2019-07-30 가          0      0 중고매입          1
      2 중고매입2   중고매입2     used.jpg    1000 used_t.jpg     0        0 2019-07-30 나          0      0 중고매입          1
      3 중고매입3   중고매입      used.jpg    1000 used_t.jpg     0        0 2019-07-30 다          0      0 중고매입          1

-- 조회
SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           rdate, rname, grpno, indent, ansnum, word, customerno
FROM used
WHERE usedno = 1;

 USEDNO U_TITLE U_CONTENT U_FILE1  U_SIZE1 U_THUMB1   U_CNT REPLYCNT RDATE                 RNAME INDENT ANSNUM WORD CUSTOMERNO
 ------ ------- --------- -------- ------- ---------- ----- -------- --------------------- ----- ------ ------ ---- ----------
      1 중고매입    중고매입      used.jpg    1000 used_t.jpg     0        0 2019-07-30 15:08:21.0 가          0      0 중고매입          1

-- 수정
UPDATE used
SET u_title='중고 PC 판매', u_content='중고 PC 판매'
WHERE usedno = 1;

-- 한 건의 레코드 삭제
DELETE FROM used
WHERE usedno = 3;

-- 모든 레코드 삭제
DELETE FROM used;

-- 페이징

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

-- 검색 + 페이징

SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           rdate, rname, indent, ansnum, word, customerno, r
FROM(
         SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                     rdate, rname, indent, ansnum, word, customerno, rownum as r
         FROM(
                   SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                              rdate, rname, indent, ansnum, word, customerno
                   FROM used
                   WHERE usedno =1 AND word LIKE '%중고%'
                   ORDER BY usedno DESC
         )
)
WHERE r >=1 AND r <=3;

-- 답변

SELECT * FROM used;

① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE used
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;

② 답변 등록

INSERT INTO used(usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt, 
                           rdate, rname, grpno, indent, ansnum, word)
VALUES((SELECT NVL(MAX(usedno), 0)+1 as usedno FROM used), '중고매입1', '중고매입1',
             'used.jpg', 1000, 'used_t.jpg', 0, 0, sysdate, '가', 1, 0, 0, '중고매입');

③ 답변에 따른 정렬 순서 변경    

SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
           rdate, rname, grpno, indent, ansnum, word, customerno, r
FROM(
         SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                     rdate, rname, grpno, indent, ansnum, word, customerno, rownum as r
         FROM(
                   SELECT usedno, u_title, u_content, u_file1, u_size1, u_thumb1, u_cnt, replycnt,              
                              rdate, rname, grpno, indent, ansnum, word, customerno
                   FROM used
                   WHERE usedno =1 AND word LIKE '%중고%'
                   ORDER BY usedno DESC
         )
)
WHERE r >=1 AND r <=3;


