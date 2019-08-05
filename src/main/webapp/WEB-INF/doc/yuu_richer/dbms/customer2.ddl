DROP TABLE off-p CASCADE CONSTRAINTS;
DROP TABLE code CASCADE CONSTRAINTS;
DROP TABLE log CASCADE CONSTRAINTS;
DROP TABLE main CASCADE CONSTRAINTS;
DROP TABLE customermod CASCADE CONSTRAINTS;
DROP TABLE modcode CASCADE CONSTRAINTS;
DROP TABLE adminlog CASCADE CONSTRAINTS;
DROP TABLE adminlogtype CASCADE CONSTRAINTS;
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE admincode CASCADE CONSTRAINTS;
DROP TABLE loglogin CASCADE CONSTRAINTS;
DROP TABLE logincode CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE customerstatscode CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: ȸ�� ���� �ڵ� */
/**********************************/
CREATE TABLE customerstatscode(
		customerstatscodeno           		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		customerstatschar             		VARCHAR2(10)		 NOT NULL,
		customerstatsdesc             		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE customerstatscode is 'ȸ�� ���� �ڵ�';
COMMENT ON COLUMN customerstatscode.customerstatscodeno is 'ȸ�� ���� �ڵ�';
COMMENT ON COLUMN customerstatscode.customerstatschar is 'ȸ�� ���� ���';
COMMENT ON COLUMN customerstatscode.customerstatsdesc is 'ȸ�� ���� ����';


/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE customer(
		customerno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
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
		customerstatscodeno           		NUMBER(10)		 NULL ,
  FOREIGN KEY (customerstatscodeno) REFERENCES customerstatscode (customerstatscodeno)
);

COMMENT ON TABLE customer is 'ȸ��';
COMMENT ON COLUMN customer.customerno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN customer.name is '�̸�';
COMMENT ON COLUMN customer.id is '���̵�!�ߺ��Ұ�';
COMMENT ON COLUMN customer.passwd is '��й�ȣ';
COMMENT ON COLUMN customer.address is '�ּ�';
COMMENT ON COLUMN customer.phone1 is '��ȭ��ȣ';
COMMENT ON COLUMN customer.phone2 is '��ȭ��ȣ2';
COMMENT ON COLUMN customer.email is '�̸���!�ߺ��Ұ�';
COMMENT ON COLUMN customer.notifemail is '�̸��� ����';
COMMENT ON COLUMN customer.notifphone is '��ȭ ����';
COMMENT ON COLUMN customer.rdate is '������';
COMMENT ON COLUMN customer.ddate is 'Ż����';
COMMENT ON COLUMN customer.customerstatscodeno is 'ȸ�� ���� �ڵ�';


/**********************************/
/* Table Name: �α��� ��� �ڵ� */
/**********************************/
CREATE TABLE logincode(
		logincodeno                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		resultchar                    		VARCHAR2(10)		 NOT NULL,
		resultdesc                    		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE logincode is '�α��� ��� �ڵ�';
COMMENT ON COLUMN logincode.logincodeno is '�α��� �ڵ�';
COMMENT ON COLUMN logincode.resultchar is '�α��� ��� ���';
COMMENT ON COLUMN logincode.resultdesc is '�α��� ��� ����';


/**********************************/
/* Table Name: ȸ�� �α��� */
/**********************************/
CREATE TABLE loglogin(
		logloginno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		customerno                    		NUMBER(10)		 NULL ,
		ipv4                          		VARCHAR2(30)		 NOT NULL,
		logincodeno                   		NUMBER(10)		 NULL ,
		desc                          		VARCHAR2(400)		 NULL ,
  FOREIGN KEY (customerno) REFERENCES customer (customerno),
  FOREIGN KEY (logincodeno) REFERENCES logincode (logincodeno)
);

COMMENT ON TABLE loglogin is 'ȸ�� �α���';
COMMENT ON COLUMN loglogin.logloginno is '�α��� ���';
COMMENT ON COLUMN loglogin.customerno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN loglogin.ipv4 is '�α��� ������';
COMMENT ON COLUMN loglogin.logincodeno is '�α��� �ڵ�';
COMMENT ON COLUMN loglogin.desc is '�α��� ����';


/**********************************/
/* Table Name: ������ ���� �ڵ� */
/**********************************/
CREATE TABLE admincode(
		admincodeno                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		privchar                      		VARCHAR2(10)		 NOT NULL,
		privdesc                      		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE admincode is '������ ���� �ڵ�';
COMMENT ON COLUMN admincode.admincodeno is '������ �ڵ�';
COMMENT ON COLUMN admincode.privchar is '������ ���� ���';
COMMENT ON COLUMN admincode.privdesc is '������ ���� ����';


/**********************************/
/* Table Name: ������ */
/**********************************/
CREATE TABLE admin(
		adminno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(90)		 NOT NULL,
		id                            		VARCHAR2(200)		 NOT NULL,
		passwd                        		CLOB(10)		 NOT NULL,
		admincodeno                   		NUMBER(10)		 NULL ,
		address                       		CLOB(10)		 NOT NULL,
		phone1                        		VARCHAR2(20)		 NOT NULL,
		phone2                        		VARCHAR2(20)		 NULL ,
		email                         		VARCHAR2(200)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
  FOREIGN KEY (admincodeno) REFERENCES admincode (admincodeno)
);

COMMENT ON TABLE admin is '������';
COMMENT ON COLUMN admin.adminno is '������ ��ȣ';
COMMENT ON COLUMN admin.name is '�̸�';
COMMENT ON COLUMN admin.id is '���̵�!�ߺ��Ұ�';
COMMENT ON COLUMN admin.passwd is '��й�ȣ';
COMMENT ON COLUMN admin.admincodeno is '������ �ڵ�';
COMMENT ON COLUMN admin.address is '�ּ�';
COMMENT ON COLUMN admin.phone1 is '��ȭ��ȣ1';
COMMENT ON COLUMN admin.phone2 is '��ȭ��ȣ2';
COMMENT ON COLUMN admin.email is '�̸���!�ߺ��Ұ�';
COMMENT ON COLUMN admin.rdate is '�����';


/**********************************/
/* Table Name: ������ Ȱ�� ���� */
/**********************************/
CREATE TABLE adminlogtype(
		logtype                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		type                          		VARCHAR2(100)		 NOT NULL
);

COMMENT ON TABLE adminlogtype is '������ Ȱ�� ����';
COMMENT ON COLUMN adminlogtype.logtype is 'Ȱ�� ���� ��ȣ';
COMMENT ON COLUMN adminlogtype.type is 'Ȱ�� ����';


/**********************************/
/* Table Name: ������ �α��� */
/**********************************/
CREATE TABLE adminlog(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		adminno                       		NUMBER(10)		 NULL ,
		logdesc                       		VARCHAR2(4000)		 NOT NULL,
		ipv4                          		VARCHAR2(15)		 NULL ,
		logtype                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (logtype) REFERENCES adminlogtype (logtype)
);

COMMENT ON TABLE adminlog is '������ �α���';
COMMENT ON COLUMN adminlog.logno is '������ Ȱ�� ���';
COMMENT ON COLUMN adminlog.adminno is '������ ��ȣ';
COMMENT ON COLUMN adminlog.logdesc is 'Ȱ�� ����';
COMMENT ON COLUMN adminlog.ipv4 is 'IP';
COMMENT ON COLUMN adminlog.logtype is 'Ȱ�� ���� ��ȣ';


/**********************************/
/* Table Name: ȸ�� ó�� �ڵ� */
/**********************************/
CREATE TABLE modcode(
		modcodeno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		modchar                       		VARCHAR2(10)		 NOT NULL,
		moddesc                       		CLOB(10)		 NOT NULL
);

COMMENT ON TABLE modcode is 'ȸ�� ó�� �ڵ�';
COMMENT ON COLUMN modcode.modcodeno is 'ȸ�� ó�� �ڵ�';
COMMENT ON COLUMN modcode.modchar is 'ȸ�� ó�� ���';
COMMENT ON COLUMN modcode.moddesc is 'ȸ�� ó�� ����';


/**********************************/
/* Table Name: ȸ�� ó�� ���� */
/**********************************/
CREATE TABLE customermod(
		customermodno                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		customerno                    		NUMBER(10)		 NULL ,
		modcodeno                     		NUMBER(10)		 NULL ,
		etc                           		CLOB(10)		 NULL ,
  FOREIGN KEY (customerno) REFERENCES customer (customerno),
  FOREIGN KEY (modcodeno) REFERENCES modcode (modcodeno)
);

COMMENT ON TABLE customermod is 'ȸ�� ó�� ����';
COMMENT ON COLUMN customermod.customermodno is 'ȸ�� ó�� ����';
COMMENT ON COLUMN customermod.customerno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN customermod.modcodeno is 'ȸ�� ó�� �ڵ�';
COMMENT ON COLUMN customermod.etc is '���';


/**********************************/
/* Table Name: ���� ���̺� */
/**********************************/
CREATE TABLE main(

);

COMMENT ON TABLE main is '���� ���̺�';


/**********************************/
/* Table Name: �α� ���̺� */
/**********************************/
CREATE TABLE log(

);

COMMENT ON TABLE log is '�α� ���̺�';


/**********************************/
/* Table Name: �ڵ� ���̺� */
/**********************************/
CREATE TABLE code(

);

COMMENT ON TABLE code is '�ڵ� ���̺�';


/**********************************/
/* Table Name: �ܺ�-�ڰ泲 */
/**********************************/
CREATE TABLE off-p(

);

COMMENT ON TABLE off-p is '�ܺ�-�ڰ泲';


