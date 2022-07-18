-- 작성자 : 박상훈

-- 1)
INSERT INTO TBL_POSTCODE (postcode,AREA1) VALUES ('137964','서울특별시 서초구 서초2동');
INSERT INTO TBL_POSTCODE (postcode,AREA1) VALUES ('138761','서울특별시 송파구 장지동 409880');
INSERT INTO TBL_POSTCODE (postcode,AREA1) VALUES ('412510','경기도 고양시 덕양구 벽제동');
INSERT INTO TBL_POSTCODE (postcode,AREA1) VALUES ('409880','인천광역시 옹진군 자월면');
SELECT * FROM TBL_POSTCODE tp;

-- 2)
UPDATE TBL_CUSTOM#  SET postcode = '137964' WHERE CUSTOM_ID = 'mina012';
UPDATE TBL_CUSTOM#  SET postcode = '412510' WHERE CUSTOM_ID = 'hongGD';
UPDATE TBL_CUSTOM#  SET postcode = '409880' WHERE CUSTOM_ID = 'wonder';
UPDATE TBL_CUSTOM#  SET postcode = '138761' WHERE CUSTOM_ID = 'sana';
SELECT * FROM TBL_CUSTOM# tc;

-- 3)
CREATE VIEW v_custom_info
AS 

SELECT custom_id,tc.postcode,area1 
FROM TBL_CUSTOM# tc, TBL_POSTCODE tp
WHERE tc.postcode = tp.POSTCODE;

SELECT * FROM v_custom_info;