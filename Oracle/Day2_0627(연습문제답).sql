-- 직원 테이블 : 직원_id, 이름, 성, 이메일, 전화번호, 고용일자, 업무_id, 급여, 매니저_id, 부서_id

/*
1. hire_date가 2006년 1월 1일 이전인 직원의 이름, 성, 이메일

2. lastname이 'Jones'인 직원의 모든 컬럼

3. salary가 5000 이상인 직원의 이름, 성, job_id 조회

4. job_id에 account가 들어가는 직원의 이름, 성, salary 조회

5. 부서_id가 50, 60, 80, 90인 직원의 직원_id, 이름, 성 조회
*/

-- 1. hire_date가 2006년 1월 1일 이전인 직원의 이름, 성, 이메일
SELECT FIRST_NAME, LAST_NAME, EMAIL FROM EMPLOYEES WHERE HIRE_DATE < '2006-01-01' 

-- 2. lastname이 'Jones'인 직원의 모든 컬럼
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Jones';
-- 대소문자 검사는 조건식에 주의해야 한다.
-- 컬럼값을 대소문자 변환 후 조건값 비교
SELECT * FROM EMPLOYEES WHERE UPPER(LAST_NAME) = 'Jones';   -- 대소문자 무관하게
SELECT * FROM EMPLOYEES WHERE LOWER(LAST_NAME) = 'Jones';   -- 비교하는 방법 두가지

-- 3. salary가 5000 이상인 직원의 이름, 성, job_id 조회
SELECT FIRST_NAME, LAST_NAME, JOB_ID FROM EMPLOYEES WHERE SALARY >= 5000;

-- 4. job_id에 account가 들어가는 직원의 이름, 성, salary 조회
SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID LIKE '%ACCOUNT%';

-- 5. 부서_id가 50, 60, 80, 90인 직원의 직원_id, 이름, 성 조회 : 데이터 타입 변환
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID
IN (50, 60, 80, 90);

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID
IN ('50', '60', '80', '90');
-- 이렇게 써도 되긴 되는데, 되는 이유는 컬럼 형식에 맞게 자동 변환된 것, 작은 따옴표 없는게 올바르다.

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

-- 오늘의 요약 : 숫자 형식, 문자 형식, CREATE TABLE, INSERT INTO, SELECT ~ WHERE ~ 기본 형식
-- 참고 : 별칭(ALIAS), 컬럼 또는 테이블의 이름이 길 때 짧게 줄여서 쓰는 이름.
SELECT * FROM EMPLOYEES e ;      -- EMPLOYEES 테이블의 별칭 e
SELECT * FROM DEPARTMENTS d ;   -- DEPARTMENTS 테이블의 별칭 d
-- 현재까지는 굳이 별칭이 필요하지 않지만, 언젠가는 유용하게 쓰인다.