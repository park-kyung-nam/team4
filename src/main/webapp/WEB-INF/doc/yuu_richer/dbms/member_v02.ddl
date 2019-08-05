DROP TABLE customermod CASCADE CONSTRAINTS;
DROP TABLE modcode CASCADE CONSTRAINTS;
DROP TABLE prodreg CASCADE CONSTRAINTS;
DROP TABLE regcode CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE adminlogin CASCADE CONSTRAINTS;
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE admincode CASCADE CONSTRAINTS;
DROP TABLE loglogin CASCADE CONSTRAINTS;
DROP TABLE logincode CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE customerstatscode CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 회원 상태 코드 */
/**********************************/
CREATE TABLE customerstatscode(
		customerstatscodeno             		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		customerstatschar               		VARCHAR2(10)		 NOT NULL,
		customerstatsdesc               		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE customerstatscode is '회원 상태 코드';
COMMENT ON COLUMN customerstatscode.customerstatscodeno is '회원 상태 코드';
COMMENT ON COLUMN customerstatscode.customerstatschar is '회원 상태 약어';
COMMENT ON COLUMN customerstatscode.customerstatsdesc is '회원 상태 설명';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE customer(
		customerno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(90)		 NOT NULL,
		id                            		VARCHAR2(200)		 NOT NULL,
		passwd                        		CLOB(10)		 NOT NULL,
		address                       		CLOB(10)		 NULL ,
		phone1                        		VARCHAR2(20)		 NOT NULL,
		phone2                        		VARCHAR2(20)		 NULL ,
		email                         		VARCHAR2(200)		 NOT NULL,
		notifemail                    		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		notifphone                    		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		ddate                         		DATE		 NULL ,
		customerstatscodeno             		NUMBER(10)		 NULL ,
  FOREIGN KEY (customerstatscodeno) REFERENCES customerstatscode (customerstatscodeno)
);

COMMENT ON TABLE customer is '회원';
COMMENT ON COLUMN customer.customerno is '회원 번호';
COMMENT ON COLUMN customer.name is '이름';
COMMENT ON COLUMN customer.id is '아이디!중복불가';
COMMENT ON COLUMN customer.passwd is '비밀번호';
COMMENT ON COLUMN customer.address is '주소';
COMMENT ON COLUMN customer.phone1 is '전화번호';
COMMENT ON COLUMN customer.phone2 is '전화번호2';
COMMENT ON COLUMN customer.email is '이메일!중복불가';
COMMENT ON COLUMN customer.notifemail is '이메일 수신';
COMMENT ON COLUMN customer.notifphone is '전화 수신';
COMMENT ON COLUMN customer.rdate is '가입일';
COMMENT ON COLUMN customer.ddate is '탈퇴일';
COMMENT ON COLUMN customer.customerstatscodeno is '회원 상태 코드';


/**********************************/
/* Table Name: 로그인 결과 코드 */
/**********************************/
CREATE TABLE logincode(
		logincodeno                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		resultchar                    		VARCHAR2(10)		 NOT NULL,
		resultdesc                    		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE logincode is '로그인 결과 코드';
COMMENT ON COLUMN logincode.logincodeno is '로그인 코드';
COMMENT ON COLUMN logincode.resultchar is '로그인 결과 약어';
COMMENT ON COLUMN logincode.resultdesc is '로그인 결과 설명';


/**********************************/
/* Table Name: 회원 로그인 */
/**********************************/
CREATE TABLE loglogin(
		logloginno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		customerno                      		NUMBER(10)		 NULL ,
		ipv4                          		VARCHAR2(30)		 NOT NULL,
		logincodeno                   		NUMBER(10)		 NULL ,
		desc                          		VARCHAR2(400)		 NULL ,
  FOREIGN KEY (customerno) REFERENCES customer (customerno),
  FOREIGN KEY (logincodeno) REFERENCES logincode (logincodeno)
);

COMMENT ON TABLE loglogin is '회원 로그인';
COMMENT ON COLUMN loglogin.logloginno is '로그인 기록';
COMMENT ON COLUMN loglogin.customerno is '회원 번호';
COMMENT ON COLUMN loglogin.ipv4 is '로그인 아이피';
COMMENT ON COLUMN loglogin.logincodeno is '로그인 코드';
COMMENT ON COLUMN loglogin.desc is '로그인 내용';


/**********************************/
/* Table Name: 관리자 권한 코드 */
/**********************************/
CREATE TABLE admincode(
		admincodeno                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		privchar                      		VARCHAR2(10)		 NOT NULL,
		privdesc                      		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE admincode is '관리자 권한 코드';
COMMENT ON COLUMN admincode.admincodeno is '관리자 코드';
COMMENT ON COLUMN admincode.privchar is '관리자 권한 약어';
COMMENT ON COLUMN admincode.privdesc is '관리자 권한 설명';


/**********************************/
/* Table Name: 관리자 */
/**********************************/
CREATE TABLE admin(
		adminno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(90)		 NOT NULL,
		id                            		VARCHAR2(200)		 NOT NULL,
		passwd                        		CLOB		 NOT NULL,
		admincodeno                   		NUMBER(10)	default -2	not NULL ,
		address                       		CLOB		 NOT NULL,
		phone1                        		VARCHAR2(20)		 NOT NULL,
		phone2                        		VARCHAR2(20)		 NULL ,
		email                         		VARCHAR2(200)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
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
/* Table Name: 상품 항목 */
/**********************************/
CREATE TABLE product(
		prodno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE product is '상품 항목';
COMMENT ON COLUMN product.prodno is '상품 번호';

insert into product(prodno) values(1);

/**********************************/
/* Table Name: 등록 결과 코드 */
/**********************************/
CREATE TABLE regcode(
		regcodeno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		regchar                       		VARCHAR2(10)		 NOT NULL,
		regdesc                       		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE regcode is '등록 결과 코드';
COMMENT ON COLUMN regcode.regcodeno is '등록 코드';
COMMENT ON COLUMN regcode.regchar is '등록 결과 약어';
COMMENT ON COLUMN regcode.regdesc is '등록 결과 설명';


/**********************************/
/* Table Name: 상품 등록 내역 */
/**********************************/
CREATE TABLE prodreg(
		prodregno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		adminno                       		NUMBER(10)		 NULL ,
		prodno                        		NUMBER(10)		 NULL ,
		regcodeno                     		NUMBER(10)		 NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (prodno) REFERENCES product (prodno),
  FOREIGN KEY (regcodeno) REFERENCES regcode (regcodeno)
);

COMMENT ON TABLE prodreg is '상품 등록 내역';
COMMENT ON COLUMN prodreg.prodregno is '상품 정보 내역';
COMMENT ON COLUMN prodreg.adminno is '관리자 번호';
COMMENT ON COLUMN prodreg.prodno is '상품 번호';
COMMENT ON COLUMN prodreg.regcodeno is '등록 코드';


/**********************************/
/* Table Name: 회원 처리 코드 */
/**********************************/
CREATE TABLE modcode(
		modcodeno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		modchar                       		VARCHAR2(10)		 NOT NULL,
		moddesc                       		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE modcode is '회원 처리 코드';
COMMENT ON COLUMN modcode.modcodeno is '회원 처리 코드';
COMMENT ON COLUMN modcode.modchar is '회원 처리 약어';
COMMENT ON COLUMN modcode.moddesc is '회원 처리 설명';


/**********************************/
/* Table Name: 회원 처리 내역 */
/**********************************/
CREATE TABLE customermod(
		customermodno                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		customerno                      		NUMBER(10)		 NULL ,
		adminno                       		NUMBER(10)		 NULL ,
		modcodeno                     		NUMBER(10)		 NULL ,
		etc                           		CLOB(10)		 NULL ,
  FOREIGN KEY (customerno) REFERENCES customer (customerno),
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (modcodeno) REFERENCES modcode (modcodeno)
);

COMMENT ON TABLE customermod is '회원 처리 내역';
COMMENT ON COLUMN customermod.customermodno is '회원 처리 내역';
COMMENT ON COLUMN customermod.customerno is '회원 번호';
COMMENT ON COLUMN customermod.adminno is '관리자 번호';
COMMENT ON COLUMN customermod.modcodeno is '회원 처리 코드';
COMMENT ON COLUMN customermod.etc is '비고';


