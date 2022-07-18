/*
 * 날짜와 시간 데이터 형식
 * Date : 일반형식. 초단위까지 표시
 * Timestamp : 표준시를 기준으로 하는 timezone 표시할수 있고 . 
 * 			  나노(초이하 9자리)초 까지 표시 가능
 * 
 * 일반적으로는 date와 timestmap
 */


SELECT SYSDATE , 		-- 서버의 Date
		CURRENT_DATE ,	-- 클라이언트의 Date
		SYSTIMESTAMP ,	-- 서버의 timestamp
		CURRENT_TIMESTAMP   -- 클라이언트의 timestamp
FROM dual;


DROP TABLE tbl_date;
CREATE TABLE tbl_date(
	acol DATE DEFAULT sysdate,
	bcol DATE DEFAULT systimestamp,
	ccol timestamp(9) ,
	dcol timestamp DEFAULT systimestamp,
	ecol timestamp WITH TIME ZONE DEFAULT systimestamp
	-- 값을 지정안했을 때 기본값(default) :sysdate 는 현재 날짜/시간(서버)
	-- 클라이언트 컴퓨터의 시간은 current_date 
);

INSERT INTO tbl_date(ccol) 
VALUES (to_timestamp('2022-07-12 14:46:00.123456789', 'yyyy-mm-dd hh24:mi:ss.ff')  );

SELECT * FROM tbl_date;


INSERT INTO tbl_date(acol,ccol)
VALUES ('2022-10-11','2022-10-12');		-- DATE, timestamp 차이가 없다.

-- GMT, UTC 표준시간의 차이

-- 날짜형식은 문자열 'yyyy-MM-dd' 과 자동캐스팅이 됩니다.
-- date와 timestamp 모두 to_char 함수는 동일하게 사용가능.