-- 데이터베이스 TRIGGER : INSERT, UPDATE, DELETE할 때 동작하는 프로시저
-- 특정 테이블에 속해 있는 객체

CREATE OR REPLACE TRIGGER SECURE_CUSTOM
BEFORE UPDATE OR DELETE ON TBL_CUSTOM             -- 언제 어떤 테이블에 대해 TRIGGER를 동작시킬지 지정
                                       -- (트리거가 동작하는 테이블, SQL과 시점을 지정)

BEGIN                                 -- 프로시저이기 때문에 BEGIN - END 필요         
   IF TO_CHAR(SYSDATE, 'HH24:MI') BETWEEN '13:00' AND '15:00' THEN
   RAISE_APPLICATION_ERROR(-20000, '오후 1시부터 오후 3시까지는 작업할 수 없습니다.');
   END IF;
END;
-- 트리거 동작 테스트 
DELETE FROM TBL_CUSTOM WHERE CUSTOM_ID = 'twice';

-- 트리거 비활성화 : disable, 활성화 : enable
ALTER TRIGGER secure_custom enable;	-- ALTER TRIGGER 트리거이름 disable;

--	트리거에 필요한 테이블 사전에 생성.
CREATE TABLE tbl_temp
AS
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = '0';

CREATE OR REPLACE TRIGGER cancel_buy
AFTER DELETE ON tbl_buy
FOR EACH ROW		-- 만족(적용)하는 행이 여러개일 때, :OLD UPDATE 또는 DELETE 하기전 값, :NEW 는 INSERT 한 값
BEGIN
   -- 구매 취소(tbl_buy테이블에서 삭제)한 데이터 tbl_temp 임시테이블에 insert : 여러행에 대한 작업(행 트리거)
   INSERT INTO tbl_temp
   VALUES
   (:OLD.custom_id,:OLD.pcode,:OLD.quantity,:OLD.buy_date,:OLD.buyno);  
END;
-- 트리거 동작 테스트 
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';

-- 추가 view 생성 연습
-- grant resource,connect to c##idev	-> 여기에는 view 생성 권한이 없다.
--  		ㄴ grant create view to c##idev; 	-> resource 에 view 생성은 제외이다.
CREATE VIEW v_buy
AS
SELECT tb.CUSTOM_ID , tb.PCODE ,tc.NAME ,tc.EMAIL ,tb.QUANTITY 
FROM TBL_BUY tb , TBL_CUSTOM tc 
WHERE tb.CUSTOM_ID = tc.CUSTOM_ID ;
