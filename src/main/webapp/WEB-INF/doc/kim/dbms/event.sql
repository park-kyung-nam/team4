/**********************************/
/* Table Name: 관리자 */
/**********************************/
DROP TABLE admin;

CREATE TABLE admin(
    adminno                           NUMBER(10)     NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.adminno is '관리자 번호';

SELECT adminno
FROM admin;

INSERT INTO admin(adminno)
VALUES(1);


/**********************************/
/* Table Name: 상품 */
/**********************************/
DROP TABLE prodno;

CREATE TABLE prodno(
    prodno                            NUMBER(10)     NOT NULL    PRIMARY KEY
);

COMMENT ON TABLE prodno is '상품';
COMMENT ON COLUMN prodno.prodno is '상품 번호';

--SEQUENCE 객체 생성
DROP SEQUENCE product_seq

CREATE SEQUENCE product_seq
START WITH 1                 -- 시작 번호
INCREMENT BY 1             -- 증가값
MAXVALUE   99999999     -- 최대값, NUMBER(7) 대응
CACHE         2                  -- 시퀀스 변경시 자주 update 되는 것
NOCYCLE;

INSERT INTO prodno(prodno)
VALUES(product_seq.nextval);


/**********************************/
/* Table Name: 이벤트 */
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

COMMENT ON TABLE event is '이벤트';
COMMENT ON COLUMN event.eventno is '글 번호';
COMMENT ON COLUMN event.e_title is '제목';
COMMENT ON COLUMN event.e_content is '내용';
COMMENT ON COLUMN event.e_file1 is '파일';
COMMENT ON COLUMN event.e_size1 is '파일 크기';
COMMENT ON COLUMN event.e_thumb1 is '작은 이미지';
COMMENT ON COLUMN event.e_cnt is '조회수';
COMMENT ON COLUMN event.replycnt is '답변 수';
COMMENT ON COLUMN event.rdate is '날짜';
COMMENT ON COLUMN event.indent is '답변 차수';
COMMENT ON COLUMN event.ansnum is '답변 순서';
COMMENT ON COLUMN event.word is '검색어';
COMMENT ON COLUMN event.adminno is '관리자 번호';
COMMENT ON COLUMN event.prodno is '상품 번호';

--SEQUENCE 객체 생성
DROP SEQUENCE event_seq

CREATE SEQUENCE event_seq
START WITH 1                 -- 시작 번호
INCREMENT BY 1             -- 증가값
MAXVALUE   99999999     -- 최대값, NUMBER(7) 대응
CACHE         2                  -- 시퀀스 변경시 자주 update 되는 것
NOCYCLE;

-- 등록
INSERT INTO event(eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                            rdate, indent, ansnum, word, adminno, prodno)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event), '[사은품] 컬러풀 그래픽카드 SSD 1:1 증정 이벤트', 'COLORFUL iGAME 지포스 GTX 1660 구매하고 SSD 받자 !', 
            'event.jpg', 1000, 'event_t.jpg', 0, 0, sysdate, 0, 0, '이벤트', 1, 1);

INSERT INTO event(eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt,
                            rdate, indent, ansnum, word, adminno, prodno)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event), '[특가] ASRock Z390 스틸레전드 한정 예약 판매 이벤트 !', 'ASRock Z390 스틸레전드 디앤디컴',
            'event.jpg', 1000, 'event_t.jpg', 0, 0, sysdate, 0, 0, '이벤트', 1, 1);

INSERT INTO event(eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt,
                            rdate, indent, ansnum, word, adminno, prodno)
VALUES((SELECT NVL(MAX(eventno), 0)+1 as eventno FROM event), '[댓글 이벤트] ShockWave SK-POP 사운드바 출시 댓글 이벤트 !', '제품에 대하여 자유로운 의견을 달아주세요! (제품의 장점, 단점, 바라는점 및 응원댓글을 적어주세요!!) 추첨을 통하여 3분께 경품을 드리겠습니다~!', 
            'event.jpg', 1000, 'event_t.jpg', 0, 0, sysdate, 0, 0, '이벤트', 1, 1);
            
-- 목록
SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
           indent, ansnum, word, adminno, prodno
