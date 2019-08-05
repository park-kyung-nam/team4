/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		member_no NUMERIC(10) PRIMARY KEY
);

/**********************************/
/* Table Name: 주문상품정보 */
/**********************************/
CREATE TABLE product(
		order_no NUMERIC(20) PRIMARY KEY,
		order VARCHAR(200),
		product_name VARCHAR(200),
		product_price NUMERIC(20),
		product_cnt NUMERIC(10),
		product_no NUMERIC(10),
		total_cnt NUMERIC(10),
		total_price NUMERIC(20),
		point NUMERIC(20),
		memberno NUMERIC(10)
);

/**********************************/
/* Table Name: 배송정보 */
/**********************************/
CREATE TABLE delivery(
		delivery_no NUMERIC(20) PRIMARY KEY,
		member_no NUMERIC(10),
		recipient VARCHAR(200),
		address VARCHAR(200),
		phone NUMERIC(20),
		requests VARCHAR(500),
		order_no NUMERIC(20),
  FOREIGN KEY (order_no) REFERENCES product (order_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

/**********************************/
/* Table Name: 결제 */
/**********************************/
CREATE TABLE payment(
		payment_no NUMERIC(20) PRIMARY KEY,
		cash NUMERIC(30),
		card NUMERIC(30),
		point NUMERIC(30),
		phone NUMERIC(30),
		order_no NUMERIC(20),
  FOREIGN KEY (order_no) REFERENCES product (order_no)
);

/**********************************/
/* Table Name: 고객센터 */
/**********************************/
CREATE TABLE ServiceCenter(
		question_no NUMERIC(10) PRIMARY KEY,
		member_no NUMERIC(10),
		title VARCHAR(10),
		contents VARCHAR(10),
		visible VARCHAR(1),
		seqno NUMERIC(10),
		cnt NUMERIC(10),
		rdate DATE,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

INSERT  INTO ServiceCenter(question_no, 
                            member_no, title, contents, 
                            visible, seqno, cnt, rdate)
VALUES ((SELECT NVL(MAX(question_no), 0) +1 AS question_no FROM ServiceCenter),
                 1, 'title', 'contents',
                  'Y', 1, 'cnt', sysdate);

/**********************************/
/* Table Name: 고객센터 댓글 */
/**********************************/
CREATE TABLE ServiceCenter_reply(
		reply_no NUMERIC(10) PRIMARY KEY,
		reply_content VARCHAR(10),
		reply_rdate DATE,
		question_no NUMERIC(10),
  FOREIGN KEY (question_no) REFERENCES ServiceCenter (question_no)
);

