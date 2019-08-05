/**********************************/
/* Table Name: 관리자 로그인 */
/**********************************/
--관리자 로그인 기록은 자세한 로그가 필요하기에 별도의 코드를 넣지 않음
CREATE TABLE adminlogin(
    adminloginno                      NUMBER(10)     NOT NULL    PRIMARY KEY,
    adminno                           NUMBER(10)     NULL ,
    rdate date not null,
    ipv4 varchar2(20) not null,
    --ipv6 varchar(60) null,
    result clob not null,
    
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE adminlogin is '관리자 로그인';
COMMENT ON COLUMN adminlogin.adminloginno is '관리자 로그인 기록';
COMMENT ON COLUMN adminlogin.adminno is '관리자 번호';
COMMENT ON COLUMN adminlogin.rdate is'로그인 일자';
COMMENT ON COLUMN adminlogin.result is '로그인 결과';

--등록(자동)
--로그인 결과는 구현 단계에서 자동으로 입력하도록 설정

insert into adminlogin
(adminloginno, adminno, rdate, ipv4, result)
values
((SELECT NVL(MAX(adminloginno), 0) + 1 as adminloginno FROM adminlogin), 0, sysdate, '127.0.0.1', '로그인 성공');

insert into adminlogin
(adminloginno, adminno, rdate, ipv4, result)
values
((SELECT NVL(MAX(adminloginno), 0) + 1 as adminloginno FROM adminlogin), 0, sysdate, '127.0.0.2', '의심스러운 로그인');

insert into adminlogin
(adminloginno, adminno, rdate, ipv4, result)
values
((SELECT NVL(MAX(adminloginno), 0) + 1 as adminloginno FROM adminlogin), 1, sysdate, '127.0.0.2', '로그인 10연속 실패');

--리스트 출력
select adminloginno, adminno, rdate, ipv4, result
from adminlogin;

 ADMINLOGINNO ADMINNO RDATE                 IPV4      RESULT
 ------------ ------- --------------------- --------- -----------
            1       0 2019-05-23 17:01:01.0 127.0.0.1 로그인 성공
            2       0 2019-05-23 17:01:40.0 127.0.0.2 의심스러운 로그인
            3       1 2019-05-23 17:01:41.0 127.0.0.2 로그인 10연속 실패

--조회(삭제 시에만 사용)
select adminloginno, adminno, rdate, ipv4, result
from adminlogin
where adminloginno = 1;

 ADMINLOGINNO ADMINNO RDATE                 IPV4      RESULT
 ------------ ------- --------------------- --------- ------
            1       0 2019-05-23 17:01:01.0 127.0.0.1 로그인 성공

--수정(로그 특성 상 사용하지 않음)

--삭제
delete from adminlogin
where adminloginno = 1;

--해당 관리자 데이터 삭제 시 [탈퇴한 회원]으로 변경

update adminlogin
set adminno = -1
where adminno = 22;


/**********************************/
/* Table Name: 회원 로그인 결과 코드 */
/**********************************/
--코드는 웹에서 추가 및 수정하지 않음
CREATE TABLE logincode(
    logincodeno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    resultchar                        VARCHAR2(50)     NOT NULL,
    resultdesc                        CLOB     NOT NULL
    
);

COMMENT ON TABLE logincode is '로그인 결과 코드';
COMMENT ON COLUMN logincode.logincodeno is '로그인 코드';
COMMENT ON COLUMN logincode.resultchar is '로그인 결과 약어';
COMMENT ON COLUMN logincode.resultdesc is '로그인 결과 설명';

--코드 추가

insert into logincode
(logincodeno, resultchar, resultdesc)
values(
  (SELECT NVL(MAX(logincodeno), 0) + 1 as logincodeno FROM logincode),
  'Success','로그인 성공');

insert into logincode
(logincodeno, resultchar, resultdesc)
values(
  (SELECT NVL(MAX(logincodeno), 0) + 1 as logincodeno FROM logincode),
  'Failed','로그인 실패');

--코드 목록

select logincodeno, resultchar, resultdesc
from logincode
where logincodeno > 0
order by logincodeno asc;

 LOGINCODENO RESULTCHAR RESULTDESC
 ----------- ---------- ----------
           1 Success    로그인 성공
           2 Failed     로그인 실패

--코드 선택(관리자 join 시에만 사용)

select logincodeno, resultchar, resultdesc
from logincode
where logincodeno = 1;

 LOGINCODENO RESULTCHAR RESULTDESC
 ----------- ---------- ----------
           1 Success    로그인 성공

--코드 수정(사용하지 않음)
--코드 삭제(사용하지 않음)

           

/**********************************/
/* Table Name: 회원 로그인 */
/**********************************/
CREATE TABLE loglogin(
    logloginno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    customerno                          NUMBER(10)     NULL ,
    rdate date not null,
    ipv4                              VARCHAR2(30)     NOT NULL,
  --ipv6                              VARCHAR2(60)     NOT NULL,
    logincodeno                       NUMBER(10)     NULL ,
    logindesc                          VARCHAR2(400)    NULL ,
  FOREIGN KEY (customerno) REFERENCES customer (customerno),
  FOREIGN KEY (logincodeno) REFERENCES logincode (logincodeno)
);

COMMENT ON TABLE loglogin is '회원 로그인';
COMMENT ON COLUMN loglogin.logloginno is '로그인 기록';
COMMENT ON COLUMN loglogin.customerno is '회원 번호';
COMMENT ON COLUMN loglogin.ipv4 is '로그인 아이피';
--COMMENT ON COLUMN loglogin.ipv6 is '로그인 아이피';
COMMENT ON COLUMN loglogin.logincodeno is '로그인 코드';
COMMENT ON COLUMN loglogin.logindesc is '로그인 내용';

--등록(자동)
--로그인 결과는 구현 단계에서 자동으로 입력하도록 설정

insert into loglogin
(logloginno, customerno, rdate, ipv4, logincodeno, logindesc)
values
((SELECT NVL(MAX(logloginno), 0) + 1 as logloginno FROM loglogin), 1, sysdate, '127.0.0.1', 1, '접속');

insert into loglogin
(logloginno, customerno, rdate, ipv4, logincodeno, logindesc)
values
((SELECT NVL(MAX(logloginno), 0) + 1 as logloginno FROM loglogin), 2, sysdate, '127.0.0.2', 2, '의심스러운 로그인');

insert into loglogin
(logloginno, customerno, rdate, ipv4, logincodeno, logindesc)
values
((SELECT NVL(MAX(logloginno), 0) + 1 as logloginno FROM loglogin), 1, sysdate, '127.0.0.2', '로그인 10연속 실패');

--리스트 출력
select logloginno, customerno, rdate, ipv4, logincodeno, logindesc
from loglogin
order by logloginno desc;

 LOGLOGINNO CUSTOMERNO RDATE                 IPV4      LOGINCODENO LOGINDESC
 ---------- ---------- --------------------- --------- ----------- ---------
          2          2 2019-05-23 17:24:06.0 127.0.0.2           2 의심스러운 로그인
          1          1 2019-05-23 17:24:05.0 127.0.0.1           1 접속

--조회(삭제 시에만 사용)
select logloginno, customerno, rdate, ipv4, logincodeno, logindesc
from loglogin
where logloginno = 1;


--수정(로그 특성 상 사용하지 않음)

--삭제
delete from loglogin
where logloginno = 1;

--해당 회원 정보 삭제 시 삭제

delete from loglogin
where customerno = 22;




/**********************************/
/* Table Name: 등록 결과 코드 */
/**********************************/
CREATE TABLE regcode(
    regcodeno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    regchar                           VARCHAR2(10)     NOT NULL,
    regdesc                           CLOB     NOT NULL
);

COMMENT ON TABLE regcode is '등록 결과 코드';
COMMENT ON COLUMN regcode.regcodeno is '등록 코드';
COMMENT ON COLUMN regcode.regchar is '등록 결과 약어';
COMMENT ON COLUMN regcode.regdesc is '등록 결과 설명';


--코드 추가

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'RS','상품 등록 성공');

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'RF','상품 등록 실패');

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'US','상품 수정 실패');

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'UF','상품 수정 실패');

