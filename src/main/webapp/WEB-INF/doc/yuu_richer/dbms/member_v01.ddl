DROP TABLE prodreg CASCADE CONSTRAINTS;
DROP TABLE adminlogin CASCADE CONSTRAINTS;
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE loglogin CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(90)		 NOT NULL,
		id                            		VARCHAR2(200)		 NOT NULL,
		address                       		CLOB(10)		 NULL ,
		phone1                        		VARCHAR2(20)		 NOT NULL,
		phone2                        		VARCHAR2(20)		 NULL ,
		email                         		VARCHAR2(200)		 NOT NULL,
		notifemail                    		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		notifphone                    		CHAR(1)		 DEFAULT 'Y'		 NOT NULL
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원 번호';
COMMENT ON COLUMN member.name is '이름';
COMMENT ON COLUMN member.id is '아이디';
COMMENT ON COLUMN member.address is '주소';
COMMENT ON COLUMN member.phone1 is '전화번호';
COMMENT ON COLUMN member.phone2 is '전화번호2';
COMMENT ON COLUMN member.email is '이메일';
COMMENT ON COLUMN member.notifemail is '이메일 수신';
COMMENT ON COLUMN member.notifphone is '전화 수신';


/**********************************/
/* Table Name: 회원 로그인 */
/**********************************/
CREATE TABLE loglogin(
		logloginno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE loglogin is '회원 로그인';
COMMENT ON COLUMN loglogin.logloginno is '로그인 기록';
COMMENT ON COLUMN loglogin.memberno is '회원 번호';


/**********************************/
/* Table Name: 관리자 */
/**********************************/
CREATE TABLE admin(
		adminno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(90)		 NOT NULL,
		id                            		VARCHAR2(200)		 NOT NULL,
		address                       		CLOB(10)		 NOT NULL,
		phone1                        		VARCHAR2(20)		 NOT NULL,
		phone2                        		VARCHAR2(20)		 NULL ,
		email                         		VARCHAR2(200)		 NOT NULL
);

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.adminno is '관리자 번호';
COMMENT ON COLUMN admin.name is '이름';
COMMENT ON COLUMN admin.id is '아이디';
COMMENT ON COLUMN admin.address is '주소';
COMMENT ON COLUMN admin.phone1 is '전화번호1';
COMMENT ON COLUMN admin.phone2 is '전화번호2';
COMMENT ON COLUMN admin.email is '이메일';


/**********************************/
/* Table Name: 관리자 로그인 */
/**********************************/
CREATE TABLE adminlogin(
		adminloginno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		adminno                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE adminlogin is '관리자 로그인';
COMMENT ON COLUMN adminlogin.adminloginno is '관리자 로그인 기록';
COMMENT ON COLUMN adminlogin.adminno is '관리자 번호';


/**********************************/
/* Table Name: 상품 등록 내역 */
/**********************************/
CREATE TABLE prodreg(
		prodregno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		adminno                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE prodreg is '상품 등록 내역';
COMMENT ON COLUMN prodreg.prodregno is '상품 정보 내역';
COMMENT ON COLUMN prodreg.adminno is '관리자 번호';


