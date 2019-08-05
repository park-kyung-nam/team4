SELECT *
FROM orderBox;

DROP TABLE customer;
DROP TABLE orderBox;
DROP TABLE orderMain;
DROP TABLE productgrp;

/**********************************/
/* Table Name: ��ǰ */
/**********************************/ 
CREATE TABLE productgrp(
		productno                     		NUMBER(10)		 NULL 		 PRIMARY KEY,
		productName						VARCHAR2(100),
		productPrice 						NUMBER(10),
		productImg							VARCHAR2(500)
);

COMMENT ON TABLE productgrp is '��ǰ';  
COMMENT ON COLUMN productgrp.productno is '��ǰ��ȣ';

      /* �÷� �߰� */
ALTER TABLE productgrp ADD (productName varchar2(100));
ALTER TABLE productgrp ADD (productPrice number(10));
ALTER TABLE productgrp ADD (productImg varchar2(500));


--�ӽ� ������ �Է�
INSERT INTO productgrp(productno) VALUES (1);
INSERT INTO productgrp(productno) VALUES (2);
INSERT INTO productgrp(productno) VALUES (3);

--������ ����
DELETE FROM productgrp
WHERE productno = 1;

--������ ����
UPDATE productgrp
SET productName='I9-9900k'
WHERE productno =1;

--��ǰ �ӽõ����� Ȯ��
SELECT  
productno, productName, productPrice, productImg 
FROM productgrp;

 PRODUCTNO
 ---------
         1
         2
         3
         
/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE customer(
		customerName			varchar2(20)			NULL,	
		customerno                      		NUMBER(10)		 NULL 		 PRIMARY KEY
);

      /* �÷� �߰� */
ALTER TABLE customer ADD (customerName varchar2(20));


COMMENT ON TABLE customer is 'ȸ��';
COMMENT ON COLUMN customer.customerno is 'ȸ����ȣ';

--�ӽ� ������ �Է�
INSERT INTO customer(customerno, customerName) VALUES (4, '���1');
INSERT INTO customer(customerno, customerName) VALUES (5, 'ȸ��1');
INSERT INTO customer(customerno, customerName) VALUES (6, 'ȸ��2');

SELECT customerno, customerName FROM customer;

--- �ӽõ����� ����
DELETE FROM customer
WHERE customerno=1;

 CUSTOMERNO
 ----------
          1
          2
          3

/**********************************/
/* Table Name: �ֹ� */
/**********************************/
          
         /* �÷� �߰� */
ALTER TABLE orderMain ADD (phoneno varchar2(20));

ALTER TABLE orderMain ADD (customerName varchar2(20));

/* �÷� ���� */
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

COMMENT ON TABLE orderMain is '�ֹ�';
COMMENT ON COLUMN orderMain.orderno is '�ֹ���ȣ';
COMMENT ON COLUMN orderMain.productno is '��ǰ��ȣ';
COMMENT ON COLUMN orderMain.customerno is 'ȸ����ȣ';
COMMENT ON COLUMN orderMain.orderName is '������';
COMMENT ON COLUMN orderMain.zipCode is '�����ȣ';
COMMENT ON COLUMN orderMain.orderAddr1 is '�ּ�';
COMMENT ON COLUMN orderMain.orderAddr2 is '���ּ�';
COMMENT ON COLUMN orderMain.orderDate is '�ֹ���';
COMMENT ON COLUMN orderMain.point is '����Ʈ';
COMMENT ON COLUMN orderMain.phoneno is '��ȭ��ȣ';
COMMENT ON COLUMN orderMain.customerName is 'ȸ���̸�';


----------�ֹ� ��� -------------
INSERT INTO orderMain(orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno, customerName)
VALUES ((SELECT NVL(max(orderno), 0) +1 as orderno from orderMain), 1, 1, '������1', '456-1112',
			'��⵵ �����', 'oo����Ʈ', sysdate, 1, 010-0000-0000, 'ȸ��1');

INSERT INTO orderMain(orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno)
VALUES ((SELECT NVL(max(orderno), 0) +1 as orderno from orderMain), 1, 2, '������1', '456-1112',
			'����Ư����', '�����ھƺ���' , sysdate, 1, 010-0000-0000, 'ȸ��2');
			
INSERT INTO orderMain(orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno)
VALUES ((SELECT NVL(max(orderno), 0) +1 as orderno from orderMain), 1, 3, '������1', '456-1112',
			'����Ư����', '�����ھ� 5��' , sysdate, 1, 010-0000-0000, 'ȸ��3');

			
