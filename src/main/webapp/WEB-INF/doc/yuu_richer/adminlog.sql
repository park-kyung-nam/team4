
/**********************************/
/* Table Name: ������ Ȱ�� ���� */
/**********************************/
CREATE TABLE adminlogtype(
    logtype                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    typedesc                              VARCHAR2(100)    NOT NULL
);

COMMENT ON TABLE adminlogtype is '������ Ȱ�� ����';
COMMENT ON COLUMN adminlogtype.logtype is 'Ȱ�� ���� ��ȣ';
COMMENT ON COLUMN adminlogtype.typedesc is 'Ȱ�� ����';

--�ű� �ڵ� ����
--�Ѱ� �����ڸ� ��� ����
insert into adminlogtype(logtype, typedesc)
values ((SELECT NVL(MAX(logtype), 0) + 1 as logtype FROM adminlogtype), 'Login');

insert into adminlogtype(logtype, typedesc)
values ((SELECT NVL(MAX(logtype), 0) + 1 as logtype FROM adminlogtype), 'Member');

insert into adminlogtype(logtype, typedesc)
values ((SELECT NVL(MAX(logtype), 0) + 1 as logtype FROM adminlogtype), 'Admin');

insert into adminlogtype(logtype, typedesc)
values ((SELECT NVL(MAX(logtype), 0) + 1 as logtype FROM adminlogtype), 'Category');

insert into adminlogtype(logtype, typedesc)
values ((SELECT NVL(MAX(logtype), 0) + 1 as logtype FROM adminlogtype), 'Product');

insert into adminlogtype(logtype, typedesc)
values ((SELECT NVL(MAX(logtype), 0) + 1 as logtype FROM adminlogtype), 'MLogin');


--����Ʈ ���
--���� �α� ��� �� �ڵ����� ����
select * from adminlogtype
order by logtype

--�α� �Է� �� �ϳ��� �׸� ����
select * from adminlogtype
where logtype = 1;

--����(����׿�)
update adminlogtype
set
  typedesc = 'Login'
where logtype = 1;

--����(����׿�)
delete from adminlogtype
where logtype = 1;









/**********************************/
/* Table Name: ������ Ȱ�� ��� */
/**********************************/
drop table adminlog;
CREATE TABLE adminlog(
    logno                             NUMBER(10)     NOT NULL    PRIMARY KEY,
    logtype                           NUMBER(10)     NULL ,
    adminno                           NUMBER(10)     NULL ,
    logdate                           date   default sysdate not  NULL ,
    ipv4                              VARCHAR2(20)     NULL ,
    ipv6                              VARCHAR2(50)     NULL ,
    logdesc                           VARCHAR2(4000)     NOT NULL,
  FOREIGN KEY (adminno) REFERENCES admin (adminno),
  FOREIGN KEY (logtype) REFERENCES adminlogtype (logtype)
);

COMMENT ON TABLE adminlog is '������ Ȱ�� ���';
COMMENT ON COLUMN adminlog.logno is '������ Ȱ�� ���';
COMMENT ON COLUMN adminlog.adminno is '������ ��ȣ';
COMMENT ON COLUMN adminlog.logdate is 'Ȱ�� ����';
COMMENT ON COLUMN adminlog.logdesc is 'Ȱ�� ����';
COMMENT ON COLUMN adminlog.ipv4 is 'IPv4';
COMMENT ON COLUMN adminlog.ipv6 is 'IPv6';
COMMENT ON COLUMN adminlog.logtype is 'Ȱ�� ���� ��ȣ';

--��� �Է�
--�Ϲ������� �ڵ����� �ԷµǸ� ���ϴ� ��� ���� �Է� ����
insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 0, '127.0.0.1', null, '���� �α��� �Ϸ�');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 1, '127.0.0.1', null, '���� �α��� �Ϸ�');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 2, '127.0.0.1', null, '�ÿ� �α��� �Ϸ�');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 3, '127.0.0.1', null, '�ڷ� �α��� �Ϸ�');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 3, 6, '192.168.1.1', null, '�Ʒι� ������ Ż���');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 2, 9, '12.123.48.1', null, '����Ű�� ȸ�� ������ ������');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 4, 10, '44.56.22.115', null, 'ġ��Ű�� ī�װ��� ������');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 3, 11, '111.5.24.9', null, '���ο� �������� ���� ��û');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 3, 11, '127.0.0.1', '3FFE:FFFF:7654:FEDA:1245:BA98:3210:4562', '���ΰ� [PC �ֿ� ��ǰ].[CPU]��[Intel i7-8700]�� �����(���� : 200��)');

--��� ����Ʈ
--where 1=1�� �˻������� �߰�
select logno, logtype, adminno, logdate, ipv4, ipv6, logdesc
from adminlog
where 1=1;

--�ڵ���� ����
--���� ��� �ÿ� ���
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc,
a.adminno as adminno_a, a.name
from adminlogtype t, adminlog l, admin a
where t.logtype = l.logtype and l.adminno = a.adminno;

--�α� �ڼ��� ����

select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype and l.logno = 1;

--�α� ������ Ư�� �� ������

update adminlog
set
  logtype = 1,
  adminno = 1,
  ipv4 = null,
  ipv6 = null,
  logdesc = 'Edited'
where logno=1;

--�α� ����
--�Ϲ������� �������� ����
delete from adminlog
where logno=1;

--�α� �˻�

--�α׸� �ۼ��ϰų� �ൿ�� �����ڿ� ���� �˻�
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and adminno = 0

--�α� Ÿ�Կ� ���� �˻�
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and t.logtype = 1

--IP�� ���� �˻�
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and ipv4 = '127.0.0.1'

--��� ���뿡 ���� �˻�
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and logdesc like '%�α���%'

--����¡--2��
select 
rownum as r,
logtype, typedesc,
logno, logtype_l, adminno, logdate, ipv4, ipv6, logdesc
from (
  select 
    t.logtype, t.typedesc,
    l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
  from adminlogtype t, adminlog l
  where t.logtype = l.logtype
  --and adminno = 0
  --and adminno = 0
  --and t.logtype = 1
  --and ipv4 = '127.0.0.1'
  --and logdesc like '%�α���%'
)


--����¡--3��
select 
  rownum as r,
  logtype, typedesc,
  logno, logtype_l, adminno, logdate, ipv4, ipv6, logdesc,
  adminno_a, name, id, admincodeno
  from (
    select 
    t.logtype, t.typedesc,
    l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc,
    a.adminno as adminno_a, a.name, a.id, a.admincodeno
    from adminlogtype t, adminlog l, admin a
    where t.logtype = l.logtype and l.adminno = a.adminno
  --and l.adminno = 0
  --and a.admincodeno = 1
  --and t.logtype = 1
  --and ipv4 = '127.0.0.1'
  --and logdesc like '%�α���%'
  order by logno desc
  )
where rownum >=1 and rownum <= 3




















