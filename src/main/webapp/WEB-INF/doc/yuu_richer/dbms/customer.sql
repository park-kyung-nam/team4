
/**********************************/
/* Table Name: ȸ�� ���� �ڵ� */
/**********************************/
CREATE TABLE customerstatscode(
    customerstatscodeno                 NUMBER(10)     NOT NULL    PRIMARY KEY,
    customerstatschar                   VARCHAR2(30)   unique     NOT NULL,
    customerstatsdesc                   CLOB     NOT NULL
);

COMMENT ON TABLE customerstatscode is 'ȸ�� ���� �ڵ�';
COMMENT ON COLUMN customerstatscode.customerstatscodeno is 'ȸ�� ���� �ڵ�';
COMMENT ON COLUMN customerstatscode.customerstatschar is 'ȸ�� ���� ���';
COMMENT ON COLUMN customerstatscode.customerstatsdesc is 'ȸ�� ���� ����';

--2. �߰�

insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Normal','�Ϲ� ȸ��');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Unreg','Ż�� ȸ��');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Pwdreset','��й�ȣ �缳�� �ʿ�');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Pwdchangeneeded','��й�ȣ �缳�� ����');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Restricted','�̿� ���� ȸ��');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Normal','�Ϲ� ȸ��');
--
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  -1, 'Unidentified','ȸ�� �ڵ尡 ������');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  -2,  'Edited','ȸ�� ������ �����ڿ� ���� ������');
  
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  0,
  'None2','None');

--3. ��ȸ
--������ ������� ����

select *
from customerstatscode;

select customerstatscodeno, customerstatschar, customerstatsdesc
from customerstatscode;

 MEMBERSTATSCODENO MEMBERSTATSCHAR MEMBERSTATSDESC
 ----------------- --------------- ---------------
                 1 Normal          �Ϲ� ȸ��
                 2 Unreg           Ż�� ȸ��
                 3 Pwdreset        ��й�ȣ �缳�� �ʿ�
                 4 Pwdchangeneeded ��й�ȣ �缳�� ����
                 5 Restricted      �̿� ���� ȸ��


--4. Ư�� ���ڵ� ��ȸ(������� ����)

--5. ����(������� ����)
update customerstatscode
set customerstatschar = 'Simple',
    customerstatsdesc = '���� ȸ��'
where customerstatscodeno = 1;

--6. ����(������� ����, ��� �� ȸ�� ��� ����)
update customer
set customerstatscodeno = abc
where customerstatscodeno = -1;

delete from customerstatscode
where customerstatscodeno = 6;

--7. ����¡/�˻�(������� ����. �ڵ� Ư�� �� �� ������ �ȿ� ��� �ڵ尡 �� �־�� ��)


select * from ALL_CONSTRAINTS;
/**********************************/
/* Table Name: ȸ�� */
/**********************************/
delete from customer

drop table customer cascade constraints;

--1. ���̺�
CREATE TABLE customer(
    customerno                          NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(90)     NOT NULL,
    id                                VARCHAR2(200)    NOT NULL,
    passwd                            VARCHAR2(500)     NOT NULL,
    zipcode                           VARCHAR2(20)     NULL ,
    address                           VARCHAR2(2000)     NULL ,
    address2                          VARCHAR2(2000)     NULL ,
    phone1                            VARCHAR2(20)     NOT NULL,
    phone2                            VARCHAR2(20)     NULL ,
    email                             VARCHAR2(200)    NOT NULL,
    notifemail                        CHAR(1)    DEFAULT 'Y'     NOT NULL,
    notifphone                        CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                             DATE     NOT NULL,
    ddate                             DATE     NULL ,
    bdate                             DATE     NULL ,
    customerstatscodeno                 NUMBER(10)     not NULL ,
  FOREIGN KEY (customerstatscodeno) REFERENCES customerstatscode (customerstatscodeno)
);


