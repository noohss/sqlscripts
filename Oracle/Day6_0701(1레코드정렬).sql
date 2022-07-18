-- SELECT 기본형식
-- select 컬럼1, 컬럼2.... from 테이블명 where 검색 조건식 
-- order by 기준컬럼 (기본은 오름차순 : asc, 내림차순 : desc)

SELECT * FROM TBL_BUY;	-- INSERT 실행한 순서대로 결과 출력
SELECT * FROM TBL_CUSTOM;
SELECT * FROM TBL_CUSTOM ORDER BY CUSTOM_ID ;
SELECT * FROM TBL_BUY WHERE custom_id = 'mina012';
SELECT * FROM TBL_BUY WHERE custom_id = 'mina012' ORDER BY BUY_DATE DESC;
-- WHERE, ORDER BY 순새대로

-- 조회할 컬럼 지정할 때 distinct 키워드 : 중복값은 1번만 결과 출력.
SELECT custom_id FROM TBL_BUY;	-- 구매고객 ID조
SELECT DISTINCT custom_id FROM TBL_BUY;