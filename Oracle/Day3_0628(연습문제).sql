CREATE TABLE students(
	stuID char(7) PRIMARY KEY,
	name nvarchar2(10) NOT NULL,
	age number(3),
	adress nvarchar2(10)
);

SELECT * FROM  students;

INSERT INTO STUDENTS VALUES (2021001, '김모모', 16, '서초구');
INSERT INTO STUDENTS VALUES (2019019, '강다현', 18, '강남구');

CREATE TABLE scores(
	stuID char(7) NOT NULL,
	subject nvarchar2(10) NOT NULL,
	score NUMBER(3) NOT NULL,
	teacher nvarchar2(10) NOT NULL,
	semester char(6) NOT NULL
);
-- alter table ~ add contraint
ALTER TABLE SCORES ADD CONSTRAINT pk_scores PRIMARY KEY (stuID, subject);
ALTER TABLE SCORES ADD CONSTRAINT fk_scores FOREIGN KEY (stuID) REFERENCES students(stuID);

SELECT * FROM scores;

INSERT INTO SCORES VALUES (2021001, '국어', 89, '이나연', '2022_1');
INSERT INTO SCORES VALUES (2021001, '영어', 78, '김길동', '2022_1');
INSERT INTO SCORES VALUES (2021001, '과학', 67, '박세리', '2021_2');
INSERT INTO SCORES VALUES (2019019, '국어', 92, '이나연', '2019_2');
INSERT INTO SCORES VALUES (2019019, '영어', 85, '박지성', '2019_2');
INSERT INTO SCORES VALUES (2019019, '과학', 88, '박세리', '2020_1');
