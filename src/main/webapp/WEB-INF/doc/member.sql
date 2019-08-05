DROP TABLE authurlcheck CASCADE CONSTRAINTS;
DROP TABLE authurl CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE auth CASCADE CONSTRAINTS;
 
/**********************************/
/* Table Name: 권한 */
/**********************************/
CREATE TABLE auth(
authno                         NUMBER(10)  NOT NULL  PRIMARY KEY,
aname                          VARCHAR2(200)  NOT NULL
);
 
COMMENT ON TABLE auth is '권한';
COMMENT ON COLUMN auth.authno is '권한번호';
COMMENT ON COLUMN auth.aname is '권한명';
 
 
/**********************************/
/* Table Name: 회원 */
/**********************************/

CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  passwd    VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mname    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  tel          VARCHAR(14)   NOT NULL, -- 전화번호
  zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  address1  VARCHAR(80)       NULL, -- 주소 1
  address2  VARCHAR(50)       NULL, -- 주소 2
  mdate     DATE             NOT NULL, -- 가입일    
  authno                         NUMBER(10)  NOT NULL ,
  PRIMARY KEY (mno),                     -- 한번 등록된 값은 중복 안됨
  FOREIGN KEY (authno) REFERENCES auth (authno)
);


CREATE TABLE member(
memberno                       NUMBER(10)  NOT NULL  PRIMARY KEY,
id                             VARCHAR2(10)  NULL ,
authno                         NUMBER(10)  NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno)
);
 
COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원번호';
COMMENT ON COLUMN member.id is '아이디';
COMMENT ON COLUMN member.authno is '권한번호';
 
 
/**********************************/
/* Table Name: 접근주소 */
/**********************************/
CREATE TABLE authurl(
authurlno                      NUMBER(10)  NOT NULL  PRIMARY KEY,
url                            varchar2(200)  NOT NULL,
explain                        varchar2(400)  NULL 
);
 
COMMENT ON TABLE authurl is '접근주소';
COMMENT ON COLUMN authurl.authurlno is '접근주소번호';
COMMENT ON COLUMN authurl.url is '주소';
COMMENT ON COLUMN authurl.explain is '설명';
 
 
/**********************************/
/* Table Name: 인증 */
/**********************************/
CREATE TABLE authurlcheck(
authurlcheckno                 NUMBER(10)  NOT NULL  PRIMARY KEY,
authno                         NUMBER(10)  NOT NULL ,
authurlno                      NUMBER(10)  NOT NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno),
  FOREIGN KEY (authurlno) REFERENCES authurl (authurlno)
);
 
COMMENT ON TABLE authurlcheck is '인증';
COMMENT ON COLUMN authurlcheck.authurlcheckno is '주소 인증번호';
COMMENT ON COLUMN authurlcheck.authno is '권한번호';
COMMENT ON COLUMN authurlcheck.authurlno is '접근주소번호';

/**********************************/
/* Table Name: 관리자 */
/**********************************/
CREATE TABLE employee (
  employeeno  NUMBER(6) NOT NULL, -- 관리자 번호, 레코드를 구분하는 컬럼 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  passwd    VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mname    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  tel          VARCHAR(14)   NOT NULL, -- 전화번호
  zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  address1  VARCHAR(80)       NULL, -- 주소 1
  address2  VARCHAR(50)       NULL, -- 주소 2
  mdate     DATE             NOT NULL, -- 가입일
  authno    NUMBER(10)  NOT NULL, -- 권한 번호
  PRIMARY KEY (employeeno),    -- 한번 등록된 값은 중복 안됨
  FOREIGN KEY (authno) REFERENCES auth (authno)
);

COMMENT ON TABLE EMPLOYEE is '관리자 직원';
COMMENT ON COLUMN EMPLOYEE.EMPLOYEENO is '직원 번호';
COMMENT ON COLUMN EMPLOYEE.ID is '아이디';
COMMENT ON COLUMN EMPLOYEE.PASSWD is '패스워드';
COMMENT ON COLUMN EMPLOYEE.MNAME is '성명';
COMMENT ON COLUMN EMPLOYEE.TEL is '전화번호';
COMMENT ON COLUMN EMPLOYEE.ZIPCODE is '우편번호';
COMMENT ON COLUMN EMPLOYEE.ADDRESS1 is '주소1';
COMMENT ON COLUMN EMPLOYEE.ADDRESS2 is '주소2';
COMMENT ON COLUMN EMPLOYEE.MDATE is '가입일';
COMMENT ON COLUMN EMPLOYEE.AUTHNO is '권한번호';