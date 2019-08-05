
/**********************************/
/* Table Name: ������ ���� �ڵ� */
/**********************************/
CREATE TABLE admincode(
    admincodeno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    privchar                          VARCHAR2(10)     NOT NULL,
    privdesc                          CLOB     NOT NULL,
    privclass           CLOB default 'btn-secondary' null
);

COMMENT ON TABLE admincode is '������ ���� �ڵ�';
COMMENT ON COLUMN admincode.admincodeno is '������ �ڵ�';
COMMENT ON COLUMN admincode.privchar is '������ ���� ���';
COMMENT ON COLUMN admincode.privdesc is '������ ���� ����';
COMMENT ON COLUMN admincode.privclass is '������ ���� ����';

--������ ���� �� ���� : �Ѱ� �����ڸ� ���� ����
--0 : �Ѱ� ������
--��� : ����
--���� : ����


--2. �߰�

insert into admincode
(admincodeno, privchar, privdesc)
values(
  0, 'Master','�Ѱ� ������');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Admin','������');
  
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Product','��ǰ ������');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Event','�̺�Ʈ ������');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Co-op','���»�');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Cust','�������� ��ȣ �����');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -1,'Pwdreset','��й�ȣ �缳�� �ʿ�');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -2,'Pending','���� ���');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -8,'Dereg','Ż��');

--3. ��ȸ
--������ ������� ����

select admincodeno, privchar, privdesc
from admincode;

--��� ����
    select admincodeno, privchar, privdesc
    from admincode
    where admincodeno > 0
    
ADMINCODENO PRIVCHAR PRIVDESC
 ----------- -------- --------
           1 Admin    ������
           2 Product  ��ǰ ������
           3 Event    �̺�Ʈ ������

--��� �Ұ�
    select admincodeno, privchar, privdesc
    from admincode
    where admincodeno < 0
    
 ADMINCODENO PRIVCHAR PRIVDESC
 ----------- -------- -----------
          -8 Dereg    Ż��
          -2 Pending  ���� ���
          -1 Pwdreset ��й�ȣ �缳�� �ʿ�



--4. Ư�� ���ڵ� ��ȸ(������� ����)

--5. ����(������� ����)

--6. ����(������� ����, ��� �� ������ ��� �� ���� ����)
update admin
set admincodeno = 1
where admincodeno = xyz;

delete from admincode
where admincodeno = xyz;

--7. ����¡/�˻�(������� ����. �ڵ� Ư�� �� �� ������ �ȿ� ��� �ڵ尡 �� �־�� ��)




/**********************************/
/* Table Name: ������ */
/**********************************/

SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH, NULLABLE FROM USER_TAB_COLUMNS WHERE TABLE_NAME='admin' ORDER BY COLUMN_ID;

drop table admin

