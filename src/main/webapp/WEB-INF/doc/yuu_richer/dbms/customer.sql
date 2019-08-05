
/**********************************/
/* Table Name: 회원 상태 코드 */
/**********************************/
CREATE TABLE customerstatscode(
    customerstatscodeno                 NUMBER(10)     NOT NULL    PRIMARY KEY,
    customerstatschar                   VARCHAR2(30)   unique     NOT NULL,
    customerstatsdesc                   CLOB     NOT NULL
);

COMMENT ON TABLE customerstatscode is '회원 상태 코드';
COMMENT ON COLUMN customerstatscode.customerstatscodeno is '회원 상태 코드';
COMMENT ON COLUMN customerstatscode.customerstatschar is '회원 상태 약어';
COMMENT ON COLUMN customerstatscode.customerstatsdesc is '회원 상태 설명';

--2. 추가

insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Normal','일반 회원');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Unreg','탈퇴 회원');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Pwdreset','비밀번호 재설정 필요');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Pwdchangeneeded','비밀번호 재설정 권장');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Restricted','이용 제한 회원');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Normal','일반 회원');
--
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  -1, 'Unidentified','회원 코드가 삭제됨');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  -2,  'Edited','회원 정보가 관리자에 의해 수정됨');
  
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  0,
  'None2','None');

--3. 조회
--순서는 사용하지 않음

select *
from customerstatscode;

select customerstatscodeno, customerstatschar, customerstatsdesc
from customerstatscode;

 MEMBERSTATSCODENO MEMBERSTATSCHAR MEMBERSTATSDESC
 ----------------- --------------- ---------------
                 1 Normal          일반 회원
                 2 Unreg           탈퇴 회원
                 3 Pwdreset        비밀번호 재설정 필요
                 4 Pwdchangeneeded 비밀번호 재설정 권장
                 5 Restricted      이용 제한 회원


--4. 특정 레코드 조회(사용하지 않음)

--5. 수정(사용하지 않음)
update customerstatscode
set customerstatschar = 'Simple',
    customerstatsdesc = '간편 회원'
where customerstatscodeno = 1;

--6. 삭제(사용하지 않음, 사용 시 회원 등급 변경)
update customer
set customerstatscodeno = abc
where customerstatscodeno = -1;

delete from customerstatscode
where customerstatscodeno = 6;

--7. 페이징/검색(사용하지 않음. 코드 특성 상 한 페이지 안에 모든 코드가 들어가 있어야 됨)


select * from ALL_CONSTRAINTS;
/**********************************/
/* Table Name: 회원 */
/**********************************/
delete from customer

drop table customer cascade constraints;

--1. 테이블
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


--2. 아이디 중복 확인

select count(*) as cnt
from customer
where id='nana@demo.io'

--2. 이메일 중복 확인

select count(*) as cnt
from customer
where email='nana@demo.io'


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

--3. seqno 미사용 > nvl, max 사용

SELECT customerno FROM customer;
 
 MEMBERNO
 ---------------
 
SELECT MAX(customerno) FROM customer; -- 레코드가 없으면 null
 
 MAX(MEMBERNO)
 -------------
          NULL
           
SELECT MAX(customerno) + 1 FROM customer;    -- 레코드가 없으면 의미 없음, null       
           
 MAX(MEMBERNO)+1
 ---------------
            NULL
 
-- null인 컬럼의 값을 0으로 변경후 연산, NVL(컬럼명, 0): 컬럼값이 null이면 0으로 변경
SELECT NVL(MAX(customerno), 0) + 1 FROM customer;
 
 NVL(MAX(MEMBERNO),0)+1
 ----------------------
                      1
                        
-- as: 커럼 별명 지정, SELECT시에만 컬럼명 변경                       
SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer;  

 MEMBERNO
 --------
        1
        
