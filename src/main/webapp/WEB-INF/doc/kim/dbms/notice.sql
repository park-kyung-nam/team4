
CREATE TABLE admin(
		adminno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.adminno is '관리자 번호';

SELECT adminno
FROM admin
WHERE adminno = 1;

/**********************************/
/* Table Name: 공지사항 */
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

COMMENT ON TABLE notice is '공지사항';
COMMENT ON COLUMN notice.noticeno is '글 번호';
COMMENT ON COLUMN notice.n_title is '제목';
COMMENT ON COLUMN notice.n_content is '내용';
COMMENT ON COLUMN notice.n_file1 is '파일';
COMMENT ON COLUMN notice.n_size1 is '파일 크기';
COMMENT ON COLUMN notice.n_cnt is '조회수';
COMMENT ON COLUMN notice.rdate is '날짜';
COMMENT ON COLUMN notice.word is '검색어';
COMMENT ON COLUMN notice.adminno is '관리자 번호';

--SEQUENCE 객체 생성
DROP SEQUENCE notice_seq;

CREATE SEQUENCE notice_seq
START WITH 1                 -- 시작 번호
INCREMENT BY 1             -- 증가값
MAXVALUE   99999999     -- 최대값, NUMBER(7) 대응
CACHE         2                  -- 시퀀스 변경시 자주 update 되는 것
NOCYCLE;

-- 등록
INSERT INTO notice(noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno)
VALUES( (SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice),
             '[공지사항] 현금영수증 신청 안내사항', '현금영수증 신청 안내사항',             
            'notice.jpg', 1000, 0, sysdate, '공지사항', 1);

INSERT INTO notice(noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno)
VALUES( (SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice), 
            '[공지사항] 컴스클럽 매장방문 "상담 및 방문수령" 공지사항 입니다.', '[공지사항] 컴스클럽 매장방문 "상담 및 방문수령" 공지사항 입니다.',
            'notice.jpg', 1000, 0, sysdate, '공지사항', 1);

INSERT INTO notice(noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno)
VALUES( (SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice),
            '[공지사항] 카카오톡 1:1상담 플러스친구 오픈!', '카카오톡 1:1상담 플러스친구 오픈', 
            'notice.jpg', 1000, 0, sysdate, '공지사항', 1);
-- 목록
SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, TO_CHAR(rdate, 'yyyy-mm-dd') as rdate,
           word, adminno
FROM notice
ORDER BY noticeno ASC;
           
SELECT *
FROM notice

 NOTICENO N_TITLE                                N_CONTENT                              N_FILE1    N_SIZE1 N_CNT RDATE      ADMINNO
 -------- -------------------------------------- -------------------------------------- ---------- ------- ----- ---------- -------
        1 [공지사항] 현금영수증 신청 안내사항                   현금영수증 신청 안내사항                          notice.jpg    1000     0 2019-05-23       1
        2 [공지사항] 컴스클럽 매장방문 "상담 및 방문수령" 공지사항 입니다. [공지사항] 컴스클럽 매장방문 "상담 및 방문수령" 공지사항 입니다. notice.jpg    1000     0 2019-05-23       1
        3 [공지사항] 카카오톡 1:1상담 플러스친구 오픈!            카카오톡 1:1상담 플러스친구 오픈                    notice.jpg    1000     0 2019-05-23       1
--조회
/*
 * n_content 생략 후 조회
 */
SELECT noticeno, n_title, n_file1, n_size1, n_cnt, rdate, word, adminno 
FROM notice
WHERE noticeno = 1;

NOTICENO N_TITLE              N_FILE1    N_SIZE1 N_CNT RDATE                 ADMINNO
 -------- -------------------- ---------- ------- ----- --------------------- -------
        1 [공지사항] 현금영수증 신청 안내사항 notice.jpg    1000     0 2019-05-23 18:08:40.0       1
   
-- 수정
UPDATE notice
SET n_title='[공지사항] 회원 정보 안내', n_content='회원 정보 안내'
WHERE noticeno =1;

-- 한건의 레코드 삭제
DELETE FROM notice
WHERE noticeno=3;

-- 모든 레코드 삭제
DELETE FROM notice;

-- 검색
SELECT noticeno, n_title, n_file1, n_size1, n_cnt, rdate, adminno 
FROM notice 
WHERE word LIKE '%공지사항%'
ORDER BY noticeno DESC;

-- 검색 및 전체 레코드 갯수
SELECT COUNT(*) as cnt
FROM notice
WHERE noticeno = 1;

SELECT COUNT(*) as cnt
FROM notice
WHERE word LIKE '%현금%';

-- 출력순서의 낮춤(나중에 출 력)
UPDATE notice
SET seqno = seqno + 1
WHERE noticeno= 1;
 
-- 출력 순서의 높임(먼저 출력)
UPDATE notice
SET seqno = seqno - 1
WHERE noticeno= 1;

-- 최대값
SELECT MAX(seqno)+1 as seqno 
FROM notice;
 
-- MAX 함수는 레코드가 없으면 null을 출력함으로 사칙연산이 불가능함.
SELECT MAX(seqno)+1 as seqno 
FROM notice;
 
-- NVL 함수의 사용으로 null 값일경우 0으로 변경되어 1이 출력됨.
SELECT NVL(MAX(seqno), 0)+1 as seqno 
FROM notice;
     
     -- 등록된 글 수 증가
UPDATE notice
SET n_cnt = n_cnt + 1
WHERE noticeno=1;
 
-- 등록된 글 수 감소
UPDATE notice
SET n_cnt = n_cnt - 1
WHERE noticeno=1;

 -- 페이징
        
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

-- 검색 + 페이징
SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno, r
FROM(
         SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate, word, adminno, rownum as r
         FROM(
                  SELECT noticeno, n_title, n_content, n_file1, n_size1, n_cnt, rdate,  word, adminno
                  FROM notice
                  WHERE noticeno=1 AND word LIKE '%공%'
                  ORDER BY noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;

/**********************************/
/* Table Name: 상품 */
/**********************************/
CREATE TABLE prodno(


		prodno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE prodno is '상품';
COMMENT ON COLUMN prodno.prodno is '상품 번호';



