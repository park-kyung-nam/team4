/**********************************/
/* Table Name: ������ �α��� */
/**********************************/
--������ �α��� ����� �ڼ��� �αװ� �ʿ��ϱ⿡ ������ �ڵ带 ���� ����
CREATE TABLE adminlogin(
    adminloginno                      NUMBER(10)     NOT NULL    PRIMARY KEY,
    adminno                           NUMBER(10)     NULL ,
    rdate date not null,
    ipv4 varchar2(20) not null,
    --ipv6 varchar(60) null,
    result clob not null,
    
  FOREIGN KEY (adminno) REFERENCES admin (adminno)
);

COMMENT ON TABLE adminlogin is '������ �α���';
COMMENT ON COLUMN adminlogin.adminloginno is '������ �α��� ���';
COMMENT ON COLUMN adminlogin.adminno is '������ ��ȣ';
COMMENT ON COLUMN adminlogin.rdate is'�α��� ����';
COMMENT ON COLUMN adminlogin.result is '�α��� ���';

--���(�ڵ�)
--�α��� ����� ���� �ܰ迡�� �ڵ����� �Է��ϵ��� ����

insert into adminlogin
(adminloginno, adminno, rdate, ipv4, result)
values
((SELECT NVL(MAX(adminloginno), 0) + 1 as adminloginno FROM adminlogin), 0, sysdate, '127.0.0.1', '�α��� ����');

insert into adminlogin
(adminloginno, adminno, rdate, ipv4, result)
values
((SELECT NVL(MAX(adminloginno), 0) + 1 as adminloginno FROM adminlogin), 0, sysdate, '127.0.0.2', '�ǽɽ����� �α���');

insert into adminlogin
(adminloginno, adminno, rdate, ipv4, result)
values
((SELECT NVL(MAX(adminloginno), 0) + 1 as adminloginno FROM adminlogin), 1, sysdate, '127.0.0.2', '�α��� 10���� ����');

--����Ʈ ���
select adminloginno, adminno, rdate, ipv4, result
from adminlogin;

 ADMINLOGINNO ADMINNO RDATE                 IPV4      RESULT
 ------------ ------- --------------------- --------- -----------
            1       0 2019-05-23 17:01:01.0 127.0.0.1 �α��� ����
            2       0 2019-05-23 17:01:40.0 127.0.0.2 �ǽɽ����� �α���
            3       1 2019-05-23 17:01:41.0 127.0.0.2 �α��� 10���� ����

--��ȸ(���� �ÿ��� ���)
select adminloginno, adminno, rdate, ipv4, result
from adminlogin
where adminloginno = 1;

 ADMINLOGINNO ADMINNO RDATE                 IPV4      RESULT
 ------------ ------- --------------------- --------- ------
            1       0 2019-05-23 17:01:01.0 127.0.0.1 �α��� ����

--����(�α� Ư�� �� ������� ����)

--����
delete from adminlogin
where adminloginno = 1;

--�ش� ������ ������ ���� �� [Ż���� ȸ��]���� ����

update adminlogin
set adminno = -1
where adminno = 22;


/**********************************/
/* Table Name: ȸ�� �α��� ��� �ڵ� */
/**********************************/
--�ڵ�� ������ �߰� �� �������� ����
CREATE TABLE logincode(
    logincodeno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    resultchar                        VARCHAR2(50)     NOT NULL,
    resultdesc                        CLOB     NOT NULL
    
);

COMMENT ON TABLE logincode is '�α��� ��� �ڵ�';
COMMENT ON COLUMN logincode.logincodeno is '�α��� �ڵ�';
COMMENT ON COLUMN logincode.resultchar is '�α��� ��� ���';
COMMENT ON COLUMN logincode.resultdesc is '�α��� ��� ����';

--�ڵ� �߰�

insert into logincode
(logincodeno, resultchar, resultdesc)
values(
  (SELECT NVL(MAX(logincodeno), 0) + 1 as logincodeno FROM logincode),
  'Success','�α��� ����');

