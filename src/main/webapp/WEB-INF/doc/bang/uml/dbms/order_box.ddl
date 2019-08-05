SELECT *
FROM orderBox;

DROP TABLE customer;
DROP TABLE orderBox;
DROP TABLE orderMain;
DROP TABLE productgrp;

/**********************************/
/* Table Name: 상품 */
/**********************************/ 
CREATE TABLE productgrp(
		productno                     		NUMBER(10)		 NULL 		 PRIMARY KEY,
		productName						VARCHAR2(100),
		productPrice 						NUMBER(10),
		productImg							VARCHAR2(500)
);

COMMENT ON TABLE productgrp is '상품';  
COMMENT ON COLUMN productgrp.productno is '상품번호';

      /* 컬럼 추가 */
ALTER TABLE productgrp ADD (productName varchar2(100));
ALTER TABLE productgrp ADD (productPrice number(10));
ALTER TABLE productgrp ADD (productImg varchar2(500));


--임시 데이터 입력
INSERT INTO productgrp(productno) VALUES (1);
INSERT INTO productgrp(productno) VALUES (2);
INSERT INTO productgrp(productno) VALUES (3);

--데이터 삭제
DELETE FROM productgrp
WHERE productno = 1;

--데이터 수정
UPDATE productgrp
SET productName='I9-9900k'
WHERE productno =1;

--상품 임시데이터 확인
SELECT  
productno, productName, productPrice, productImg 
FROM productgrp;

 PRODUCTNO
 ---------
         1
         2
         3
         
/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE customer(
		customerName			varchar2(20)			NULL,	
		customerno                      		NUMBER(10)		 NULL 		 PRIMARY KEY
);

      /* 컬럼 추가 */
ALTER TABLE customer ADD (customerName varchar2(20));


COMMENT ON TABLE customer is '회원';
COMMENT ON COLUMN customer.customerno is '회원번호';

--임시 데이터 입력
INSERT INTO customer(customerno, customerName) VALUES (4, '사람1');
INSERT INTO customer(customerno, customerName) VALUES (5, '회원1');
INSERT INTO customer(customerno, customerName) VALUES (6, '회원2');

SELECT customerno, customerName FROM customer;

--- 임시데이터 삭제
DELETE FROM customer
WHERE customerno=1;

 CUSTOMERNO
 ----------
          1
          2
          3

/**********************************/
/* Table Name: 주문 */
/**********************************/
          
         /* 컬럼 추가 */
ALTER TABLE orderMain ADD (phoneno varchar2(20));

ALTER TABLE orderMain ADD (customerName varchar2(20));

/* 컬럼 수정 */
ALTER TABLE orderMain MODIFY (phoneno VARCHAR2(100));
 
DROP table orderMain
CREATE TABLE orderMain(
		orderno                       		NUMBER(10)		 NULL 		 PRIMARY KEY,
		productno                     		NUMBER(10)		 NULL ,
		customerno                      	NUMBER(10)		 NULL ,
		orderName                     		VARCHAR2(50)		 NULL ,
		customerName                 VARCHAR2(50)    NULL ,
		zipCode                       		VARCHAR2(30)		 NULL ,
		orderAddr1                    		VARCHAR2(100)		 NULL ,
		orderAddr2                    		VARCHAR2(50)		 NULL ,
		orderDate                     		DATE		 NULL ,
		point                         		NUMBER(10)		 NULL ,
		phoneno							VARCHAR2(100)      NULL,
  FOREIGN KEY (productno) REFERENCES product (productno),
  FOREIGN KEY (customerno) REFERENCES customer (customerno)
);

COMMENT ON TABLE orderMain is '주문';
COMMENT ON COLUMN orderMain.orderno is '주문번호';
COMMENT ON COLUMN orderMain.productno is '상품번호';
COMMENT ON COLUMN orderMain.customerno is '회원번호';
COMMENT ON COLUMN orderMain.orderName is '수취인';
COMMENT ON COLUMN orderMain.zipCode is '우편번호';
COMMENT ON COLUMN orderMain.orderAddr1 is '주소';
COMMENT ON COLUMN orderMain.orderAddr2 is '상세주소';
COMMENT ON COLUMN orderMain.orderDate is '주문일';
COMMENT ON COLUMN orderMain.point is '포인트';
COMMENT ON COLUMN orderMain.phoneno is '전화번호';
COMMENT ON COLUMN orderMain.customerName is '회원이름';