COMMENT ON TABLE customer is 'ȸ��';
COMMENT ON COLUMN customer.customerno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN customer.name is '�̸�';
COMMENT ON COLUMN customer.id is '���̵�!�ߺ��Ұ�';
COMMENT ON COLUMN customer.passwd is '��й�ȣ';
COMMENT ON COLUMN customer.zipcode is '�����ȣ';
COMMENT ON COLUMN customer.address is '�ּ�';
COMMENT ON COLUMN customer.address2 is '���ּ�';
COMMENT ON COLUMN customer.phone1 is '��ȭ��ȣ';
COMMENT ON COLUMN customer.phone2 is '��ȭ��ȣ2';
COMMENT ON COLUMN customer.email is '�̸���!�ߺ��Ұ�';
COMMENT ON COLUMN customer.notifemail is '�̸��� ����';
COMMENT ON COLUMN customer.notifphone is '��ȭ ����';
COMMENT ON COLUMN customer.rdate is '������';
COMMENT ON COLUMN customer.ddate is 'Ż����';
COMMENT ON COLUMN customer.customerstatscodeno is 'ȸ�� ���� �ڵ�';


--2. ���̵� �ߺ� Ȯ��

select count(*) as cnt
from customer
where id='nana@demo.io'

--2. �̸��� �ߺ� Ȯ��

select count(*) as cnt
from customer
where email='nana@demo.io'