--코드 목록

select regcodeno, regchar, regdesc
from regcode
where regcodeno > 0
order by regcodeno asc;

 REGCODENO REGCHAR REGDESC
 --------- ------- --------
         1 RS      상품 등록 성공
         2 RF      상품 등록 실패
         3 US      상품 수정 실패
         4 UF      상품 수정 실패


--코드 선택(상품 내역 join 시에만 사용)

select regcodeno, regchar, regdesc
from regcode
where regcodeno = 1;

 REGCODENO REGCHAR REGDESC
 --------- ------- --------
         1 RS      상품 등록 성공

--코드 수정(사용하지 않음)
--코드 삭제(사용하지 않음)




/**********************************/
/* Table Name: 상품 등록 내역 */
/**********************************/
CREATE TABLE prodreg(
    prodregno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    adminno                           NUMBER(10)     NULL ,
    prodno                            NUMBER(10)     NULL ,
    regcodeno                         NUMBER(10)     NULL ,
    rdate date not null,
    regdesc                           CLOB     NOT NULL,
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (prodno) REFERENCES product (prodno),
  FOREIGN KEY (regcodeno) REFERENCES regcode (regcodeno)
);

COMMENT ON TABLE prodreg is '상품 등록 내역';
COMMENT ON COLUMN prodreg.prodregno is '상품 정보 내역';
COMMENT ON COLUMN prodreg.adminno is '관리자 번호';
COMMENT ON COLUMN prodreg.prodno is '상품 번호';
COMMENT ON COLUMN prodreg.regcodeno is '등록 코드';
COMMENT ON COLUMN prodreg.rdate is '처리 날짜';
COMMENT ON COLUMN prodreg.regdesc is '자세한 설명';


--등록(자동)
--상품 처리 결과는 구현 단계에서 자동으로 입력하도록 설정

insert into prodreg
(prodregno, adminno, prodno, rdate, regcodeno, regdesc)
values
((SELECT NVL(MAX(prodregno), 0) + 1 as prodregno FROM prodreg), 1, 1, sysdate, 1, '상품 등록');

insert into prodreg
(prodregno, adminno, prodno, rdate, regcodeno, regdesc)
values
((SELECT NVL(MAX(prodregno), 0) + 1 as prodregno FROM prodreg), 2, 1, sysdate, 3, '상품 수정');

insert into prodreg
(prodregno, adminno, prodno, rdate, regcodeno, regdesc)
values
((SELECT NVL(MAX(prodregno), 0) + 1 as prodregno FROM prodreg), 1, 1, sysdate, 4, '상품 수정 실패');

--리스트 출력
select prodregno, adminno, prodno, rdate, regcodeno, regdesc
from prodreg
order by prodregno desc;

 PRODREGNO ADMINNO PRODNO RDATE                 REGCODENO REGDESC
 --------- ------- ------ --------------------- --------- --------
         3       1      1 2019-05-23 17:34:04.0         4 상품 수정 실패
         2       2      1 2019-05-23 17:34:03.0         3 상품 수정
         1       1      1 2019-05-23 17:34:02.0         1 상품 등록

--조회(삭제 시에만 사용)
select prodregno, adminno, prodno, rdate, regcodeno, regdesc
from prodreg
where prodregno = 1;

--조회(특정 상품 로그 추출이 필요한 경우)
select prodregno, adminno, prodno, rdate, regcodeno, regdesc
from prodreg
where prodno = 1
order by prodregno desc;

 PRODREGNO ADMINNO PRODNO RDATE                 REGCODENO REGDESC
 --------- ------- ------ --------------------- --------- --------
         3       1      1 2019-05-23 17:34:04.0         4 상품 수정 실패
         2       2      1 2019-05-23 17:34:03.0         3 상품 수정
         1       1      1 2019-05-23 17:34:02.0         1 상품 등록



--수정(로그 특성 상 사용하지 않음)

--삭제
delete from prodreg
where prodregno = 1;

--해당 상품 혹은 관리자 정보 삭제 시 삭제
--(삭제된 상품의 로그는 별도의 파일로 관리)

delete from prodreg
where prodno = 22;

delete from prodreg
where adminno = 1;




