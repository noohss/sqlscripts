-- DDL : create, alter, drop, truncate(대상은 user, table, sequence, view, .. 단 truncate는 테이블만 사)
-- DML : insert, update, delete, select

DROP TABLE STUDENTS0 ;	-- 오류 : students0 테이블 먼저 삭제불가
		-- 원인 : 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다.
drop table SCORES0;

-- UPDATE 테이블명 SET 컬럼명 = 값, 컬럼명 = 값, 컬럼명 = 값, .... WHERE 조건컬럼 관계식
-- DELETE FROM 테이블명 WHERE 조건컬럼 관계식
-- 주의 할점 : UPDATE와 DELETE는 WHERE 없이 사용하는 것은 위험한 동작. (경고문 출력)
-- 모든 데이터를 삭제할 때는 DELETE 대신에 TRUNCATE 를 사용한다.
-- truncate는 실행을 취소(rollback)할 수 없기 때문에 DDL에 속한다.
SELECT * FROM STUDENTS0 s ;
-- update, delete, select 에서 where의 컬럼이 기본키 컬럼으로 동등조건이면 실행되는 결과가 반영되는 행은 최대 1개
-- 기본키의 목적은 테이블의 여러 행들을 구분(식별)하는 것
UPDATE STUDENTS0 SET age = 17 WHERE STUNO = 2021001;

-- rollback, commit 테스트 (데이터베이스 메뉴에서 트랜잭션 모드를 manual로 변경)
UPDATE STUDENTS0 SET ADDRESS = '성북구', AGE = 16 WHERE STUNO = 2021001;
ROLLBACK; -- 위의 UPDATE 실행을 취소
SELECT * FROM STUDENTS0 ;	-- 다시 '서초구', 17세로 복구
UPDATE STUDENTS0 SET ADDRESS = '성북구', AGE = 16 WHERE STUNO = 2021001;
COMMIT;
SELECT * FROM STUDENTS0 ;	-- '성북구', 16세로 반영됨.
ROLLBACK;
SELECT * FROM STUDENTS0 ; -- 이미 COMMIT이 된 명령어는 ROLLBACK 불가능.
----------------------------------------------------- 트랜잭션 관리 명령 : ROLLBACK, COMMIT
DELETE FROM SCORES0 ;
ROLLBACK;
SELECT * FROM SCORES0 ;
DELETE FROM SCORES0 WHERE stuno = 2019019;
SELECT * FROM SCORES0 ;
-- 32까지 실행 했을 
-- 이 편집기는 트랜잭션 수동 모드이므로 같은 창에서는 SELECT 결과 2019019가 없다.
-- 다른 편집기는 다른 클라이언트이므로 이전 상태(최종 커밋한 상태)로 보여진다.
ROLLBACK;
SELECT * FROM SCORES0 ;

---------------------------------------------------- 두번째 예시
TRUNCATE TABLE SCORES0 ;		-- 모든 데이터를 지움. ROLLBACK 불가.
-- 모든 데이터를 지울것이 확실하면 다른 것들과 섞여서 롤백되지 않게 확실하게 TRUNCATE 해라.
--------------------------------
/*
 * INSERT
 * DELETE
 * COMMIT;		(1) 라인 44, 45
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2) 라인 47, 48
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3) 라인 50, 51
 * INSERT
 * UPDATE;
 * COMMIT;		(4) 라인 53, 54
 * /