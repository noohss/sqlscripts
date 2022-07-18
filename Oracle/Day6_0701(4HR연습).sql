-- HR 스키마를 이용하여 join과 group by 를 포함해서 select 로 검색하는 문제를 만들기
-- group by 결과로도 조인을 할 수 있다. 예시 부서 인원이 가장 많은 부서는?

-- 주석으로 검색하는 내용쓰고
-- select 쿼리 작성
-- 작성자 : 박상훈 

-- 1. 국가 ID가 US인 지점ID와 도로 주소 조회

-- 2. IT부서 직원들의 ID와 성, 휴대폰 번호 조회

-- 3. 각 지점의 우편번호와 지역명, 국가명 조회(우편번호가 NULL값인 지점 제외, 지역ID 오름차순 기준으로 조회)

-- 4. 성에 'da'가 포함된 직원들의 ID, 이메일, 업무명, 급여 조회(대소문자 구별없이 조회, 직원ID 내림차순으로)
	
-- 5. 급여가 3000이하인 직원들의 부서ID를 그룹화하여 해당 부서의 직원 수 조회

-- 6. 'IT_PROG','FI-ACCOUNT' 업무를 맡은 부서의 ID를 그룹화하여 해당 부서에 소속된 직원의 수 조회

-- 7. 커미션이 0.25이상인 직원들의 업무ID를 그룹화하여 해당 업무를 맡은 직원의 수와 최고급여 조회

-- 8. 급여가 5000이상인 직원들의 부서명을 그룹화하여 각 부서의 평균급여가 8000이하인 부서만 조회
-- 					(해당 직원이 소속된 부서가 없을경우(null일 경우) 해당 부서만 제외하고 출력)

-- 9. IT, Sales, Marketing부서에 속한 직원들의 수와 고용날짜 중 가장 빠른 날짜 조회

-- 10. 업무명에 'Clerk'이 포함된 업무를 맡은 직원의 수와 평균급여 조회

-- 부서별 평균급여를 조회. 정렬은 평균급여 내림차순으로 부서ID, 부서명, 평균급여(소수점 1자리로 반올림)
-- 오라클 소수점 관련 함수 : round(반올림), trunc(버림), ceil(내림)

-- 그룹함수 조회할 때 group by를 써야 그룹바이에 쓴 컬럼을 select 로 조회할 수 있다.
--		그불바이 컬럼외에는 다른 컬럼 select 할 수 없다. -> join, 서브쿼리

-- 1단계 : 사용할 그룹함수 실행
SELECT DEPARTMENT_ID, avg(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID;

-- 2단계 : 조인하기
SELECT * FROM DEPARTMENTS d JOIN
		(SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
		ON d.DEPARTMENT_ID = tavg.department_ID;

-- 3단계 : 컬럼 지정하기
SELECT d.department_id, d.department_name, round(tavg.cavg,1) FROM DEPARTMENTS d 
	JOIN
	(SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID
	ORDER BY tavg.cavg DESC;

-- 4단계 : 정렬한 결과로 특정 위치 지정 : first n은 상위 n개를 조회
SELECT d.DEPARTMENT_ID, d.DEPARTMENT_NAME , round(tavg.cavg,1) "평균급여" FROM DEPARTMENTS d 
	JOIN
	(SELECT DEPARTMENT_ID, AVG(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID
	ORDER BY tavg.cavg DESC
	FETCH FIRST 1 ROWS ONLY;		-- 실행 안됨. 오라클 12c 버전부터 사용한다.

-- 오라클의 rownum은 가상의 컬럼으로 조회된 결과에 순차적으로 오라클이 부여하는 값이다.
--					가상 컬럼 사용을 위해 join이 한번 더 필요하다.
SELECT rownum, tcnt.* FROM 
(SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
WHERE rownum < 5;

	SELECT rownum rn, tcnt.* FROM 
		(SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
WHERE rownum < 1;

SELECT * FROM
	(SELECT rownum rn, tcnt.* FROM 
		(SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt)
WHERE rn = 3;
-- rownum 사용할 때 결과 확인이 안되는 예시 : rownum 1부터 시작해서 찾아갈 수 있는 조건식만 가능.
-- WHERE rownum = 3;
-- WHERE rownum > 5;
-- 그래서 한번더 ROWNUM 을 포함한 조회 결과로 select 한다. 이때 ROWNUM 은 별칭 부여.

SELECT * FROM
	SELECT rownum rn, tcnt.* FROM 
		(SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
WHERE rn BETWEEN 5 AND 9;
-- WEHRE rn = 3;



