
/**********************************/
/* Table Name: 관리자 활동 종류 */
/**********************************/
CREATE TABLE adminlogtype(
    logtype                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    typedesc                              VARCHAR2(100)    NOT NULL
);

COMMENT ON TABLE adminlogtype is '관리자 활동 종류';
COMMENT ON COLUMN adminlogtype.logtype is '활동 종류 번호';
COMMENT ON COLUMN adminlogtype.typedesc is '활동 종류';

--신규 코드 삽입
--총괄 관리자만 사용 가능
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


--리스트 출력
--권한 로그 출력 시 자동으로 선택
select * from adminlogtype
order by logtype

--로그 입력 시 하나의 항목 선택
select * from adminlogtype
where logtype = 1;

--수정(디버그용)
update adminlogtype
set
  typedesc = 'Login'
where logtype = 1;

--삭제(디버그용)
delete from adminlogtype
where logtype = 1;









/**********************************/
/* Table Name: 관리자 활동 기록 */
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

COMMENT ON TABLE adminlog is '관리자 활동 기록';
COMMENT ON COLUMN adminlog.logno is '관리자 활동 기록';
COMMENT ON COLUMN adminlog.adminno is '관리자 번호';
COMMENT ON COLUMN adminlog.logdate is '활동 일자';
COMMENT ON COLUMN adminlog.logdesc is '활동 내용';
COMMENT ON COLUMN adminlog.ipv4 is 'IPv4';
COMMENT ON COLUMN adminlog.ipv6 is 'IPv6';
COMMENT ON COLUMN adminlog.logtype is '활동 종류 번호';

--기록 입력
--일반적으로 자동으로 입력되며 원하는 경우 수동 입력 가능
insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 0, '127.0.0.1', null, '리셰 로그인 완료');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 1, '127.0.0.1', null, '리라 로그인 완료');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 2, '127.0.0.1', null, '시엘 로그인 완료');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 1, 3, '127.0.0.1', null, '코론 로그인 완료');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 3, 6, '192.168.1.1', null, '아로미 계정이 탈퇴됨');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 2, 9, '12.123.48.1', null, '미즈키가 회원 정보를 수정함');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 4, 10, '44.56.22.115', null, '치마키가 카테고리를 수정함');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 3, 11, '111.5.24.9', null, '새로운 관리자의 가입 요청');

insert into adminlog(logno, logtype, adminno, ipv4, ipv6, logdesc)
values ((SELECT NVL(MAX(logno), 0) + 1 as logno FROM adminlog), 3, 11, '127.0.0.1', '3FFE:FFFF:7654:FEDA:1245:BA98:3210:4562', '리셰가 [PC 주요 부품].[CPU]에[Intel i7-8700]을 등록함(수량 : 200개)');

--기록 리스트
--where 1=1은 검색용으로 추가
select logno, logtype, adminno, logdate, ipv4, ipv6, logdesc
from adminlog
where 1=1;

--코드와의 연동
--실제 출력 시에 사용
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc,
a.adminno as adminno_a, a.name
from adminlogtype t, adminlog l, admin a
where t.logtype = l.logtype and l.adminno = a.adminno;

--로그 자세히 보기

select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype and l.logno = 1;

--로그 수정은 특성 상 미지원

update adminlog
set
  logtype = 1,
  adminno = 1,
  ipv4 = null,
  ipv6 = null,
  logdesc = 'Edited'
where logno=1;

--로그 삭제
--일반적으로 삭제하지 않음
delete from adminlog
where logno=1;

--로그 검색

--로그를 작성하거나 행동한 관리자에 따라 검색
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and adminno = 0

--로그 타입에 따라 검색
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and t.logtype = 1

--IP에 따라 검색
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and ipv4 = '127.0.0.1'

--기록 내용에 따라 검색
select 
t.logtype, t.typedesc,
l.logno, l.logtype as logtype_l, l.adminno, l.logdate, l.ipv4, l.ipv6, l.logdesc
from adminlogtype t, adminlog l
where t.logtype = l.logtype
and logdesc like '%로그인%'

--페이징--2단
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
  --and logdesc like '%로그인%'
)


--페이징--3단
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
  --and logdesc like '%로그인%'
  order by logno desc
  )
where rownum >=1 and rownum <= 3




