----------주문 등록 -------------
INSERT INTO orderMain(orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno, customerName)
VALUES ((SELECT NVL(max(orderno), 0) +1 as orderno from orderMain), 1, 1, '구매자1', '456-1112',
			'경기도 시흥시', 'oo아파트', sysdate, 1, 010-0000-0000, '회원1');

INSERT INTO orderMain(orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno)
VALUES ((SELECT NVL(max(orderno), 0) +1 as orderno from orderMain), 1, 2, '구매자1', '456-1112',
			'서울특별시', '종로코아빌딩' , sysdate, 1, 010-0000-0000, '회원2');
			
INSERT INTO orderMain(orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno)
VALUES ((SELECT NVL(max(orderno), 0) +1 as orderno from orderMain), 1, 3, '구매자1', '456-1112',
			'서울특별시', '종로코아 5층' , sysdate, 1, 010-0000-0000, '회원3');

			
-------- 주문 목록 ------------
SELECT orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno, customerName
FROM orderMain
ORDER BY orderno ASC;

 ORDERNO PRODUCTNO CUSTOMERNO ORDERNAME ZIPCODE  ORDERADDR1 ORDERADDR2 ORDERDATE             POINT
 ------- --------- ---------- --------- -------- ---------- ---------- --------------------- -----
       1         1          1 구매자1      456-1112 경기도 시흥시    oo아파트      2019-05-30 10:40:22.0     1
       2         1          1 구매자1      456-1112 서울특별시      종로코아빌딩     2019-05-30 10:40:51.0     1
       3         1          1 구매자1      456-1112 서울특별시      종로코아 5층    2019-05-30 10:41:59.0     1

			
------ JOIN
------ orderMain, customer, productgrp
SELECT o.orderno, o.productno as productno, o.customerno as customerno, o.orderName, o.zipCode,
		  o.orderAddr1, o.orderAddr2, o.orderDate, o.point,
		  c.customerno,
		  p.productno
FROM orderMain o, customer c, productgrp p 
WHERE o.orderno = c.customerno AND o.orderno = p.productno
ORDER BY c.customerno ASC;
		  
 ORDERNO PPRODUCTNO CCUSTOMERNO ORDERNAME ZIPCODE  ORDERADDR1 ORDERADDR2 ORDERDATE             POINT CUSTOMERNO PRODUCTNO
 ------- ---------- ----------- --------- -------- ---------- ---------- --------------------- ----- ---------- ---------
       1          1           1 구매자1      456-1112 경기도 시흥시    oo아파트      2019-05-30 10:40:22.0     1          1         1
       3          1           1 구매자1      456-1112 서울특별시      종로코아 5층    2019-05-30 10:41:59.0     1          3         3
       2          1           1 구매자1      456-1112 서울특별시      종로코아빌딩     2019-05-30 10:40:51.0     1          2         2

       
------ 주문 조회
SELECT orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, customerName
FROM orderMain
WHERE customerno=2;
       
 ORDERNO PRODUCTNO CUSTOMERNO ORDERNAME ZIPCODE  ORDERADDR1 ORDERADDR2 ORDERDATE            
 ------- --------- ---------- --------- -------- ---------- ---------- --------------------- -----
       1         1          1 구매자1      456-1112 경기도 시흥시    oo아파트      2019-05-30 10:40:22.0     

       
----- 주문 수정
UPDATE orderMain
SET orderName='구매자3', zipCode='123-4567', orderAddr1='서울특별시',
	  orderAddr2='종로코아'
WHERE orderno=12;

 ORDERNO PRODUCTNO CUSTOMERNO ORDERNAME ZIPCODE  ORDERADDR1 ORDERADDR2 ORDERDATE             POINT
 ------- --------- ---------- --------- -------- ---------- ---------- --------------------- -----
       1         1          1 구매자3      123-4567 서울특별시      종로코아       2019-05-30 10:40:22.0     1

       
------ 주문 삭제
DELETE FROM orderMain
WHERE orderno=2;
      


DROP TABLE orderBox;
/**********************************/
/* Table Name: 장바구니 */
/**********************************/
CREATE TABLE orderBox(
		orderBoxno                    		NUMBER(10)		 NULL 		 PRIMARY KEY,
		productno                     		NUMBER(10)		  NULL ,
		customerno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (productno) REFERENCES product (productno),
  FOREIGN KEY (customerno) REFERENCES customer (customerno) 
);

