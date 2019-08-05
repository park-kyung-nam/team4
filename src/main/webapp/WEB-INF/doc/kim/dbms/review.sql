/**********************************/
/* Table Name: 후기 */
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

COMMENT ON TABLE review is '후기';
COMMENT ON COLUMN review.reviewno is '글 번호';
COMMENT ON COLUMN review.r_title is '제목';
COMMENT ON COLUMN review.r_content is '내용';
COMMENT ON COLUMN review.r_file1 is '파일';
COMMENT ON COLUMN review.r_size1 is '파일 크기';
COMMENT ON COLUMN review.r_thumb1 is '작은 이미지';
COMMENT ON COLUMN review.r_cnt is '조회수';
COMMENT ON COLUMN review.replycnt is '답변 수';
COMMENT ON COLUMN review.rdate is '날짜';
COMMENT ON COLUMN review.rname is '글쓴이';
COMMENT ON COLUMN review.grpno is '그룹 번호'
COMMENT ON COLUMN review.indent is '답변 차수';
COMMENT ON COLUMN review.ansnum is '답변 순서';
COMMENT ON COLUMN review.word is '검색어';
COMMENT ON COLUMN review.score is '별점';
COMMENT ON COLUMN review.prodno is '상품 번호';
COMMENT ON COLUMN review.customerno is '회원 번호';


--SEQUENCE 객체 생성
DROP SEQUENCE review_seq

CREATE SEQUENCE review_seq
START WITH 1                 -- 시작 번호
INCREMENT BY 1             -- 증가값
MAXVALUE   99999999     -- 최대값, NUMBER(7) 대응
CACHE         2                  -- 시퀀스 변경시 자주 update 되는 것
NOCYCLE;

--등록
INSERT INTO review(reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, grpno, indent, ansnum, word, score, prodno, customerno)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review), '구매후기', '구매후기', 
            'review.jpg', 1000, 'review_t.jpg', 0, 0, sysdate,
            '가', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review), 0, 0, '리뷰', 0, 1, 1);
            
INSERT INTO review(reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, indent, ansnum, word, score, prodno, customerno)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review), '구매후기2', '구매후기2', 
            'review.jpg', 1000, 'review_t.jpg', 0, 0, sysdate, 
            '나', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review), 0, 0, '리뷰', 0, 1, 1);

INSERT INTO review(reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, indent, ansnum, word, score, prodno, customerno)
VALUES((SELECT NVL(MAX(reviewno), 0)+1 as reviewno FROM review), '구매후기3', '구매후기3', 
            'review.jpg', 1000, 'review_t.jpg', 0, 0, sysdate, 
             '다', (SELECT NVL(MAX(grpno), 0)+1 as grpno FROM review), 0, 0, '리뷰', 0, 1, 1);
            
-- 목록
SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
            rname, grpno, indent, ansnum, word, score, prodno, customerno
FROM review
ORDER BY reviewno ASC;

 REVIEWNO R_TITLE R_CONTENT R_FILE1    R_SIZE1 R_THUMB1     R_CNT REPLYCNT RDATE      RNAME PASSWD INDENT ANSNUM WORD SCORE PRODNO CUSTOMERNO
 -------- ------- --------- ---------- ------- ------------ ----- -------- ---------- ----- ------ ------ ------ ---- ----- ------ ----------
        8 구매후기    구매후기      review.jpg    1000 review_t.jpg     0        0 2019-07-26 가     123         0      0 리뷰       0      1          1
        9 구매후기2   구매후기2     review.jpg    1000 review_t.jpg     0        0 2019-07-26 나     123         0      0 리뷰       0      1          1
       10 구매후기3   구매후기3     review.jpg    1000 review_t.jpg     0        0 2019-07-26 다     123         0      0 리뷰       0      1          1

      
--조회
SELECT reviewno, r_title, r_file1, r_size1, r_thumb1, r_cnt, replycnt, rdate, 
           rname, grpno, indent, ansnum, word, score, prodno, customerno
FROM review
WHERE reviewno = 1;

REVIEWNO R_TITLE R_FILE1    R_SIZE1 R_THUMB1     R_CNT RDATE                 SCORE PRODNO
 -------- ------- ---------- ------- ------------ ----- --------------------- ----- ------
        1 구매후기    review.jpg    1000 review_t.jpg     0 2019-05-23 18:13:23.0     0      1


        
-- 수정
UPDATE review
SET r_title='첫 구매 후기', r_content='첫 구매 후기'
WHERE reviewno =1;

-- 한건의 레코드 삭제
DELETE FROM review
WHERE reviewno=3;

-- 모든 레코드 삭제
DELETE FROM review;

SELECT r_content
FROM review;

-- 출력순서의 낮춤(나중에 출 력)
UPDATE review
SET seqno = seqno + 1
WHERE reviewno= 1;
 
-- 출력 순서의 높임(먼저 출력)
UPDATE review
SET seqno = seqno - 1
WHERE reviewno= 1;

-- 최대값
SELECT MAX(seqno)+1 as seqno 
FROM review;
 
-- MAX 함수는 레코드가 없으면 null을 출력함으로 사칙연산이 불가능함.
SELECT MAX(seqno)+1 as seqno 
FROM review;
 
-- NVL 함수의 사용으로 null 값일경우 0으로 변경되어 1이 출력됨.
SELECT NVL(MAX(seqno), 0)+1 as seqno 
FROM event;
     
     -- 등록된 글 수 증가
UPDATE review
SET r_cnt = r_cnt + 1
WHERE reviewno=1;
 
-- 등록된 글 수 감소
UPDATE review
SET r_cnt = r_cnt - 1
WHERE reviewno=1;

-- 페이징

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

-- 검색 + 페이징

SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, rdate, word, score, prodno, customerno, r 
FROM(
          SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, rdate, word, score, prodno, customerno, rownum as r
          FROM(
                    SELECT reviewno, r_title, r_content, r_file1, r_size1, r_thumb1, replycnt, r_cnt, rdate, word, score, prodno, customerno
                    FROM review
                    WHERE reviewno=1 AND word LIKE '%리%'
                    ORDER BY reviewno DESC
           )
)
WHERE r >=1 AND r <=3;

-- 답변

SELECT * FROM review;

① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE review
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;
 
 
② 답변 등록
-- cateno: FK, mno: FK
 
INSERT INTO review(reviewno, prodno,
                             r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, grpno, word, indent, ansnum)  
VALUES((SELECT NVL(MAX(reviewno), 0) + 1 as reviewno FROM review), 
            1, '구매후기', '구매후기', 'review.jpg', 1000, 'review_t.jpg', 0, 0, 
             sysdate, '가s', 1, '', 1, 1);
 
 
③ 답변에 따른 정렬 순서 변경    
SELECT reviewno, prodno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
           rdate, rname, grpno, indent, ansnum, r 
FROM(
         SELECT reviewno, prodno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                    rdate, rname, grpno, indent, ansnum, rownum as r
          FROM(
                  SELECT reviewno, prodno, r_title, r_content, r_file1, r_size1, r_thumb1, r_cnt, replycnt, 
                             rdate, rname, grpno, indent, ansnum
                    FROM review
                    WHERE reviewno=1 word LIKE '%리뷰%'
                    ORDER BY reviewno DESC
         )
)
WHERE r >=1 AND r <= 3;

