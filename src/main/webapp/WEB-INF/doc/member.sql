DROP TABLE authurlcheck CASCADE CONSTRAINTS;
DROP TABLE authurl CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE auth CASCADE CONSTRAINTS;
 
/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE auth(
authno                         NUMBER(10)  NOT NULL  PRIMARY KEY,
aname                          VARCHAR2(200)  NOT NULL
);
 
COMMENT ON TABLE auth is '����';
COMMENT ON COLUMN auth.authno is '���ѹ�ȣ';
COMMENT ON COLUMN auth.aname is '���Ѹ�';
 
 
/**********************************/
/* Table Name: ȸ�� */
/**********************************/

CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 ���� 
  passwd    VARCHAR(60)   NOT NULL, -- �н�����, ������ ����
  mname    VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
  tel          VARCHAR(14)   NOT NULL, -- ��ȭ��ȣ
  zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
  address1  VARCHAR(80)       NULL, -- �ּ� 1
  address2  VARCHAR(50)       NULL, -- �ּ� 2
  mdate     DATE             NOT NULL, -- ������    
  authno                         NUMBER(10)  NOT NULL ,
  PRIMARY KEY (mno),                     -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
  FOREIGN KEY (authno) REFERENCES auth (authno)
);


CREATE TABLE member(
memberno                       NUMBER(10)  NOT NULL  PRIMARY KEY,
id                             VARCHAR2(10)  NULL ,
authno                         NUMBER(10)  NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno)
);
 
COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.memberno is 'ȸ����ȣ';
COMMENT ON COLUMN member.id is '���̵�';
COMMENT ON COLUMN member.authno is '���ѹ�ȣ';
 
 
/**********************************/
/* Table Name: �����ּ� */
/**********************************/
CREATE TABLE authurl(
authurlno                      NUMBER(10)  NOT NULL  PRIMARY KEY,
url                            varchar2(200)  NOT NULL,
explain                        varchar2(400)  NULL 
);
 
COMMENT ON TABLE authurl is '�����ּ�';
COMMENT ON COLUMN authurl.authurlno is '�����ּҹ�ȣ';
COMMENT ON COLUMN authurl.url is '�ּ�';
COMMENT ON COLUMN authurl.explain is '����';
 
 
/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE authurlcheck(
authurlcheckno                 NUMBER(10)  NOT NULL  PRIMARY KEY,
authno                         NUMBER(10)  NOT NULL ,
authurlno                      NUMBER(10)  NOT NULL ,
  FOREIGN KEY (authno) REFERENCES auth (authno),
  FOREIGN KEY (authurlno) REFERENCES authurl (authurlno)
);
 
COMMENT ON TABLE authurlcheck is '����';
COMMENT ON COLUMN authurlcheck.authurlcheckno is '�ּ� ������ȣ';
COMMENT ON COLUMN authurlcheck.authno is '���ѹ�ȣ';
COMMENT ON COLUMN authurlcheck.authurlno is '�����ּҹ�ȣ';

/**********************************/
/* Table Name: ������ */
/**********************************/
CREATE TABLE employee (
  employeeno  NUMBER(6) NOT NULL, -- ������ ��ȣ, ���ڵ带 �����ϴ� �÷� 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 ���� 
  passwd    VARCHAR(60)   NOT NULL, -- �н�����, ������ ����
  mname    VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
  tel          VARCHAR(14)   NOT NULL, -- ��ȭ��ȣ
  zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
  address1  VARCHAR(80)       NULL, -- �ּ� 1
  address2  VARCHAR(50)       NULL, -- �ּ� 2
  mdate     DATE             NOT NULL, -- ������
  authno    NUMBER(10)  NOT NULL, -- ���� ��ȣ
  PRIMARY KEY (employeeno),    -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
  FOREIGN KEY (authno) REFERENCES auth (authno)
);

COMMENT ON TABLE EMPLOYEE is '������ ����';
COMMENT ON COLUMN EMPLOYEE.EMPLOYEENO is '���� ��ȣ';
COMMENT ON COLUMN EMPLOYEE.ID is '���̵�';
COMMENT ON COLUMN EMPLOYEE.PASSWD is '�н�����';
COMMENT ON COLUMN EMPLOYEE.MNAME is '����';
COMMENT ON COLUMN EMPLOYEE.TEL is '��ȭ��ȣ';
COMMENT ON COLUMN EMPLOYEE.ZIPCODE is '�����ȣ';
COMMENT ON COLUMN EMPLOYEE.ADDRESS1 is '�ּ�1';
COMMENT ON COLUMN EMPLOYEE.ADDRESS2 is '�ּ�2';
COMMENT ON COLUMN EMPLOYEE.MDATE is '������';
COMMENT ON COLUMN EMPLOYEE.AUTHNO is '���ѹ�ȣ';