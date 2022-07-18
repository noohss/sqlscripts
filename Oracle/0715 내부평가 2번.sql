-- 작성자 : 박상훈

-- TBL_CUSTOM# 테이블
INSERT INTO TBL_CUSTOM# (custom_id,name,email,age,reg_date) VALUES ('mina012','김미나','kimm@gmial.com',20,'2022-02-07 15:03:06');
INSERT INTO TBL_CUSTOM# (custom_id,name,email,age,reg_date) VALUES ('hongGD','홍길동','gil@korea.com',32,'2022-02-07 15:03:06');
INSERT INTO TBL_CUSTOM# (custom_id,name,email,age,reg_date) VALUES ('twice','박모모','momo@daum.net',39,'2022-02-05');
INSERT INTO TBL_CUSTOM# (custom_id,name,email,age,reg_date) VALUES ('wonder','이나나','nana@korea.kr',23,'2022-02-05');
INSERT INTO TBL_CUSTOM# (custom_id,name,email,age,reg_date) VALUES ('sana','최사나','unknown',22,'2022-02-09');
SELECT * FROM TBL_CUSTOM# tc; 

-- TBL_PRODUCT# 테이블
INSERT INTO TBL_PRODUCT# (pcode,category,pname,price) VALUES ('CJ-BABQ1','B1','CJ햇반잡곡밥SET',26000);
INSERT INTO TBL_PRODUCT# (pcode,category,pname,price) VALUES ('DOWON123a','B1','동원참치선물세트',54000);
INSERT INTO TBL_PRODUCT# (pcode,category,pname,price) VALUES ('dk_143','A2','모션데스크',234500);
INSERT INTO TBL_PRODUCT# (pcode,category,pname,price) VALUES ('IPAD011','A1','아이패드10',880000);
INSERT INTO TBL_PRODUCT# (pcode,category,pname,price) VALUES ('GAL0112','A1','갤럭시20',912300);
INSERT INTO TBL_PRODUCT# (pcode,category,pname,price) VALUES ('CHR-J59','A2','S체어',98700);
SELECT * FROM TBL_PRODUCT# tp; 

-- TBL_BUY# 테이블
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (29,'mina012','IPAD011',1,'2022-02-06');
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (30,'hongGD','IPAD011',2,'2022-02-08 15:55:08');
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (31,'wonder','DOWON123a',3,'2022-02-06');
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (32,'mina012','dk_143',1,'2022-02-08 15:55:08');
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (33,'twice','DOWON123a',2,'2022-02-07');
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (63,'hongGD','dk_143',1,'2022-02-11');
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (61,'twice','CHR-J59',2,'2022-02-12');
INSERT INTO TBL_BUY# (buy_seq,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE) VALUES (62,'hongGD','CJ-BABQ1',4,'2022-02-11');
SELECT * FROM TBL_BUY# tb; 

-- 1)
SELECT * FROM TBL_BUY# tb WHERE BUY_DATE >= '2022-02-11';

-- 2)
SELECT pcode,pname,price FROM TBL_PRODUCT#
WHERE price = (SELECT MAX(price)  FROM TBL_PRODUCT#);


-- 3)
SELECT category,MAX(price) FROM TBL_PRODUCT# tp 
GROUP BY CATEGORY
ORDER BY CATEGORY;

-- 4)
SELECT tb.custom_id,name,quantity FROM TBL_BUY# tb 
JOIN TBL_CUSTOM# tc ON tb.CUSTOM_ID = tc.CUSTOM_ID 
AND tb.PCODE = 'IPAD011';

-- 5)
SELECT tc.CUSTOM_ID,tc.NAME,AGE FROM TBL_CUSTOM# tc 
LEFT OUTER JOIN TBL_BUY# tb
ON tc.CUSTOM_ID = tb.CUSTOM_ID
WHERE tb.CUSTOM_ID IS NULL;

-- 6)
SELECT to_char(buy_date,'yyyy-mm-dd')"BUY_DATE2", SUM(price * QUANTITY)"SUM(MONEY)" 
FROM TBL_BUY# tb JOIN TBL_PRODUCT# tp 
ON tb.PCODE = tp.PCODE 
GROUP BY BUY_DATE
ORDER BY BUY_DATE;