insert into logincode
(logincodeno, resultchar, resultdesc)
values(
  (SELECT NVL(MAX(logincodeno), 0) + 1 as logincodeno FROM logincode),
  'Failed','�α��� ����');

--�ڵ� ���

select logincodeno, resultchar, resultdesc
from logincode
where logincodeno > 0
order by logincodeno asc;

 LOGINCODENO RESULTCHAR RESULTDESC
 ----------- ---------- ----------
           1 Success    �α��� ����
           2 Failed     �α��� ����

--�ڵ� ����(������ join �ÿ��� ���)

select logincodeno, resultchar, resultdesc
from logincode
where logincodeno = 1;

 LOGINCODENO RESULTCHAR RESULTDESC
 ----------- ---------- ----------
           1 Success    �α��� ����

--�ڵ� ����(������� ����)
--�ڵ� ����(������� ����)

           

/**********************************/
/* Table Name: ȸ�� �α��� */
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

COMMENT ON TABLE loglogin is 'ȸ�� �α���';
COMMENT ON COLUMN loglogin.logloginno is '�α��� ���';
COMMENT ON COLUMN loglogin.customerno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN loglogin.ipv4 is '�α��� ������';
--COMMENT ON COLUMN loglogin.ipv6 is '�α��� ������';
COMMENT ON COLUMN loglogin.logincodeno is '�α��� �ڵ�';
COMMENT ON COLUMN loglogin.logindesc is '�α��� ����';

--���(�ڵ�)
--�α��� ����� ���� �ܰ迡�� �ڵ����� �Է��ϵ��� ����

insert into loglogin
(logloginno, customerno, rdate, ipv4, logincodeno, logindesc)
values
((SELECT NVL(MAX(logloginno), 0) + 1 as logloginno FROM loglogin), 1, sysdate, '127.0.0.1', 1, '����');

insert into loglogin
(logloginno, customerno, rdate, ipv4, logincodeno, logindesc)
values
((SELECT NVL(MAX(logloginno), 0) + 1 as logloginno FROM loglogin), 2, sysdate, '127.0.0.2', 2, '�ǽɽ����� �α���');

insert into loglogin
(logloginno, customerno, rdate, ipv4, logincodeno, logindesc)
values
((SELECT NVL(MAX(logloginno), 0) + 1 as logloginno FROM loglogin), 1, sysdate, '127.0.0.2', '�α��� 10���� ����');

--����Ʈ ���
select logloginno, customerno, rdate, ipv4, logincodeno, logindesc
from loglogin
order by logloginno desc;

 LOGLOGINNO CUSTOMERNO RDATE                 IPV4      LOGINCODENO LOGINDESC
 ---------- ---------- --------------------- --------- ----------- ---------
          2          2 2019-05-23 17:24:06.0 127.0.0.2           2 �ǽɽ����� �α���
          1          1 2019-05-23 17:24:05.0 127.0.0.1           1 ����

--��ȸ(���� �ÿ��� ���)
select logloginno, customerno, rdate, ipv4, logincodeno, logindesc
from loglogin
where logloginno = 1;


--����(�α� Ư�� �� ������� ����)

--����
delete from loglogin
where logloginno = 1;

--�ش� ȸ�� ���� ���� �� ����

delete from loglogin
where customerno = 22;




/**********************************/
/* Table Name: ��� ��� �ڵ� */
/**********************************/
CREATE TABLE regcode(
    regcodeno                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    regchar                           VARCHAR2(10)     NOT NULL,
    regdesc                           CLOB     NOT NULL
);

COMMENT ON TABLE regcode is '��� ��� �ڵ�';
COMMENT ON COLUMN regcode.regcodeno is '��� �ڵ�';
COMMENT ON COLUMN regcode.regchar is '��� ��� ���';
COMMENT ON COLUMN regcode.regdesc is '��� ��� ����';


--�ڵ� �߰�

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'RS','��ǰ ��� ����');

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'RF','��ǰ ��� ����');

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'US','��ǰ ���� ����');

insert into regcode
(regcodeno, regchar, regdesc)
values(
  (SELECT NVL(MAX(regcodeno), 0) + 1 as regcodeno FROM regcode),
  'UF','��ǰ ���� ����');

