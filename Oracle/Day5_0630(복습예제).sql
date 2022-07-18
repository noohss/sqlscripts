-- 작성자 : 박상훈 
CREATE TABLE tbl_custom(
	custom_id varchar2(20) PRIMARY KEY, -- 기본키 설정
	name nvarchar2(20) NOT NULL,
	email varchar2(20),
	age number(30),
	reg_date DATE DEFAULT sysdate
);

-- 상품 테이블 : 카테고리 예시 A1 : 전자제품, B1 : 식품
CREATE TABLE tbl_product(
	pcode varchar2(20) PRIMARY KEY ,
	category char(2) NOT NULL,
	pname nvarchar2(20) NOT NULL,
	price number(9) NOT NULL
);

-- 구매 테이블 : 어느 고객이 무슨 상품을 구입하는가?
CREATE TABLE tbl_buy(
	custom_id varchar2(20) NOT NULL,
	pcode varchar2(20) NOT NULL,
	quantity number(5) NOT NULL, -- 수량
	buy_date DATE DEFAULT sysdate
);
-- Date 형식에 지정되는 패턴 설정하기 -> insert 할 때 to_date 함수 생략가능
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT * FROM TBL_CUSTOM;
INSERT INTO TBL_CUSTOM VALUES ('mina012','김미나','kimm@gmail.com',20,to_date('2022-03-10 14:23:25','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_CUSTOM VALUES ('hongGD','홍길동','gill@korea.com',32,to_date('2021-10-21','YYYY-MM-DD HH24:MI'));
INSERT INTO TBL_CUSTOM VALUES ('twice','박모모','momo@daum.kr',29,to_date('2021-12-25','YYYY-MM-DD HH24:MI'));
INSERT INTO TBL_CUSTOM VALUES ('wonder','이나나','lee@naver.com',40,sysdate);

INSERT INTO TBL_PRODUCT VALUES ('IPAD011','A1','아이패드10','880000');
INSERT INTO TBL_PRODUCT VALUES ('DOWON123a','B1','동원참치선물세트','54000');
INSERT INTO TBL_PRODUCT VALUES ('dk_143','A2','모션데스크','234500');
SELECT * FROM TBL_PRODUCT;

INSERT INTO TBL_BUY VALUES ('mina012','IPAD011',1,to_date('2022-02-06','YYYY-MM-DD HH24:MI'));
INSERT INTO TBL_BUY VALUES ('hongGD','IPAD011',2,to_date('2022-06-29 20:37:47','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_BUY VALUES ('wonder','DOWON123a',3,to_date('2022-02-06','YYYY-MM-DD HH24:MI'));
INSERT INTO TBL_BUY VALUES ('mina012','dk_143',1,sysdate);
INSERT INTO TBL_BUY VALUES ('twice','DOWON123a',2,to_date('2022-02-09 08:49:55','YYYY-MM-DD HH24:MI:SS'));
SELECT * FROM TBL_BUY;

ALTER TABLE TBL_BUY ADD buyNo number(8);

UPDATE TBL_BUY SET buyNO = 1001 WHERE CUSTOM_ID = 'mina012' AND pcode = 'IPAD011';
UPDATE TBL_BUY SET buyNO = 1002 WHERE CUSTOM_ID = 'hongGD' AND pcode = 'IPAD011';
UPDATE TBL_BUY SET buyNO = 1003 WHERE CUSTOM_ID = 'wonder'AND pcode = 'DOWON123a';
UPDATE TBL_BUY SET buyNO = 1004 WHERE CUSTOM_ID = 'mina012' AND PCODE = 'dk_143';
UPDATE TBL_BUY SET buyNO = 1005 WHERE CUSTOM_ID = 'twice' AND pcode = 'DOWON123a';


ALTER TABLE TBL_BUY ADD CONSTRAINT TBL_buy_PK PRIMARY KEY (buyNo);

ALTER TABLE TBL_BUY ADD CONSTRAINT TBL_buy_FK1 FOREIGN KEY (custom_id) REFERENCES tbl_custom(custom_id);
ALTER TABLE TBL_BUY ADD CONSTRAINT TBL_buy_FK2 FOREIGN KEY (pcode) REFERENCES tbl_product(pcode);

CREATE SEQUENCE tblbuy_seq
	START WITH 1006;

INSERT INTO tbl_buy(buyno,custom_id,pcode,quantity,BUY_DATE)
VALUES (tblbuy_seq.nextval,'wonder','IPAD011',1,to_date('2022-05-15','YYYY-MM-DD HH24:MI'));
SELECT * FROM TBL_BUY;

SELECT * FROM TBL_CUSTOM WHERE age >= 30;

SELECT email FROM tbl_custom WHERE CUSTOM_ID = 'twice';

SELECT pname FROM TBL_PRODUCT WHERE category = 'A2';

SELECT MAX(price) FROM TBL_PRODUCT price;

SELECT SUM(quantity) FROM TBL_BUY quantity WHERE pcode = 'IPAD011';

SELECT * FROM TBL_buy WHERE pcode LIKE ('%0%');

SELECT * FROM TBL_BUY WHERE pcode LIKE UPPER('%on%'); 