CREATE TABLE admin(
    adminno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(90)     NOT NULL,
    id                                VARCHAR2(200)  unique  NOT NULL,
    passwd                             VARCHAR2(1000)     NOT NULL,
    img                               varchar2(200) default 'bioimg_unset.png' null,
    profileimg                        varchar2(200) default 'unset.gif' null,
    admincodeno                       NUMBER(10)  default -2  not NULL ,
    address                           CLOB     NOT NULL,
    phone1                            VARCHAR2(20)     NOT NULL,
    phone2                            VARCHAR2(20)     NULL ,
    email                             VARCHAR2(200)  unique  NOT NULL,
    rdate                             DATE     NOT NULL,
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

ALTER TABLE admin ADD temp VARCHAR2(1000);
UPDATE admin
   SET temp = DBMS_LOB.SUBSTR (passwd, 1000);

ALTER TABLE admin DROP COLUMN passwd;
ALTER TABLE admin RENAME COLUMN temp TO passwd;

--�Ѱ� ������ �߰� / ������ �����̹Ƿ� �α��� �� �̸����� ������� ����
insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(0,'����','richer','SpxxgFxFD6jmt0K7K6VIVg==',0, '�����','01012341234',null,'richer@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(10,'����Ű','mizuki','9aP0BJxahiqgG7QnTC5QaQ==',5, '�����','01012341234',null,'mizuki@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(11,'����','rize','UWB/y3O7RxoLGCp+5pOOfQ==',2, '�����','01012341234',null,'rize@demo.io',sysdate);

--Ż�� ���� ������ �߰� / ����Ʈ ������ Ż�� ���� ������
insert into admin
(adminno, name, id, passwd, admincodeno, address, phone1, phone2, email, rdate)
values
(-1,'Ż��� ȸ��','removed account','removed account',-8, '-','-',null,'-',sysdate);

--�Ϲ� ������ �߰� or ����(���´� �Է����� ����)
insert into admin
(adminno, name, id, passwd, address, phone1, phone2, email, rdate)
values((SELECT NVL(MAX(adminno), 0) + 1 as adminno FROM admin),'����','rira@demo.io','demo', '�����','01012341234',null,'rira@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, address, phone1, phone2, email, rdate)
values((SELECT NVL(MAX(adminno), 0) + 1 as adminno FROM admin),'�ÿ�','ciel@demo.io','demo', '����','01055334676',null,'ciel@demo.io',sysdate);

insert into admin
(adminno, name, id, passwd, address, phone1, phone2, email, rdate)
values((SELECT NVL(MAX(adminno), 0) + 1 as adminno FROM admin),'�ڷ�','coron@demo.io','demo', '�����ֽ�','01098334948',null,'coron@demo.io',sysdate);

--���
--��й�ȣ�� ��ȸ���� ����
select * from admin;

select adminno, name, id, img, profileimg, admincodeno, address, phone1, phone2, email, rdate
from admin
order by adminno desc;

 ADMINNO NAME ID            PASSWD    ADMINCODENO ADDRESS PHONE1      PHONE2 EMAIL          RDATE
 ------- ---- ------------- --------- ----------- ------- ----------- ------ -------------- ---------------------
       3 �ڷ�   coron@demo.io demo               -2 �����ֽ�    01098334948 NULL   coron@demo.io  2019-05-15 18:22:11.0
       2 �ÿ�   ciel@demo.io  demo               -2 ����     01055334676 NULL   ciel@demo.io   2019-05-15 18:22:10.0
       1 ����   rira@demo.io  demo               -2 �����     01012341234 NULL   rira@demo.io   2019-05-15 18:22:09.0
       0 ����   richer        caramella           0 �����     01012341234 NULL   richer@demo.io 2019-05-15 18:20:43.0


--Ư�� ������ ��ȸ
       
select adminno, name, id, img, profileimg, admincodeno, address, phone1, phone2, email, rdate
from admin
where adminno = 0;
       
 ADMINNO NAME ID     PASSWD    ADMINCODENO ADDRESS PHONE1      PHONE2 EMAIL          RDATE
 ------- ---- ------ --------- ----------- ------- ----------- ------ -------------- ---------------------
       0 ����   richer caramella           0 �����     01012341234 NULL   richer@demo.io 2019-05-15 18:20:43.0

--������ ���� ����
--�ڱ� �ڽ��� ������ ���� Ȥ�� ���� �����ڰ� ���� ����

update admin
set
  name='���',
  img = '',
  profileimg = '',
  address = '���ֽ�',
  phone1 = '01066789876',
  phone2 = '',
  email = 'lua@demo.io'

where adminno = 1;

5. �н����� ����
1) �н����� �˻� 
SELECT COUNT(*) as cnt
FROM admin
WHERE adminno=1 AND passwd='1234';

select adminno, passwd from admin
select mno, passwd from member where mno = 1;

 
2) �н����� ����
UPDATE admin
SET passwd='0000'
WHERE adminno=11;
       
--������ ���� �� ���� ����
--�Ѱ� ������ �� ���� �����ڸ� ����

update admin
set admincodeno = 1

where adminno = 1;


--������ Ż��
--������ Ż�� �� ȸ�� ���¸� 'Ż��'�� ���� �� Ż���� ���
--�������� ��� Ż������ ���� �ۼ����� ����
--
update admin
set
  admincodeno = ?
where adminno = 8;

select * from admin
where admincodeno = -8

--8. ȸ�� ����
--�����ڴ� ���� �����ڸ��� ���� ����

DELETE FROM admin
WHERE adminno = 0;

 ADMINNO NAME
 ------- ------------
       4 12333333333
       6 �Ʒι�
       7 123
       8 admin
      10 568568658658

select adminno, name from admin
where admincodeno != -8

--9. �˻�(������� ����)
        

--10. ����¡(������� ����)

