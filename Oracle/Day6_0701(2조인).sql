-- 예제. custom_id 'mina012'이 구매한 내용 조회 : pcode 조회하고 pname은 알 수 없음.
SELECT pcode FROM TBL_buy WHERE custom_id = 'mina012';

-- 1. 서브쿼리 (select안에 select를 사용함.)
SELECT pname FROM TBL_PRODUCT		-- 외부쿼리
	WHERE pcode = 				-- 조건식이 = 연산이므로 내부 쿼리는 1개 행 결과이어야 함.
	(SELECT pcode FROM TBL_BUY WHERE custom_id = 'mina012'
							AND buy_date = '2022-2-6');	-- 내부쿼리
							
SELECT pname FROM TBL_PRODUCT
	WHERE pcode =
	(SELECT pcode FROM TBL_BUY WHERE custom_id = 'mina012' AND buy_date = '2022-2-6');
	
SELECT pname FROM TBL_PRODUCT
	WHERE pcode IN 				-- 조건식이 IN 연산이므로 내부쿼리는 여러개 행 결과 가능.
	(SELECT pcode FROM TBL_BUY WHERE custom_id = 'mina012');
	
-- 테스트
SELECT pcode FROM TBL_BUY WHERE custom_id ='mina012' -- 내부쿼리
						AND buy_date = '2022-2-6';
						
SELECT pcode FROM TBL_BUY WHERE custom_id = 'mina012';

-- 서브쿼리 문제점 : 외부쿼리가 조건식을 모든행에 대해 검사할 때마다 내부쿼리가 실행되므로		
--				처리 속도에 문제가 생긴다. --> 테이블의 조인 연산 사용으로 개선

-- 2. SELECT 의 JOIN : 둘 이상의 테이블(주로 참조관계의 테이블)을 연결하여 데이터를 조회하는 명령
-- 동등 join : 둘 이상의 테이블은 공통된 컬럼을 갖고 이 컬럼값이 '같다(=)'를 이용하여 join 한다.
-- 형식1 : select ~~~ from 테이블1 a, 테이블2 b
--						where a.공통컬럼1=b.공통컬럼1;

-- 예제를 위해 상품 추가
INSERT INTO TBL_PRODUCT VALUES ('GALAXYS22','A1','갤럭시s22',555600);

-- JOIN 키워드 없는 형식1
SELECT * FROM TBL_PRODUCT tp , TBL_BUY tb 	-- join 할 테이블 2개
		WHERE tp.PCODE = tb.PCODE ;  		-- 동등 join.join 컬럼으로 = 연산식.

-- JOIN 키워드를 쓰는 명령문 형식2(ANSI 표준)
SELECT * FROM TBL_PRODUCT tp 
		JOIN TBL_BUY tb 
		ON tp.PCODE = tb.PCODE ;			-- 동등 join.join 컬럼으로 = 연산식.
	
-- 간단 테스트 : tbl_custom 과 tbl_buy 를 join
-- 형식 1
SELECT * FROM TBL_CUSTOM tc , TBL_BUY tb 
		WHERE tc.CUSTOM_ID = tb.CUSTOM_ID ;
	
-- 형식 2
SELECT * FROM TBL_CUSTOM tc JOIN TBL_BUY tb ON tc.CUSTOM_ID = tb.CUSTOM_ID ;

-- mina012 가 구매한 상품명은 무엇인가 조회하기
SELECT tp.pname FROM TBL_PRODUCT tp , TBL_BUY tb 
		WHERE tp.PCODE = tb.PCODE AND custom_id = 'mina012';

SELECT tc.custom_id,name,reg_date,pcode,quantity FROM TBL_CUSTOM tc , TBL_BUY tb
		WHERE tc.CUSTOM_ID = tb.CUSTOM_ID AND tc.CUSTOM_ID = 'mina012';
	
-- mina012 가 구매한 상품명과 가격 조회하기
SELECT tp.pname,tp.price FROM TBL_PRODUCT tp , TBL_BUY tb 
		WHERE tp.PCODE = tb.PCODE AND custom_id 'mina012';
	
-- mina012 가 구매한 상품명은 무엇인가 조회하기
SELECT tp.pname FROM TBL_PRODUCT tp , TBL_BUY tb 
		WHERE tp.PCODE = tb.PCODE AND custom_id = 'mina012';
	
SELECT tp.pname FROM TBL_PRODUCT tp JOIN TBL_BUY tb
		ON tp.PCODE = tb.PCODE AND custom_id = 'mina012';

SELECT tp.pname FROM TBL_PRODUCT tp JOIN TBL_BUY tb
		ON tp.PCODE = tb.PCODE AND custom_id = 'mina012' AND buy_date = '2022-2-6';
	
-- mina012 가 구매한 상품명과 가격 조회하기
SELECT tp.pname, tp.price FROM TBL_PRODUCT tp , TBL_BUY tb 
		WHERE tp.PCODE =tb.PCODE AND custom_id = 'mina012';

-- join 할 때, 이름이 같은 컬럼은 테이블명을 꼭 지정해야 한다.
	
-- 3개의 테이블을 join 할 수 있을까?
SELECT * FROM TBL_PRODUCT tp,
	(SELECT tc.custom_id cusid, name, email, age, reg_date, pcode, quantity, buy_date, buyno
		FROM TBL_CUSTOM tc , TBL_BUY tb
		WHERE tc.CUSTOM_ID = tb.CUSTOM_ID) temp	-- 첫번째 조인
WHERE tp.PCODE = temp.pcode;

-- 특정 컬럼만 조회하기
SELECT tb.CUSTOM_ID, tb.PCODE, name, age, pname, QUANTITY, BUY_DATE 
		FROM TBL_BUY tb , TBL_CUSTOM tc ,TBL_PRODUCT tp
		WHERE tb.CUSTOM_ID = tc.CUSTOM_ID AND tb.PCODE = tp.PCODE;

-- 3. 외부 join(outer join) : = 연산을 사용하는 join 이나 한쪽에 없는 값도 join 결과로 포함.

-- JOIN 키워드 없는 형식1
SELECT * FROM TBL_PRODUCT tp , TBL_BUY tb
		WHERE tp.PCODE = tb.PCODE(+) ;  		
		-- 외부조인 tbl_buy 테이블에 일치하는 pcode 값이 없어도 join. join 했을 때 null이 되는 테이블의 컬럼에 (+) 표기

-- JOIN 키워드를 쓰는 명령문 형식2(ANSI 표준)
SELECT * FROM TBL_PRODUCT tp 		-- 참조관계 일 때 부모테이블이 왼쪽에 있을 경우 LEFT OUTER JOIN 오른쪽일 경우 RIGHT OUTER JOIN
		LEFT OUTER JOIN TBL_BUY tb 
		ON tp.PCODE = tb.PCODE ;			-- TBL_PRODUCT 가 왼쪽 테이블이며 그 값을 모두 포함하여 join
		
SELECT * FROM TBL_BUY tb 
		RIGHT OUTER JOIN TBL_PRODUCT tp 
		ON tb.PCODE = tp.PCODE ;
	