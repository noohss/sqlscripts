-- 1) 도서를 추가합니다. ‘B1102’ , ‘스트라이크 던지기’, ‘박철순’ ,’KBO’ , ‘2020-11-10’
INSERT INTO TBL_BOOK (bcode,title,writer,publisher,pdate)
		VALUES ('B1102','스트라이크 던지기','박철순','KBO','2020-11-10');

-- 2) 반납된 도서의 연체일수를 계산하여 delay_days 컬럼값을 update 합니다.
UPDATE TBL_BOOKRENT SET delay_days = RETURN_DATE - EXP_DATE WHERE RETURN_DATE IS NOT NULL;
SELECT * FROM TBL_BOOKRENT tb ;

-- 3) 대출 중인 도서의 연체일수를 계산해서 회원IDX, 도서코드, 연체 일수를 검색합니다.
SELECT mem_idx,bcode,to_date(to_char(SYSDATE, 'yyyy-mm-dd')) - exp_date 
FROM TBL_BOOKRENT tb WHERE RETURN_DATE IS NULL;

-- 4) 현재 대출 중인 도서 중 연체 중인 회원의 이름, 전화번호를 검색합니다. 오늘 날짜 sysdate 기준으로 확인하기.
-- 현재 기준으로 연체중인 것은 현재날짜 > 반납날짜
SELECT name,TEL FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb
ON bm.MEM_IDX = tb.MEM_IDX AND SYSDATE  > exp_date AND return_date IS NULL;

-- 5) 현재 대출 중인 도서의 도서명코드와 도서명 검색합니다.
SELECT tb.BCODE, TITLE FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2 
ON tb.BCODE = tb2.BCODE AND return_date IS NULL;

-- 6) 현재 도서를 대여한 회원의 IDX와 회원이름을 검색합니다.
SELECT bm.MEM_IDX, NAME FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb 
ON bm.MEM_IDX = tb.MEM_IDX AND return_date IS NULL;

-- 7) 대출 중인 도서의 회원이름, 도서명, 반납기한 검색합니다.
SELECT name, title, exp_date
FROM BOOK_MEMBER bm, TBL_BOOK tb, TBL_BOOKRENT tb2
WHERE bm.MEM_IDX = tb2.MEM_IDX AND tb.BCODE = tb2.BCODE
AND return_date IS NULL;

-- 또는
SELECT name, title, exp_date FROM TBL_BOOKRENT tb 
JOIN TBL_BOOK tb2 ON tb2.BCODE = tb.BCODE 
JOIN BOOK_MEMBER bm ON tb.MEM_IDX = bm.MEM_IDX 
AND RETURN_DATE IS NULL;

-- 8) 현재 연체 중인 도서의 회원IDX, 도서코드, 반납기한을 검색합니다.
SELECT mem_idx, bcode, exp_date FROM TBL_BOOKRENT tb 
WHERE sysdate > EXP_DATE;


-- 9) 회원 IDX ‘10002’는 도서 대출이 가능한지 프로시저를 작성합니다.

	-- 일회용으로 실행하는 프로시저 plsql
	DECLARE 
		vcnt NUMBER;
	BEGIN
		SELECT count(*) INTO vcnt
		FROM TBL_BOOKRENT tb 
		WHERE MEM_IDX = 10001 AND RETURN_DATE IS NULL;	-- rcnt 가 0일때만 대여가능.
		IF (vcnt = 0) THEN
			DBMS_OUTPUT.put_line('책 대여 가능합니다.');
		ELSE
			DBMS_OUTPUT.put_line('대여 중인 책을 반납해야 가능합니다.');		
		END IF;		-- IF 문 끝낼 때 새미콜론 꼭 쓰기.
	END;
	-- 프로시저 오라클 객체
	CREATE OR REPLACE PROCEDURE CHECK_MEMBER(
			arg_mem IN book_member.MEM_IDX%TYPE,
			isOK OUT varchar2		-- 자바의 리턴값에 해당하는 부분.
	)
	IS 
		vcnt NUMBER;
		vname varchar2(10);
	BEGIN
		-- 입력매개변수가 없는 회원인가를 확인하는 sql과 exception 처리. arg_mem으로 회원테이블에서 name 조회
		-- 없으면 exception 처리
		SELECT name INTO vname
			FROM BOOK_MEMBER bm WHERE MEM_IDX = arg_mem;
		
		SELECT count(*) 
		INTO vcnt
		FROM TBL_BOOKRENT tb 
		WHERE MEM_IDX = arg_mem AND RETURN_DATE IS NULL;	-- rcnt 가 0일때만 대여가능.
		IF (vcnt = 0) THEN
			DBMS_OUTPUT.put_line('책 대여 가능합니다.');
			isOK := '가능';
		ELSE
			DBMS_OUTPUT.put_line('대여 중인 책을 반납해야 가능합니다.');		
			isOK := '불가능';
		END IF;		-- IF 문 끝낼 때 새미콜론 꼭 쓰기.
		EXCEPTION      -- 예외(오류)처리
  		 WHEN no_data_found THEN   
      		DBMS_OUTPUT.PUT_LINE('회원이 아닙니다.'); 
      		isOK := 'no match';
	END;

	-- 프로시저 실행
	DECLARE
		vresult varchar2(20);
	BEGIN
		check_member(10003,vresult);
		DBMS_OUTPUT.put_line('결과 : 	' || vresult);
	END;

-- 10) 도서명 ‘페스트’ 라는 도서가 대출이 가능한지 프로시저를 작성합니다. 프로시저 이름은 check_book 으로.
	
	DECLARE
		v_bcode varchar2(10);
		v_cnt NUMBER;
	BEGIN
		SELECT bcode INTO v_bcode	-- v_bcode는 'A1102'
			FROM TBL_BOOK tb WHERE title = '페스트';
		SELECT count(*) INTO v_cnt
			FROM TBL_BOOKRENT tb2 WHERE BCODE = v_bcode AND return_date IS NULL;
		IF (v_cnt = 1) THEN
			DBMS_OUTPUT.PUT_LINE('대여 중인 책 입니다.');
		ELSE 
			DBMS_OUTPUT.PUT_LINE('책 대여 가능 합니다.');
		END IF;
	END;

	CREATE OR REPLACE PROCEDURE check_book(
		arg_book IN tbl_book.TITLE%TYPE,
		isOK OUT varchar2
	)
	IS 
		v_bcode varchar2(10);
		v_cnt NUMBER;
	BEGIN
		SELECT bcode INTO v_bcode	-- v_bcode는 'A1102'
			FROM TBL_BOOK tb WHERE title = arg_book;
		SELECT count(*) INTO v_cnt
			FROM TBL_BOOKRENT tb2 WHERE BCODE = v_bcode AND return_date IS NULL;
		IF (v_cnt = 1) THEN
			DBMS_OUTPUT.PUT_LINE('대여 중인 책 입니다.');
			isOK := 'FALSE';
		ELSE 
			DBMS_OUTPUT.PUT_LINE('책 대여 가능 합니다.');
			isOK := 'TRUE';
		END IF;
		EXCEPTION      -- 예외(오류)처리
  		 WHEN no_data_found THEN   
      		DBMS_OUTPUT.PUT_LINE('찾는 책이 없습니다.'); 
      		isOK := 'no match';
	END;

-- 프로시저 실행
	DECLARE
		vresult varchar2(10);
	BEGIN
		check_book('푸른사자 와니니',vresult);
		DBMS_OUTPUT.PUT_LINE('결과 : 	' || vresult);
	END;
