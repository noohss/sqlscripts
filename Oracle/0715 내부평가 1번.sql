-- 작성자 : 박상훈

-- 1)
CREATE TABLE tbl_product# (
	pcode varchar2(20) PRIMARY KEY,
	category char(2),
	pname nvarchar2(20) NOT NULL,
	price NUMBER(9) NOT null
);

CREATE TABLE tbl_custom# (
	custom_id varchar2(20) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	email varchar2(30),
	age number(3),
	reg_date timestamp
);	

CREATE TABLE tbl_buy#(
	buy_seq number(8) PRIMARY KEY,
	custom_id varchar2(20),
	pcode varchar2(20),
	quantity number(5) NOT NULL,
	buy_date timestamp,
	FOREIGN KEY (custom_id) REFERENCES tbl_custom#(custom_id),
	FOREIGN KEY (pcode) REFERENCES tbl_product#(pcode)
);

-- 2)
CREATE SEQUENCE tbl_buy_seq START WITH 2001;

-- 3)
CREATE TABLE tbl_postcode(
	postcode char(6) PRIMARY KEY,
	area1 varchar2(200) NOT NULL
);

-- 4)
ALTER TABLE tbl_custom#  ADD postcode char(6);

-- 5)
ALTER TABLE TBL_CUSTOM# ADD CONSTRAINT tbl_custom_fk FOREIGN KEY (postcode) REFERENCES tbl_postcode(postcode);
