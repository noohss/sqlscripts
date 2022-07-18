-- 제약 조건 설정은 create table, alter table에서 한다.

-- 제약 조건 1): not null : col2 컬럼은 반드시 값을 저장해야 한다.
CREATE TABLE tbl# (
	col1 varchar2(10),
	col2 number(3) NOT NULL
);

INSERT INTO tbl#(col2) VALUES (98);
INSERT INTO tbl#(col1) VALUES ('korean'); -- 오류 : NOT NULL 제약조건 위반
INSERT INTO tbl# VALUES ('korean',78);
INSERT INTO tbl# VALUES ('korean',88);
-- 확인
SELECT * FROM tbl#;
-- 새로운 제약조건 2) unique를 갖는 col3
ALTER TABLE tbl# ADD col3 varchar2(10) UNIQUE; -- 유일한 값이어야 한다.

-- 다음 insert를 순서대로 실행할 때 오류가 발생하는 것은?
INSERT INTO tbl#(col1) VALUES ('english'); -- 오류
INSERT INTO tbl#(col2) VALUES (77);
INSERT INTO tbl#(col3) VALUES ('english'); -- 오류
INSERT INTO tbl#(col1,col2) VALUES ('english',88);
INSERT INTO tbl#(col2,col3) VALUES (88, 'science');
INSERT INTO tbl#(col1,col3) VALUES ('science',88); -- 오류
-- 오류 : 무결성 제약 조건(C##IDEV.SYS_C008349)에 위배 됩니다.
INSERT INTO tbl#(col1,col2,col3) VALUES ('english',89,'science');

INSERT INTO tbl#(col1,col2,col3) VALUES ('english',89,'math');
-- 체크 사항 : unique 컬럼에는 null 허용된다.

-- 제약 조건 3) 기본키 (primary key)는 not null 과 unique 제약조건이다.

CREATE TABLE tbl2#(
	tno NUMBER(3) PRIMARY KEY,
	tid number(3) UNIQUE 
);

INSERT INTO tbl2#(tno) VALUES (123);
SELECT *FROM tbl2#;
-- 무결성 제약 조건(pk 기본키 컬럼은 유일한 값이면서 not null 이다.)에 위배된다.
INSERT INTO tbl2#(tno) VALUES (123);	-- unique
INSERT INTO tbl2#(tid) VALUES (123); 	-- NOT NULL

-- 제약조건 4) check : 컬럼값의 범위를 설정 -> age 컬럼값은 16~80, null 허용한다.
ALTER TABLE tbl2# ADD age number(3) CHECK (age BETWEEN 16 AND 80);
INSERT INTO tbl2#(tno,tid,age) VALUES (222,123,20);
INSERT INTO tbl2#(tno,tid,age) VALUES (223,124,90);	-- 오류 : 체크 제약조건(C##IDEV.SYS_C006996)이 위배되었습니다.
-- 성별 gender 컬럼 추가
ALTER TABLE tbl2# ADD gender char(1) CHECK (gender IN ('M','F'));
INSERT INTO tbl2# (tno,GENDER) VALUES (224,'F');
INSERT INTO tbl2# (tno,GENDER) VALUES (225,'M');
INSERT INTO tbl2# (tno,GENDER) VALUES (226,'m');	-- 오류 : CHECK 제약조건 위반

-- 성별 gender 컬럼의 제약조건 변경은 삭제(drop) 후 추가(add) 해야 한다.
ALTER TABLE "TBL2#" DROP CONSTRAINT "TBL2__chk_gender";
ALTER TABLE "TBL2#" ADD CONSTRAINT TBL2__chk_gender CHECK (gender IN ('M','F','m','f'));

INSERT INTO tbl2# (tno,GENDER) VALUES (226,'m'); 	
INSERT INTO tbl2# (tno,GENDER) VALUES (227,'f'); 	
