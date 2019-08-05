
/**********************************/
/* Table Name: ������ ���� �ڵ� */
/**********************************/
CREATE TABLE admincode(
    admincodeno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    privchar                          VARCHAR2(10)     NOT NULL,
    privdesc                          CLOB     NOT NULL
);

COMMENT ON TABLE admincode is '������ ���� �ڵ�';
COMMENT ON COLUMN admincode.admincodeno is '������ �ڵ�';
COMMENT ON COLUMN admincode.privchar is '������ ���� ���';
COMMENT ON COLUMN admincode.privdesc is '������ ���� ����';

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

 ADMINCODENO PRIVCHAR PRIVDESC
 ----------- -------- -----------
           0 Master   �Ѱ� ������
           1 Admin    ������
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