--회원 가입(이름, 아이디, 비밀번호, 이메일, 전화번호만 입력.
 
insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values((SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer),'나나','nana@demo.io','demo',1, '서울시','01012341234',null,'nana@demo.io','Y','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values((SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer),'루루','lulu@demo.io','demo',1, '성남시','01012125566',null,'lulu@demo.io','N','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values((SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer),'하루','haru@demo.io','demo',1, '수원시','01066536864',null,'haru@demo.io','Y','Y',sysdate,null);

--4. 목록

select * from customer;

select customerno, name, id, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
order by customerno desc;

 MEMBERNO NAME ID           PASSWD MEMBERSTATSCODENO ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ----------------- ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        3 하루   haru@demo.io demo                   1 수원시     01066536864 NULL   haru@demo.io Y          Y          2019-05-14 15:20:42.0 NULL
        2 루루   lulu@demo.io demo                   1 성남시     01012125566 NULL   lulu@demo.io N          N          2019-05-14 15:20:41.0 NULL
        1 나나   nana@demo.io demo                   1 서울시     01012341234 NULL   nana@demo.io Y          N          2019-05-14 15:20:40.0 NULL


select 
s.customerstatscodeno, s.customerstatschar, s.customerstatsdesc,
c.customerno, c.name, c.id, c.customerstatscodeno,
c.address, c.phone1, c.phone2, c.email, c.notifemail, c.notifphone, c.rdate, c.ddate
from customer c, customerstatscode s
where (s.customerstatscodeno = c.customerstatscodeno)
order by c.customerno desc
        
--5. 특정 레코드 조회
select customerno, name, id, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where customerno = 3;

 MEMBERNO NAME ID           PASSWD MEMBERSTATSCODENO ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ----------------- ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        3 하루   haru@demo.io demo                   1 수원시     01066536864 NULL   haru@demo.io Y          Y          2019-05-14 15:20:42.0 NULL

--6. 회원 정보 수정
--회원 정보는 회원 본인이 수정하나 약관에 의해서 관리자가 임의로 수정할 수 있음
--이름, 아이디, 탈퇴일, 가입일은 수정하지 않음
--비밀번호는 비밀번호 찾기 실행 시에 수정

update customer
set
  address = '광주시',
  phone1 = '01066789876',
  phone2 = '',
  email = 'kei@demo.io',
  notifemail = 'N',
  notifphone = 'N',
  customerstatscodeno = 1

where customerno = 2;

select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
order by customerno desc;

 MEMBERNO NAME ID           PASSWD MEMBERSTATSCODENO ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ----------------- ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        3 하루   haru@demo.io demo                   1 수원시     01066536864 NULL   haru@demo.io Y          Y          2019-05-14 15:20:42.0 NULL
        2 루루   lulu@demo.io demo                   1 광주시     01066789876 NULL   kei@demo.io  N          N          2019-05-14 15:20:41.0 NULL
        1 나나   nana@demo.io demo                   1 서울시     01012341234 NULL   nana@demo.io Y          N          2019-05-14 15:20:40.0 NULL

--6a. 아이디 찾기
--아이디를 가입 정보에 따라 비교(이메일, 휴대전화)
select customerno, id from customer
where email='nana@demo.io';

 MEMBERNO ID
 -------- ------------
        1 nana@demo.io

select customerno, id from customer
where phone1='01066536864' or phone2='01066536864';

 MEMBERNO ID
 -------- ------------
        3 haru@demo.io
        
--6b. 비밀번호 찾기
--비밀번호 찾기를 실행 시 임의의 비밀번호로 재설정
--비밀번호 찾기를 실행한 아이디는 비밀번호를 반드시 바꾸어야만 로그인이 가능함
--pwdreset = 3
update customer
set
  passwd = 'initial',
  customerstatscodeno = 3

where customerno = 2;


--7. 회원 탈퇴(미작성)
--회원 탈퇴 시 회원 상태를 '탈퇴'로 변경 후 탈퇴일 기록
--Unreg = 2
update customer
set
  customerstatscodeno = 2,
  ddate = sysdate
where customerno = 2;

--8. 회원 삭제(미작성)
--탈퇴일을 비교하여 회원 정보 완전 삭제

DELETE FROM customer
WHERE customerno >= 6;

--9. 검색
--관리자 전용[이름, 수신 여부, 회원 상태로만 검색]
-- ex. 이름으로 검색
select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where name like '%나%';

 MEMBERNO NAME ID           PASSWD ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        1 나나   nana@demo.io demo   서울시     01012341234 NULL   nana@demo.io Y          N          2019-05-14 12:48:07.0 NULL

--이메일 수신 여부에 따라 검색
select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where notifemail='N';

--회원 상태에 따라 검색
select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where customerstatscodeno=1;
        

--10. 페이징(미작성)
--관리자 전용
select 
      customerstatscodeno, customerstatschar, customerstatsdesc,
      customerno, name, id, c_customerstatscodeno,
      address, phone1, phone2, email, notifemail, notifphone, rdate, ddate, r
    from(
      select
        customerstatscodeno, customerstatschar, customerstatsdesc,
        customerno, name, id, c_customerstatscodeno,
        address, phone1, phone2, email, notifemail, notifphone, rdate, ddate, rownum as r
      from(
        select 
          s.customerstatscodeno as customerstatscodeno, s.customerstatschar, s.customerstatsdesc,
          c.customerno, c.name, c.id, c.customerstatscodeno as c_customerstatscodeno,
          c.address, c.phone1, c.phone2, c.email, c.notifemail, c.notifphone, c.rdate, c.ddate
        from customer c, customerstatscode s
        where (s.customerstatscodeno = c.customerstatscodeno)
        order by c.customerno desc
        )
      )
      where r >=1 and f < 10

--외부 플러그인 사용













