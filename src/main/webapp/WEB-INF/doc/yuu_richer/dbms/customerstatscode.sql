
/**********************************/
/* Table Name: 회원 상태 코드 */
/**********************************/
CREATE TABLE customerstatscode(
    customerstatscodeno                 NUMBER(10)     NOT NULL    PRIMARY KEY,
    customerstatschar                   VARCHAR2(30)   unique     NOT NULL,
    customerstatsdesc                   CLOB     NOT NULL
);

COMMENT ON TABLE customerstatscode is '회원 상태 코드';
COMMENT ON COLUMN customerstatscode.customerstatscodeno is '회원 상태 코드';
COMMENT ON COLUMN customerstatscode.customerstatschar is '회원 상태 약어';
COMMENT ON COLUMN customerstatscode.customerstatsdesc is '회원 상태 설명';

--2. 추가

insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Normal','일반 회원');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Unreg','탈퇴 회원');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Pwdreset','비밀번호 재설정 필요');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Pwdchangeneeded','비밀번호 재설정 권장');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Restricted','이용 제한 회원');
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (SELECT NVL(MAX(customerstatscodeno), 0) + 1 as customerstatscodeno FROM customerstatscode),
  'Normal','일반 회원');
--
  
insert into customerstatscode
(customerstatscodeno, customerstatschar, customerstatsdesc)
values(
  (-1, 'Unidentified','회원 코드가 삭제됨');

--3. 조회
--순서는 사용하지 않음

select customerstatscodeno, customerstatschar, customerstatsdesc
from customerstatscode;

 MEMBERSTATSCODENO MEMBERSTATSCHAR MEMBERSTATSDESC
 ----------------- --------------- ---------------
                 1 Normal          일반 회원
                 2 Unreg           탈퇴 회원
                 3 Pwdreset        비밀번호 재설정 필요
                 4 Pwdchangeneeded 비밀번호 재설정 권장
                 5 Restricted      이용 제한 회원


--4. 특정 레코드 조회(사용하지 않음)

--5. 수정(사용하지 않음)
update customerstatscode
set customerstatschar = 'Simple',
    customerstatsdesc = '간편 회원'
where customerstatscodeno = 1;

--6. 삭제(사용하지 않음, 사용 시 회원 등급 변경)
update customer
set customerstatscodeno = abc
where customerstatscodeno = -1;

delete from customerstatscode
where customerstatscodeno = [삭제할 회원 코드];

--7. 페이징/검색(사용하지 않음. 코드 특성 상 한 페이지 안에 모든 코드가 들어가 있어야 됨)

