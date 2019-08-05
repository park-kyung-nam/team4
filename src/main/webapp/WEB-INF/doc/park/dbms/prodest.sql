CREATE TABLE customer(
    customerno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(90)     NOT NULL,
    id                                VARCHAR2(200)    NOT NULL,
    passwd                            VARCHAR2(500)     NOT NULL,
    zipcode                           VARCHAR2(20)     NULL ,
    address                           VARCHAR2(2000)     NULL ,
    address2                          VARCHAR2(2000)     NULL ,
    phone1                            VARCHAR2(20)     NOT NULL,
    phone2                            VARCHAR2(20)     NULL ,
    email                             VARCHAR2(200)    NOT NULL,
    notifemail                        CHAR(1)    DEFAULT 'Y'     NOT NULL,
    notifphone                        CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                             DATE     NOT NULL,
    ddate                             DATE     NULL ,
    bdate                             DATE     NULL ,
    customerstatscodeno                 NUMBER(10)     not NULL ,
  FOREIGN KEY (customerstatscodeno) REFERENCES customerstatscode (customerstatscodeno)
);

COMMENT ON TABLE customer is '회원';
COMMENT ON COLUMN customer.customerno is '회원 번호';
COMMENT ON COLUMN customer.name is '이름';
COMMENT ON COLUMN customer.id is '아이디!중복불가';
COMMENT ON COLUMN customer.passwd is '비밀번호';
COMMENT ON COLUMN customer.zipcode is '우편번호';
COMMENT ON COLUMN customer.address is '주소';
COMMENT ON COLUMN customer.address2 is '상세주소';
COMMENT ON COLUMN customer.phone1 is '전화번호';
COMMENT ON COLUMN customer.phone2 is '전화번호2';
COMMENT ON COLUMN customer.email is '이메일!중복불가';
COMMENT ON COLUMN customer.notifemail is '이메일 수신';
COMMENT ON COLUMN customer.notifphone is '전화 수신';
COMMENT ON COLUMN customer.rdate is '가입일';
COMMENT ON COLUMN customer.ddate is '탈퇴일';
COMMENT ON COLUMN customer.customerstatscodeno is '회원 상태 코드';

--2. 등록

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values(1,'나나','nana@demo.io','demo',1, '서울시','01012341234',null,'nana@demo.io','Y','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values(2,'루루','lulu@demo.io','demo',1, '성남시','01012125566',null,'lulu@demo.io','N','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values(3,'하루','haru@demo.io','demo',1, '수원시','01066536864',null,'nana@demo.io','Y','Y',sysdate,null);

DELETE FROM customer;

DROP TABLE cutomer;


/**********************************/
/* Table Name: Table4 */
/**********************************/

DROP TABLE prodest;

CREATE TABLE prodest(
    prodestno                         NUMBER(10)                     NOT NULL    PRIMARY KEY,
    productno                         NUMBER(10)                             NULL ,
    customerno                       NUMBER(10)                             NULL ,
    prodest_cnt                       NUMBER(10)    DEFAULT 1  NOT NULL,
    prodest_total                     NUMBER(10)    DEFAULT 0  NOT NULL,

  FOREIGN KEY (productno) REFERENCES product (productno),
  FOREIGN KEY (customerno) REFERENCES customer (customerno)
);

COMMENT ON COLUMN prodest.prodestno is '제품견적번호';
COMMENT ON COLUMN prodest.prodno is '제품번호';
COMMENT ON COLUMN prodest.customerno is '회원 번호';

select * from prodest;
select * from product;
select * from prodcate;
select * from customer;

delete from prodest;

delete from prodest
where productno = 2;

insert into prodest(prodestno, productno, customerno)
values((SELECT NVL(MAX(prodestno), 0) + 1 as prodestno FROM prodest), 2, 1);

SELECT prodestno, productno, customerno, prodest_cnt, prodest_total
    FROM prodest
    WHERE customerno = 4;
    
SELECT COUNT(*)
    FROM prodest e, product p
    WHERE e.customerno = 1 AND e.productno = p.productno AND p.productno = 2;

SELECT e.prodestno, e.productno, e.customerno, pc.prodcate_title, p.prod_title, e.prodest_cnt, e.prodest_total
FROM prodest e, product p, prodcate pc, customer c
WHERE e.prodestno = 1 AND c.customerno = e.customerno 
           AND e.productno = p.productno AND p.prodcateno = pc.prodcateno;
           
SELECT e.prodestno, e.productno, e.customerno, pc.prodcate_title, p.prod_title
    FROM prodest e, product p, prodcate pc, customer c
    WHERE e.customerno = 1 AND c.customerno = e.customerno
               AND e.productno = p.productno AND p.prodcateno = pc.prodcateno
               
SELECT e.prodestno, e.productno, e.customerno, pc.prodcate_title, p.prod_title
FROM prodest e, product p, prodcate pc, customer c
WHERE c.customerno = e.customerno AND e.productno = p.productno
         AND p.prodcateno = pc.prodcateno;

      
UPDATE prodest 
SET prodest_cnt = prodest_cnt + 1
WHERE prodestno = 1;

SELECT prodest_cnt
FROM prodest
WHERE prodestno = 1;

DELETE FROM prodest
WHERE prodestno=1;