FROM event
ORDER BY eventno ASC;

 EVENTNO E_TITLE                                    E_CONTENT                                                                           E_FILE1   E_SIZE1 E_THUMB1    E_CNT RDATE      ADMINNO PRODNO
 ------- ------------------------------------------ ----------------------------------------------------------------------------------- --------- ------- ----------- ----- ---------- ------- ------
       1 [사은품] 컬러풀 그래픽카드 SSD 1:1 증정 이벤트             COLORFUL iGAME 지포스 GTX 1660 구매하고 SSD 받자 !                                           event.jpg    1000 event_t.jpg     0 2019-05-23       1      1
       2 [특가] ASRock Z390 스틸레전드 한정 예약 판매 이벤트 !      ASRock Z390 스틸레전드 디앤디컴                                                              event.jpg    1000 event_t.jpg     0 2019-05-23       1      1
       3 [댓글 이벤트] ShockWave SK-POP 사운드바 출시 댓글 이벤트 ! 제품에 대하여 자유로운 의견을 달아주세요! (제품의 장점, 단점, 바라는점 및 응원댓글을 적어주세요!!) 추첨을 통하여 3분께 경품을 드리겠습니다~! event.jpg    1000 event_t.jpg     0 2019-05-23       1      1


--조회
/*
 * e_content 생략 후 조회
 */
SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
           indent, ansnum, word, adminno, prodno
FROM event
WHERE eventno = 1;
      
EVENTNO E_TITLE                        E_FILE1   E_SIZE1 E_THUMB1    E_CNT RDATE                 ADMINNO PRODNO
 ------- ------------------------------ --------- ------- ----------- ----- --------------------- ------- ------
       1 [사은품] 컬러풀 그래픽카드 SSD 1:1 증정 이벤트 event.jpg    1000 event_t.jpg     0 2019-05-23 18:11:04.0       1      1

-- 수정
UPDATE event
SET e_title='[이벤트] 적립금 이벤트', e_content='적립금',
      e_file1='event_f.jpg', e_thumb1='event.jpg', e_size1 = 1500
WHERE eventno =1;

-- 한건의 레코드 삭제
DELETE FROM event
WHERE eventno=1;

-- 모든 레코드 삭제
DELETE FROM event;

-- 출력순서의 낮춤(나중에 출 력)
UPDATE event
SET seqno = seqno + 1
WHERE eventno= 1;
 
-- 출력 순서의 높임(먼저 출력)
UPDATE event
SET seqno = seqno - 1
WHERE eventno= 1;

-- 최대값
SELECT MAX(seqno)+1 as seqno 
FROM event;
 
-- MAX 함수는 레코드가 없으면 null을 출력함으로 사칙연산이 불가능함.
SELECT MAX(seqno)+1 as seqno 
FROM event;
 
-- NVL 함수의 사용으로 null 값일경우 0으로 변경되어 1이 출력됨.
SELECT NVL(MAX(seqno), 0)+1 as seqno 
FROM event;
     
     -- 등록된 글 수 증가
UPDATE event
SET e_cnt = e_cnt + 1
WHERE eventno=1;
 
-- 등록된 글 수 감소
UPDATE event
SET e_cnt = e_cnt - 1
WHERE eventno=1;

-- 페이징

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

-- 검색 + 페이징

SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno, r 
FROM(
          SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno, rownum as r
          FROM(
                    SELECT eventno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, rdate, word, adminno, prodno
                    FROM event
                    WHERE eventno=1 AND word LIKE '%이%'
                    ORDER BY eventno DESC
           )
)
WHERE r >=1 AND r <=3;

--답변

SELECT * FROM event;

① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 0;

-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 2;

UPDATE event
SET ansnum = ansnum + 1
WHERE ansnum > 5;
 
② 답변 등록

INSERT INTO event(eventno, adminno, prodno, 
                             e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                             rdate, word, indent, ansnum)  
VALUES((SELECT NVL(MAX(eventno), 0) + 1 as eventno FROM event), 
            1, 1, '이벤트', '이벤트', 'event.jpg', 1000, 'event_t.jpg', 0, 0, 
             sysdate, '', 1, 1);
 
③ 답변에 따른 정렬 순서 변경    
SELECT eventno, prodno, adminno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
           rdate, indent, ansnum, r 
FROM(
         SELECT eventno, prodno, adminno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                    rdate, indent, ansnum, rownum as r
          FROM(
                  SELECT eventno, prodno, adminno, e_title, e_content, e_file1, e_size1, e_thumb1, e_cnt, replycnt, 
                             rdate, indent, ansnum
                    FROM event
                    WHERE eventno=1 word LIKE '%이벤트%'
                    ORDER BY eventno DESC
         )
)
WHERE r >=1 AND r <= 3;