-------- �ֹ� ��� ------------
SELECT orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, point, phoneno, customerName
FROM orderMain
ORDER BY orderno ASC;

 ORDERNO PRODUCTNO CUSTOMERNO ORDERNAME ZIPCODE  ORDERADDR1 ORDERADDR2 ORDERDATE             POINT
 ------- --------- ---------- --------- -------- ---------- ---------- --------------------- -----
       1         1          1 ������1      456-1112 ��⵵ �����    oo����Ʈ      2019-05-30 10:40:22.0     1
       2         1          1 ������1      456-1112 ����Ư����      �����ھƺ���     2019-05-30 10:40:51.0     1
       3         1          1 ������1      456-1112 ����Ư����      �����ھ� 5��    2019-05-30 10:41:59.0     1

			
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
       1          1           1 ������1      456-1112 ��⵵ �����    oo����Ʈ      2019-05-30 10:40:22.0     1          1         1
       3          1           1 ������1      456-1112 ����Ư����      �����ھ� 5��    2019-05-30 10:41:59.0     1          3         3
       2          1           1 ������1      456-1112 ����Ư����      �����ھƺ���     2019-05-30 10:40:51.0     1          2         2

       
------ �ֹ� ��ȸ
SELECT orderno, productno, customerno, orderName, zipCode,
								orderAddr1, orderAddr2, orderDate, customerName
FROM orderMain
WHERE customerno=2;
       
 ORDERNO PRODUCTNO CUSTOMERNO ORDERNAME ZIPCODE  ORDERADDR1 ORDERADDR2 ORDERDATE            
 ------- --------- ---------- --------- -------- ---------- ---------- --------------------- -----
       1         1          1 ������1      456-1112 ��⵵ �����    oo����Ʈ      2019-05-30 10:40:22.0     

       
----- �ֹ� ����
UPDATE orderMain
SET orderName='������3', zipCode='123-4567', orderAddr1='����Ư����',
	  orderAddr2='�����ھ�'
WHERE orderno=12;

 ORDERNO PRODUCTNO CUSTOMERNO ORDERNAME ZIPCODE  ORDERADDR1 ORDERADDR2 ORDERDATE             POINT
 ------- --------- ---------- --------- -------- ---------- ---------- --------------------- -----
       1         1          1 ������3      123-4567 ����Ư����      �����ھ�       2019-05-30 10:40:22.0     1

       
------ �ֹ� ����
DELETE FROM orderMain
WHERE orderno=2;
      


DROP TABLE orderBox;
/**********************************/
/* Table Name: ��ٱ��� */
/**********************************/
CREATE TABLE orderBox(
		orderBoxno                    		NUMBER(10)		 NULL 		 PRIMARY KEY,
		productno                     		NUMBER(10)		  NULL ,
		customerno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (productno) REFERENCES product (productno),
  FOREIGN KEY (customerno) REFERENCES customer (customerno) 
);

COMMENT ON TABLE orderBox is '��ٱ���';
COMMENT ON COLUMN orderBox.orderBoxno is '��ٱ��Ϲ�ȣ';
COMMENT ON COLUMN orderBox.productno is '��ǰ��ȣ';
COMMENT ON COLUMN orderBox.customerno is 'ȸ����ȣ';

-------------��ٱ��� ���-----------------
INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 1, 1, 1);

INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 2, 1, 1);

INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 3, 1, 2);

INSERT INTO orderBox(orderBoxno, productno, customerno, orderAmount)
VALUES ((SELECT NVL(max(orderBoxno), 0) +1 as orderBoxno from orderBox), 3, 2, 2);


-------- ��ٱ��� ��� ------------
SELECT orderBoxno, productno, customerno, orderAmount
FROM orderBox
ORDER BY orderBoxno ASC;

 ORDERBOXNO PRODUCTNO CUSTOMERNO ORDERAMOUNT
 ---------- --------- ---------- -----------
          1         1          1           1
          2         2          1           1
          3         3          1           2
          4         3          2           2


------ ȸ�� ��ٱ��� ��ȸ
SELECT orderBoxno, productno, customerno, orderAmount
FROM orderBox
WHERE customerno=1;

 ORDERBOXNO PRODUCTNO CUSTOMERNO ORDERAMOUNT
 ---------- --------- ---------- -----------
          1         1          1           1
          2         2          1           1

          

--- ��ǰ���� ����
UPDATE orderBox
SET orderAmount=5
WHERE customerno=1 AND orderBoxno=14;

--- Ȯ��
SELECT  orderBoxno, productno, customerno, orderAmount
FROM orderBox
WHERE customerno=1;

--- ��ٱ��� ����
DELETE FROM orderBox 
WHERE orderBoxno = 1;

--- ��ü ����
DELETE FROM orderBox
WHERE customerno=1;

-- ��ٱ��� �ݾ� �հ�
SELECT NVL(SUM(productPrice * orderAmount), 0) money
FROM orderBox b, productgrp p
WHERE b.productno = p.productno AND b.customerno = 1;

-- join ��ٱ��� ���(customerno)
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

 
-- ��ٱ��� �б�(orderBoxno)
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

		  
-- ������ ��ǰ�� ���� �ջ� 
SELECT COUNT(*)
FROM orderBox
WHERE customerno = 1 AND
		  productno = 1;


-- ��ٱ��Ͽ� ������ ��ǰ�� �� ��� ����
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
		  
