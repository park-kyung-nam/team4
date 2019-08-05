
/**********************************/
/* Table Name: 관리자 권한 코드 */
/**********************************/
CREATE TABLE admincode(
    admincodeno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    privchar                          VARCHAR2(10)     NOT NULL,
    privdesc                          CLOB     NOT NULL,
    privclass           CLOB default 'btn-secondary' null
);

COMMENT ON TABLE admincode is '관리자 권한 코드';
COMMENT ON COLUMN admincode.admincodeno is '관리자 코드';
COMMENT ON COLUMN admincode.privchar is '관리자 권한 약어';
COMMENT ON COLUMN admincode.privdesc is '관리자 권한 설명';
COMMENT ON COLUMN admincode.privclass is '관리자 권한 색상';

--관리자 상태 및 권한 : 총괄 관리자만 설정 가능
--0 : 총괄 관리자
--양수 : 권한
--음수 : 상태


--2. 추가

insert into admincode
(admincodeno, privchar, privdesc)
values(
  0, 'Master','총괄 관리자');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Admin','관리자');
  
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Product','상품 관리자');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Event','이벤트 관리자');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Co-op','협력사');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Cust','개인정보 보호 담당자');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -1,'Pwdreset','비밀번호 재설정 필요');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -2,'Pending','승인 대기');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -8,'Dereg','탈퇴');

--3. 조회
--순서는 사용하지 않음

select admincodeno, privchar, privdesc
from admincode;

--사용 가능
    select admincodeno, privchar, privdesc
    from admincode
    where admincodeno > 0
    
ADMINCODENO PRIVCHAR PRIVDESC
 ----------- -------- --------
           1 Admin    관리자
           2 Product  상품 관리자
           3 Event    이벤트 관리자

--사용 불가
    select admincodeno, privchar, privdesc
    from admincode
    where admincodeno < 0
    
 ADMINCODENO PRIVCHAR PRIVDESC
 ----------- -------- -----------
          -8 Dereg    탈퇴
          -2 Pending  승인 대기
          -1 Pwdreset 비밀번호 재설정 필요



--4. 특정 레코드 조회(사용하지 않음)

--5. 수정(사용하지 않음)

--6. 삭제(사용하지 않음, 사용 시 관리자 등급 및 상태 변경)
update admin
set admincodeno = 1
where admincodeno = xyz;

delete from admincode
where admincodeno = xyz;

--7. 페이징/검색(사용하지 않음. 코드 특성 상 한 페이지 안에 모든 코드가 들어가 있어야 됨)




/**********************************/
/* Table Name: 관리자 */
/**********************************/

SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH, NULLABLE FROM USER_TAB_COLUMNS WHERE TABLE_NAME='admin' ORDER BY COLUMN_ID;

drop table admin

CREATE TABLE admin(
    adminno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(90)     NOT NULL,
    id                                VARCHAR2(200)  unique  NOT NULL,
    passwd                             VARCHAR2(1000)     NOT NULL,
    img                               varchar2(200) default 'bioimg_unset.png' null,
    profileimg                        varchar2(200) default 'unset.gif' null,
    admincodeno                       NUMBER(10)  default -2  not NULL ,
    address                           CLOB     NOT NULL,
    phone1                            VARCHAR2(20)     NOT NULL,
    phone2                            VARCHAR2(20)     NULL ,
    email                             VARCHAR2(200)  unique  NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (admincodeno) REFERENCES admincode (admincodeno)
);

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.adminno is '관리자 번호';
COMMENT ON COLUMN admin.name is '이름';
COMMENT ON COLUMN admin.id is '아이디!중복불가';
COMMENT ON COLUMN admin.passwd is '비밀번호';
COMMENT ON COLUMN admin.admincodeno is '관리자 코드';
COMMENT ON COLUMN admin.address is '주소';
COMMENT ON COLUMN admin.phone1 is '전화번호1';
COMMENT ON COLUMN admin.phone2 is '전화번호2';
COMMENT ON COLUMN admin.email is '이메일!중복불가';
COMMENT ON COLUMN admin.rdate is '등록일';

ALTER TABLE admin ADD temp VARCHAR2(1000);
UPDATE admin
   SET temp = DBMS_LOB.SUBSTR (passwd, 1000);

ALTER TABLE admin DROP COLUMN passwd;
ALTER TABLE admin RENAME COLUMN temp TO passwd;

