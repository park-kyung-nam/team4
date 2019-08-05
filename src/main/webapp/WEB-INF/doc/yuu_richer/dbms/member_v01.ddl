DROP TABLE prodreg CASCADE CONSTRAINTS;
DROP TABLE adminlogin CASCADE CONSTRAINTS;
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE loglogin CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: ȸ�� */
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

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN member.name is '�̸�';
COMMENT ON COLUMN member.id is '���̵�';
COMMENT ON COLUMN member.address is '�ּ�';
COMMENT ON COLUMN member.phone1 is '��ȭ��ȣ';
COMMENT ON COLUMN member.phone2 is '��ȭ��ȣ2';
COMMENT ON COLUMN member.email is '�̸���';
COMMENT ON COLUMN member.notifemail is '�̸��� ����';
COMMENT ON COLUMN member.notifphone is '��ȭ ����';


/**********************************/
/* Table Name: ȸ�� �α��� */
/**********************************/
CREATE TABLE loglogin(
		logloginno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE loglogin is 'ȸ�� �α���';
COMMENT ON COLUMN loglogin.logloginno is '�α��� ���';
COMMENT ON COLUMN loglogin.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ������ */
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

COMMENT ON TABLE admin is '������';
COMMENT ON COLUMN admin.adminno is '������ ��ȣ';
COMMENT ON COLUMN admin.name is '�̸�';
COMMENT ON COLUMN admin.id is '���̵�';
COMMENT ON COLUMN admin.address is '�ּ�';
COMMENT ON COLUMN admin.phone1 is '��ȭ��ȣ1';
COMMENT ON COLUMN admin.phone2 is '��ȭ��ȣ2';
COMMENT ON COLUMN admin.email is '�̸���';


/**********************************/
/* Table Name: ������ �α��� */
/**********************************/
CREATE TABLE adminlogin(
		adminloginno                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		adminno                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE adminlogin is '������ �α���';
COMMENT ON COLUMN adminlogin.adminloginno is '������ �α��� ���';
COMMENT ON COLUMN adminlogin.adminno is '������ ��ȣ';


/**********************************/
/* Table Name: ��ǰ ��� ���� */
/**********************************/
CREATE TABLE prodreg(
		prodregno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		adminno                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE prodreg is '��ǰ ��� ����';
COMMENT ON COLUMN prodreg.prodregno is '��ǰ ���� ����';
COMMENT ON COLUMN prodreg.adminno is '������ ��ȣ';


