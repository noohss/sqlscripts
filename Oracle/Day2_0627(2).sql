-- 문자열 타입
-- CHAR(길이) : 고정길이, 단위는 바이트
-- VARCHAR(길이) : 오라클에서 존재하지만 사용하지 않는 예비자료형.
-- VARCHAR2(길이) : 가변형길이 단위 바이트, 길이는 최대 길이이고 실제로 메모리는 데이터 크기만큼 사용한다.
--					최대 2000바이트이다. UTF-8 인코딩에서 한글은 3바이트, 영문/숫자/기호는 1바이트이다.

CREATE TABLE tbl_string (
	acol char(10),		-- 10바이트 고정길이
	bcol varchar2(10),	-- 10개 문자 가변길이
	ccol nchar(10),		-- 10개 문자 고정길이
	dcol nvarchar2(10) 	-- 10개 문자 가변길이
);

-- char 타입
INSERT INTO tbl_string(acol) VALUES('abcdefghij');
INSERT INTO tbl_string(acol) VALUES('abcdef');		-- acol은 고정길이 타입 : 공백 추가
INSERT INTO tbl_string(acol) VALUES('abcdefghijklm'); -- 오류 : 길이 초과 (최대 10)
-- INSERT 확인
SELECT * FROM TBL_STRING; 
-- 한글 확인
INSERT INTO TBL_STRING (acol) VALUES ('가나다');	-- 공백 1개 추가
INSERT INTO TBL_STRING (acol) VALUES ('가나다라');		-- 열에 대한 값이 너무 큼(실제 : 12, 최대값 : 10)
INSERT INTO TBL_STRING (acol) VALUES ('가나');	-- 공백 4개 추가

-- varchar2 타입 : bcol은 가변길이 10바이트
INSERT INTO TBL_STRING (bcol) values('abcdefghij');
INSERT INTO TBL_STRING (bcol) values('abcdef');	-- bcol은 가변길이 타입 . 공백 추가 없음.
INSERT INTO TBL_STRING (bcol) values('abcdefghijklm');	-- 오류 : 길이 초과
-- INSERT 확인
SELECT * FROM TBL_STRING;
-- 한글 확인
INSERT INTO TBL_STRING (bcol) VALUES ('가나다');		-- 공백 추가 없음.
INSERT INTO TBL_STRING (bcol) VALUES ('가나다라');		-- 오류 : 열에 대한 값이 너무 큼(실제 : 12, 최대값 : 10)
INSERT INTO TBL_STRING (bcol) VALUES ('가나');		-- 공백 추가 없음.

-- char과 varchar2는 바이트 단위. nchar과 nvarchar2는 문자 개수 단위(다국어 문자가 많이 포함되는 컬럼에 적절)
INSERT INTO TBL_STRING (ccol) VALUES ('가나다');		-- 공백 7개 추가
INSERT INTO TBL_STRING (ccol) VALUES ('가나다라');		-- 공백 6개 추가	
INSERT INTO TBL_STRING (ccol) VALUES ('가나');		-- 공백 8개 추가
INSERT INTO TBL_STRING (ccol) VALUES ('가나다라마바사아자차카');		-- 오류 : 길이 초과
SELECT * FROM TBL_STRING;
-- nvarchar2 타입
INSERT INTO TBL_STRING (dcol) VALUES ('가나다');		
INSERT INTO TBL_STRING (dcol) VALUES ('가나다라');		
INSERT INTO TBL_STRING (dcol) VALUES ('가나');	
INSERT INTO TBL_STRING (ccol) VALUES ('가나다라마바사아자차카');		-- 오류 : 길이 초과