--�ڵ� ���

select regcodeno, regchar, regdesc
from regcode
where regcodeno > 0
order by regcodeno asc;

 REGCODENO REGCHAR REGDESC
 --------- ------- --------
         1 RS      ��ǰ ��� ����
         2 RF      ��ǰ ��� ����
         3 US      ��ǰ ���� ����
         4 UF      ��ǰ ���� ����


--�ڵ� ����(��ǰ ���� join �ÿ��� ���)

select regcodeno, regchar, regdesc
from regcode
where regcodeno = 1;

 REGCODENO REGCHAR REGDESC
 --------- ------- --------
         1 RS      ��ǰ ��� ����

--�ڵ� ����(������� ����)
--�ڵ� ����(������� ����)




/**********************************/
/* Table Name: ��ǰ ��� ���� */
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

COMMENT ON TABLE prodreg is '��ǰ ��� ����';
COMMENT ON COLUMN prodreg.prodregno is '��ǰ ���� ����';
COMMENT ON COLUMN prodreg.adminno is '������ ��ȣ';
COMMENT ON COLUMN prodreg.prodno is '��ǰ ��ȣ';
COMMENT ON COLUMN prodreg.regcodeno is '��� �ڵ�';
COMMENT ON COLUMN prodreg.rdate is 'ó�� ��¥';
COMMENT ON COLUMN prodreg.regdesc is '�ڼ��� ����';


--���(�ڵ�)
--��ǰ ó�� ����� ���� �ܰ迡�� �ڵ����� �Է��ϵ��� ����

insert into prodreg
(prodregno, adminno, prodno, rdate, regcodeno, regdesc)
values
((SELECT NVL(MAX(prodregno), 0) + 1 as prodregno FROM prodreg), 1, 1, sysdate, 1, '��ǰ ���');

insert into prodreg
(prodregno, adminno, prodno, rdate, regcodeno, regdesc)
values
((SELECT NVL(MAX(prodregno), 0) + 1 as prodregno FROM prodreg), 2, 1, sysdate, 3, '��ǰ ����');

insert into prodreg
(prodregno, adminno, prodno, rdate, regcodeno, regdesc)
values
((SELECT NVL(MAX(prodregno), 0) + 1 as prodregno FROM prodreg), 1, 1, sysdate, 4, '��ǰ ���� ����');

--����Ʈ ���
select prodregno, adminno, prodno, rdate, regcodeno, regdesc
from prodreg
order by prodregno desc;

 PRODREGNO ADMINNO PRODNO RDATE                 REGCODENO REGDESC
 --------- ------- ------ --------------------- --------- --------
         3       1      1 2019-05-23 17:34:04.0         4 ��ǰ ���� ����
         2       2      1 2019-05-23 17:34:03.0         3 ��ǰ ����
         1       1      1 2019-05-23 17:34:02.0         1 ��ǰ ���

--��ȸ(���� �ÿ��� ���)
select prodregno, adminno, prodno, rdate, regcodeno, regdesc
from prodreg
where prodregno = 1;

--��ȸ(Ư�� ��ǰ �α� ������ �ʿ��� ���)
select prodregno, adminno, prodno, rdate, regcodeno, regdesc
from prodreg
where prodno = 1
order by prodregno desc;

 PRODREGNO ADMINNO PRODNO RDATE                 REGCODENO REGDESC
 --------- ------- ------ --------------------- --------- --------
         3       1      1 2019-05-23 17:34:04.0         4 ��ǰ ���� ����
         2       2      1 2019-05-23 17:34:03.0         3 ��ǰ ����
         1       1      1 2019-05-23 17:34:02.0         1 ��ǰ ���



--����(�α� Ư�� �� ������� ����)

--����
delete from prodreg
where prodregno = 1;

--�ش� ��ǰ Ȥ�� ������ ���� ���� �� ����
--(������ ��ǰ�� �α״� ������ ���Ϸ� ����)

delete from prodreg
where prodno = 22;

delete from prodreg
where adminno = 1;