--총괄 관리자 추가 / 마스터 계정이므로 로그인 시 이메일을 사용하지 않음
insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(0,'리셰','richer','SpxxgFxFD6jmt0K7K6VIVg==',0, '서울시','01012341234',null,'richer@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(10,'미즈키','mizuki','9aP0BJxahiqgG7QnTC5QaQ==',5, '서울시','01012341234',null,'mizuki@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(11,'리제','rize','UWB/y3O7RxoLGCp+5pOOfQ==',2, '서울시','01012341234',null,'rize@demo.io',sysdate);

--탈퇴 상태 관리자 추가 / 리스트 보존용 탈퇴 상태 관리자
insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(-1,'탈퇴된 회원','removed account','removed account',-8, '-','-',null,'-',sysdate);

--일반 관리자 추가 or 가입(상태는 입력하지 않음)
insert into admin
(adminno, name, id, passwd, address, phone1, phone2, email, rdate)
values((SELECT NVL(MAX(adminno), 0) + 1 as adminno FROM admin),'리라','rira@demo.io','demo', '서울시','01012341234',null,'rira@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, address, phone1, phone2, email, rdate)
values((SELECT NVL(MAX(adminno), 0) + 1 as adminno FROM admin),'시엘','ciel@demo.io','demo', '고양시','01055334676',null,'ciel@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, address, phone1, phone2, email, rdate)
values((SELECT NVL(MAX(adminno), 0) + 1 as adminno FROM admin),'코론','coron@demo.io','demo', '남양주시','01098334948',null,'coron@demo.io',sysdate);

--목록
--비밀번호는 조회하지 않음
select * from admin;

select adminno, name, id, img, profileimg, admincodeno, address, phone1, phone2, email, rdate
from admin
order by adminno desc;

 ADMINNO NAME ID            PASSWD    ADMINCODENO ADDRESS PHONE1      PHONE2 EMAIL          RDATE
 ------- ---- ------------- --------- ----------- ------- ----------- ------ -------------- ---------------------
       3 코론   coron@demo.io demo               -2 남양주시    01098334948 NULL   coron@demo.io  2019-05-15 18:22:11.0
       2 시엘   ciel@demo.io  demo               -2 고양시     01055334676 NULL   ciel@demo.io   2019-05-15 18:22:10.0
       1 리라   rira@demo.io  demo               -2 서울시     01012341234 NULL   rira@demo.io   2019-05-15 18:22:09.0
       0 리셰   richer        caramella           0 서울시     01012341234 NULL   richer@demo.io 2019-05-15 18:20:43.0


--특정 관리자 조회
       
select adminno, name, id, img, profileimg, admincodeno, address, phone1, phone2, email, rdate
from admin
where adminno = 0;
       
 ADMINNO NAME ID     PASSWD    ADMINCODENO ADDRESS PHONE1      PHONE2 EMAIL          RDATE
 ------- ---- ------ --------- ----------- ------- ----------- ------ -------------- ---------------------
       0 리셰   richer caramella           0 서울시     01012341234 NULL   richer@demo.io 2019-05-15 18:20:43.0

--관리자 정보 수정
--자기 자신의 정보는 본인 혹은 상위 관리자가 수정 가능

update admin
set
  name='루아',
  img = '',
  profileimg = '',
  address = '광주시',
  phone1 = '01066789876',
  phone2 = '',
  email = 'lua@demo.io'

where adminno = 1;

5. 패스워드 변경
1) 패스워드 검사 
SELECT COUNT(*) as cnt
FROM admin
WHERE adminno=1 AND passwd='1234';

select adminno, passwd from admin
select mno, passwd from member where mno = 1;

 
2) 패스워드 수정
UPDATE admin
SET passwd='0000'
WHERE adminno=11;
       
--관리자 승인 및 상태 변경
--총괄 관리자 및 상위 관리자만 가능

update admin
set admincodeno = 1

where adminno = 1;


--관리자 탈퇴
--관리자 탈퇴 시 회원 상태를 '탈퇴'로 변경 후 탈퇴일 기록
--관리자의 경우 탈퇴일을 따로 작성하지 않음
--
update admin
set
  admincodeno = ?
where adminno = 8;

select * from admin
where admincodeno = -8

--8. 회원 삭제
--관리자는 상위 관리자만이 직접 삭제

DELETE FROM admin
WHERE adminno = 0;

 ADMINNO NAME
 ------- ------------
       4 12333333333
       6 아로미
       7 123
       8 admin
      10 568568658658

select adminno, name from admin
where admincodeno != -8

--9. 검색(사용하지 않음)
        

--10. 페이징(사용하지 않음)

