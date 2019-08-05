
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
  (-1, 'Unidentified','ȸ�� �ڵ尡 ������');

--3. ��ȸ
--������ ������� ����

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
where customerstatscodeno = [������ ȸ�� �ڵ�];

--7. ����¡/�˻�(������� ����. �ڵ� Ư�� �� �� ������ �ȿ� ��� �ڵ尡 �� �־�� ��)

