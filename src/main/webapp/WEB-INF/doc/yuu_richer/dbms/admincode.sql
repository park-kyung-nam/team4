
/**********************************/
/* Table Name: 관리자 권한 코드 */
/**********************************/
CREATE TABLE admincode(
    admincodeno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    privchar                          VARCHAR2(10)     NOT NULL,
    privdesc                          CLOB     NOT NULL
);

COMMENT ON TABLE admincode is '관리자 권한 코드';
COMMENT ON COLUMN admincode.admincodeno is '관리자 코드';
COMMENT ON COLUMN admincode.privchar is '관리자 권한 약어';
COMMENT ON COLUMN admincode.privdesc is '관리자 권한 설명';

--관리자 상태 및 권한 : 총괄 관리자만 설정 가능
--0 : 총괄 관리자
--양수 : 권한
--음수 : 상태


--2. 추가

insert into admincode
(admincodeno, privchar, privdesc)
values(
  0, 'Master','총괄 관리자');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  (SELECT NVL(MAX(admincodeno), 0) + 1 as admincodeno FROM admincode),
  'Admin','관리자');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -1,'Pwdreset','비밀번호 재설정 필요');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -2,'Pending','승인 대기');
  
insert into admincode
(admincodeno, privchar, privdesc)
values(
  -8,'Dereg','탈퇴');

--3. 조회
--순서는 사용하지 않음

select admincodeno, privchar, privdesc
from admincode;

 ADMINCODENO PRIVCHAR PRIVDESC
 ----------- -------- -----------
           0 Master   총괄 관리자
           1 Admin    관리자
          -2 Pending  승인 대기
          -1 Pwdreset 비밀번호 재설정 필요


--4. 특정 레코드 조회(사용하지 않음)

--5. 수정(사용하지 않음)

--6. 삭제(사용하지 않음, 사용 시 관리자 등급 및 상태 변경)
update admin
set admincodeno = 1
where admincodeno = xyz;

delete from admincode
where admincodeno = xyz;

--7. 페이징/검색(사용하지 않음. 코드 특성 상 한 페이지 안에 모든 코드가 들어가 있어야 됨)