--2. ���

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values(1,'����','nana@demo.io','demo',1, '�����','01012341234',null,'nana@demo.io','Y','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values(2,'���','lulu@demo.io','demo',1, '������','01012125566',null,'lulu@demo.io','N','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values(3,'�Ϸ�','haru@demo.io','demo',1, '������','01066536864',null,'nana@demo.io','Y','Y',sysdate,null);

DELETE FROM customer;

--3. seqno �̻�� > nvl, max ���

SELECT customerno FROM customer;
 
 MEMBERNO
 ---------------
 
SELECT MAX(customerno) FROM customer; -- ���ڵ尡 ������ null
 
 MAX(MEMBERNO)
 -------------
          NULL
           
SELECT MAX(customerno) + 1 FROM customer;    -- ���ڵ尡 ������ �ǹ� ����, null       
           
 MAX(MEMBERNO)+1
 ---------------
            NULL
 
-- null�� �÷��� ���� 0���� ������ ����, NVL(�÷���, 0): �÷����� null�̸� 0���� ����
SELECT NVL(MAX(customerno), 0) + 1 FROM customer;
 
 NVL(MAX(MEMBERNO),0)+1
 ----------------------
                      1
                        
-- as: Ŀ�� ���� ����, SELECT�ÿ��� �÷��� ����                       
SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer;  

 MEMBERNO
 --------
        1
        
--ȸ�� ����(�̸�, ���̵�, ��й�ȣ, �̸���, ��ȭ��ȣ�� �Է�.
 
insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values((SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer),'����','nana@demo.io','demo',1, '�����','01012341234',null,'nana@demo.io','Y','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values((SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer),'���','lulu@demo.io','demo',1, '������','01012125566',null,'lulu@demo.io','N','N',sysdate,null);

insert into customer
(customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate)
values((SELECT NVL(MAX(customerno), 0) + 1 as customerno FROM customer),'�Ϸ�','haru@demo.io','demo',1, '������','01066536864',null,'haru@demo.io','Y','Y',sysdate,null);

--4. ���

select * from customer;

select customerno, name, id, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
order by customerno desc;

 MEMBERNO NAME ID           PASSWD MEMBERSTATSCODENO ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ----------------- ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        3 �Ϸ�   haru@demo.io demo                   1 ������     01066536864 NULL   haru@demo.io Y          Y          2019-05-14 15:20:42.0 NULL
        2 ���   lulu@demo.io demo                   1 ������     01012125566 NULL   lulu@demo.io N          N          2019-05-14 15:20:41.0 NULL
        1 ����   nana@demo.io demo                   1 �����     01012341234 NULL   nana@demo.io Y          N          2019-05-14 15:20:40.0 NULL


select 
s.customerstatscodeno, s.customerstatschar, s.customerstatsdesc,
c.customerno, c.name, c.id, c.customerstatscodeno,
c.address, c.phone1, c.phone2, c.email, c.notifemail, c.notifphone, c.rdate, c.ddate
from customer c, customerstatscode s
where (s.customerstatscodeno = c.customerstatscodeno)
order by c.customerno desc
        
--5. Ư�� ���ڵ� ��ȸ
select customerno, name, id, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where customerno = 3;

 MEMBERNO NAME ID           PASSWD MEMBERSTATSCODENO ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ----------------- ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        3 �Ϸ�   haru@demo.io demo                   1 ������     01066536864 NULL   haru@demo.io Y          Y          2019-05-14 15:20:42.0 NULL

--6. ȸ�� ���� ����
--ȸ�� ������ ȸ�� ������ �����ϳ� ����� ���ؼ� �����ڰ� ���Ƿ� ������ �� ����
--�̸�, ���̵�, Ż����, �������� �������� ����
--��й�ȣ�� ��й�ȣ ã�� ���� �ÿ� ����

update customer
set
  address = '���ֽ�',
  phone1 = '01066789876',
  phone2 = '',
  email = 'kei@demo.io',
  notifemail = 'N',
  notifphone = 'N',
  customerstatscodeno = 1

where customerno = 2;

select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
order by customerno desc;

 MEMBERNO NAME ID           PASSWD MEMBERSTATSCODENO ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ----------------- ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        3 �Ϸ�   haru@demo.io demo                   1 ������     01066536864 NULL   haru@demo.io Y          Y          2019-05-14 15:20:42.0 NULL
        2 ���   lulu@demo.io demo                   1 ���ֽ�     01066789876 NULL   kei@demo.io  N          N          2019-05-14 15:20:41.0 NULL
        1 ����   nana@demo.io demo                   1 �����     01012341234 NULL   nana@demo.io Y          N          2019-05-14 15:20:40.0 NULL

--6a. ���̵� ã��
--���̵� ���� ������ ���� ��(�̸���, �޴���ȭ)
select customerno, id from customer
where email='nana@demo.io';

 MEMBERNO ID
 -------- ------------
        1 nana@demo.io

select customerno, id from customer
where phone1='01066536864' or phone2='01066536864';

 MEMBERNO ID
 -------- ------------
        3 haru@demo.io
        
--6b. ��й�ȣ ã��
--��й�ȣ ã�⸦ ���� �� ������ ��й�ȣ�� �缳��
--��й�ȣ ã�⸦ ������ ���̵�� ��й�ȣ�� �ݵ�� �ٲپ�߸� �α����� ������
--pwdreset = 3
update customer
set
  passwd = 'initial',
  customerstatscodeno = 3

where customerno = 2;


--7. ȸ�� Ż��(���ۼ�)
--ȸ�� Ż�� �� ȸ�� ���¸� 'Ż��'�� ���� �� Ż���� ���
--Unreg = 2
update customer
set
  customerstatscodeno = 2,
  ddate = sysdate
where customerno = 2;

--8. ȸ�� ����(���ۼ�)
--Ż������ ���Ͽ� ȸ�� ���� ���� ����

DELETE FROM customer
WHERE customerno >= 6;

--9. �˻�
--������ ����[�̸�, ���� ����, ȸ�� ���·θ� �˻�]
-- ex. �̸����� �˻�
select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where name like '%��%';

 MEMBERNO NAME ID           PASSWD ADDRESS PHONE1      PHONE2 EMAIL        NOTIFEMAIL NOTIFPHONE RDATE                 DDATE
 -------- ---- ------------ ------ ------- ----------- ------ ------------ ---------- ---------- --------------------- -----
        1 ����   nana@demo.io demo   �����     01012341234 NULL   nana@demo.io Y          N          2019-05-14 12:48:07.0 NULL

--�̸��� ���� ���ο� ���� �˻�
select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where notifemail='N';

--ȸ�� ���¿� ���� �˻�
select customerno, name, id, passwd, customerstatscodeno, address, phone1, phone2, email, notifemail, notifphone, rdate, ddate
from customer
where customerstatscodeno=1;
        

--10. ����¡(���ۼ�)
--������ ����
select 
      customerstatscodeno, customerstatschar, customerstatsdesc,
      customerno, name, id, c_customerstatscodeno,
      address, phone1, phone2, email, notifemail, notifphone, rdate, ddate, r
    from(
      select
        customerstatscodeno, customerstatschar, customerstatsdesc,
        customerno, name, id, c_customerstatscodeno,
        address, phone1, phone2, email, notifemail, notifphone, rdate, ddate, rownum as r
      from(
        select 
          s.customerstatscodeno as customerstatscodeno, s.customerstatschar, s.customerstatsdesc,
          c.customerno, c.name, c.id, c.customerstatscodeno as c_customerstatscodeno,
          c.address, c.phone1, c.phone2, c.email, c.notifemail, c.notifphone, c.rdate, c.ddate
        from customer c, customerstatscode s
        where (s.customerstatscodeno = c.customerstatscodeno)
        order by c.customerno desc
        )
      )
      where r >=1 and f < 10

--�ܺ� �÷����� ���













