CREATE TABLE Member(
    member_no NUMERIC(20) PRIMARY KEY
);

INSERT  INTO Member(member_no)
VALUES (1);

SELECT member_no
FROM Member;

drop table Member CASCADE CONSTRAINT;
delete ServiceCenter;
drop table ServiceCenter CASCADE CONSTRAINT;
/**********************************/
/* Table Name: 고객센터 */
/**********************************/
CREATE TABLE ServiceCenter(
        question_no NUMERIC(10) PRIMARY KEY,
        customerno NUMERIC(10),
        title VARCHAR(100),
        contents VARCHAR(4000),
        visible VARCHAR(10),
        seqno NUMERIC(10),
        cnt NUMERIC(10),
        thumbs              VARCHAR(1000),
        files                   VARCHAR(1000),
        sizes                  VARCHAR(1000),
        rdate DATE,
  FOREIGN KEY (customerno) REFERENCES customer (customerno)
);

COMMENT ON TABLE ServiceCenter is '고객센터';
COMMENT ON COLUMN ServiceCenter.question_no is '문의번호';
COMMENT ON COLUMN ServiceCenter.member_no is '회원번호';
COMMENT ON COLUMN ServiceCenter.title is '제목';
COMMENT ON COLUMN ServiceCenter.contents is '내용';
COMMENT ON COLUMN ServiceCenter.visible is '출력선택';
COMMENT ON COLUMN ServiceCenter.seqno is '출력순서';
COMMENT ON COLUMN ServiceCenter.cnt is '자료수';
COMMENT ON COLUMN contents.thumbs is 'Thumb 파일';
COMMENT ON COLUMN contents.files is '파일들의 이름';
COMMENT ON COLUMN contents.sizes is '파일들의 크기';
COMMENT ON COLUMN ServiceCenter.rdate is '등록일';

INSERT  INTO ServiceCenter(question_no, 
                            title, contents, visible, 
                            thumbs, files, sizes, 
                            seqno, cnt, rdate)
VALUES ((SELECT NVL(MAX(question_no), 0) +1 AS question_no FROM ServiceCenter),
                 '문의합니다.', 'OOOOOOO', 'Y',
                 'fall_m.jpg', 'fall.jpg', 0,
                 2, 1, sysdate);
                 
SELECT question_no, title, contents, visible, seqno, cnt, rdate
FROM ServiceCenter
ORDER BY question_no ASC;



/**********************************/
/* Table Name: 고객센터 댓글 */
/**********************************/
delete ServiceCenter_reply;
drop table ServiceCenter_reply;


CREATE TABLE ServiceCenter_reply(
		reply_no NUMERIC(10) PRIMARY KEY,
		reply_content VARCHAR(4000),
		reply_rdate DATE,
		question_no NUMERIC(10),
  FOREIGN KEY (question_no) REFERENCES ServiceCenter (question_no)
);

COMMENT ON TABLE ServiceCenter_reply is '고객센터댓글';
COMMENT ON COLUMN ServiceCenter_reply.reply_no is '댓글번호';
COMMENT ON COLUMN ServiceCenter_reply.reply_content is '댓글내용';
COMMENT ON COLUMN ServiceCenter_reply.reply_rdate is '등록일';
COMMENT ON COLUMN ServiceCenter_reply.question_no is '문의번호';

INSERT  INTO ServiceCenter_reply(reply_no, 
                            reply_content, reply_rdate)
VALUES ((SELECT NVL(MAX(reply_no), 0) +1 AS reply_no FROM ServiceCenter_reply),
                 'OOOOO', sysdate);
                 
                 
SELECT question_no, reply_content, reply_rdate, question_no
FROM ServiceCenter_reply
ORDER BY reply_no ASC;

