-- 주제 : 행을 그룹화 하기. 사용하는 순서는 아래처럼
-- select 문
-- [WHERE] 그룹화 하기 전에 사용할 조건식
-- GROUP BY 그룹화에 사용할 컬럼명
-- [HAVING] 그룹화 결과에 대한 조건식
-- [ORDER BY] 그룹화 결과 정렬할 컬럼명과 방식


SELECT PCODE, count(*) FROM TBL_BUY tb GROUP BY PCODE ;
SELECT PCODE, count(*) ,sum(quantity) 
	FROM TBL_BUY tb
	GROUP BY PCODE
	ORDER BY 2;		-- 조회된 컬럼의 위치

SELECT PCODE, count(*) cnt ,sum(quantity) total
	FROM TBL_BUY tb
	GROUP BY PCODE
	ORDER BY cnt;	-- 그룹함수 결과의 별칭
	
-- 그룹화 후에 수량 합계가 3 이상만 조회	
	SELECT PCODE, count(*) cnt ,sum(quantity) total
	FROM TBL_BUY tb
	GROUP BY PCODE
--	HAVING total >= 3		-- having 에는 컬럼 별칭 사용 못함. 테이블 컬럼명은 사용할 수 있음.
	HAVING sum(QUANTITY) >=3
	ORDER BY cnt;

-- 구매 날짜 2022-04-01 이후인 것만 그룹화하여 조회
SELECT PCODE, count(*) cnt ,sum(quantity) total
	FROM TBL_BUY tb
	WHERE BUY_DATE >= '2022-04-01'
	GROUP BY PCODE
	ORDER BY cnt;

-- Day2 참고
-- 통계함수 : count, avg, max, min, sum ==> 그룹함수라고도 한다.
--         해당 함수 결과값을 구하기 위해 특정 컬럼을 사용하여 여러 데이터를 그룹화한 후 실행한다.

SELECT COUNT(*) FROM EMPLOYEES e;      -- 테이블 전체 데이터의 개수 확인 : 107
SELECT MAX(SALARY) FROM EMPLOYEES e;   -- salary 컬럼의 최댓값 : 24000
SELECT MIN(SALARY) FROM EMPLOYEES e;   -- salary 컬럼의 최솟값 : 2100
SELECT AVG(SALARY) FROM EMPLOYEES e;   -- salary 컬럼의 평균값 : 6461.83 ...  
SELECT SUM(SALARY) FROM EMPLOYEES e;   -- salary 컬럼의 합계 : 691416

-- 위 5개 통계함수를 JOB_ID = 'IT_PROG' 값을 조건식으로 똑같이 실행해보기
SELECT COUNT(*) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';   -- 데이터의 개수 확인 : 5
SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';   -- 최댓값 : 9000
SELECT MIN(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';   -- 최솟값 : 4200
SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';   -- 평균값 : 5760
SELECT SUM(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';   -- 합계 : 28800
-- 함수의 의미를 파악하자. (이 함수는 어디에 쓸 수 있지?)

-- 통계함수 결과는 다른 컬럼값과 같이 조회할 수 없다. (그룹함수이기 때문)
SELECT JOB_ID, COUNT(*) FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';      -- 오류 : 단일 그룹의 그룹 함수가 아니다.