COMMENT ON TABLE orderBox is '장바구니';
COMMENT ON COLUMN orderBox.orderBoxno is '장바구니번호';
COMMENT ON COLUMN orderBox.productno is '상품번호';
COMMENT ON COLUMN orderBox.customerno is '회원번호';

-------------장바구니 등록-----------------
INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 1, 1, 1);

INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 2, 1, 1);

INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 3, 1, 2);

INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 3, 2, 2);


-------- 장바구니 목록 ------------
SELECT orderBoxno, productno, customerno, orderAmount
FROM orderBox
ORDER BY orderBoxno ASC;

 ORDERBOXNO PRODUCTNO CUSTOMERNO ORDERAMOUNT
 ---------- --------- ---------- -----------
          1         1          1           1
          2         2          1           1
          3         3          1           2
          4         3          2           2


------ 회원 장바구니 조회
SELECT orderBoxno, productno, customerno, orderAmount
FROM orderBox
WHERE customerno=1;

 ORDERBOXNO PRODUCTNO CUSTOMERNO ORDERAMOUNT
 ---------- --------- ---------- -----------
          1         1          1           1
          2         2          1           1

          

--- 상품수량 설정
UPDATE orderBox
SET orderAmount=5
WHERE customerno=1 AND orderBoxno=14;

--- 확인
SELECT  orderBoxno, productno, customerno, orderAmount
FROM orderBox
WHERE customerno=1;

--- 장바구니 삭제
DELETE FROM orderBox 
WHERE orderBoxno = 1;

--- 전체 삭제
DELETE FROM orderBox
WHERE customerno=1;

-- 장바구니 금액 합계
SELECT NVL(SUM(productPrice * orderAmount), 0) money
FROM orderBox b, productgrp p
WHERE b.productno = p.productno AND b.customerno = 1;

-- join 장바구니 목록(customerno)
SELECT 
		  b.orderBoxno as orderBoxno,
		  b.customerno as customerno,
		  p.productno as productno,
		  c.customerName as customerName,
		  p.productName as productName,
		  b.orderAmount,
		  p.productImg as productImg,
		  p.productPrice as productPrice,
		  (productPrice * orderAmount) money
FROM
		  orderBox b, productgrp p, customer c
WHERE 
		  c.customerno = b.customerno AND
		  p.productno = b.productno AND
		  b.customerno = 1
ORDER BY 
		  b.orderBoxno;

 
-- 장바구니 읽기(orderBoxno)
SELECT 
		  b.orderBoxno as orderBoxno,
		  b.customerno as customerno,
		  p.productno as productno,
		  c.customerName as customerName,
		  p.productName as productName,
		  b.orderAmount,
		  p.productImg as productImg,
		  p.productPrice as productPrice,
		  (productPrice * orderAmount) money
FROM
		  orderBox b, productgrp p, customer c
WHERE 
		  c.customerno = b.customerno AND
		  p.productno = b.productno AND
		  b.orderBoxno = 13
ORDER BY 
		  b.orderBoxno;

		  
-- 동일한 상품에 대해 합산 
SELECT COUNT(*)
FROM orderBox
WHERE customerno = 1 AND
		  productno = 1;


-- 장바구니에 동일한 상품이 들어갈 경우 수정
UPDATE orderBox
SET orderAmount = orderAmount + 1
WHERE customerno = 1
	AND productno = 1;

	
SELECT orderBoxno, productno, orderAmount
FROM orderBox
WHERE customerno = 1 AND productno = 1;

   SELECT o.orderno, o.productno, o.customerno, o.orderName, o.zipCode,
           o.orderAddr1, o.orderAddr2, o.orderDate, o.point, o.phoneno, o.customerName,
           p.prod_title, p.prod_price
   FROM orderMain o, product p
   ORDER BY customerno=4;

SELECT o.orderno, o.productno, o.customerno, o.orderName, o.zipCode,
           o.orderAddr1, o.orderAddr2, o.orderDate, o.point, o.phoneno, o.customerName,
           p.prod_title, p.prod_price
FROM orderMain o, product p
WHERE customerno=4;
		  
