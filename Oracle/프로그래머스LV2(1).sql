CREATE TABLE ANIMAL_INS (
	ANIMAL_ID VARCHAR(10) NOT NULL,
	ANIMAL_TYPE VARCHAR(5) NOT NULL,
	DATETIME DATE NOT NULL,
	INTAKE_CONDITION VARCHAR(10) NOT NULL,
	NAME VARCHAR(10),
	SEX_UPON_INTAKE VARCHAR(20) NOT NULL
);

INSERT INTO ANIMAL_INS (ANIMAL_ID,ANIMAL_TYPE,DATETIME,INTAKE_CONDITION,NAME,SEX_UPON_INTAKE)
	VALUES ('A373219','Cat',to_date('2014-07-29 11:43:00','yyyy-mm-dd hh24:mi:ss'),'Normal','Ella','Spayed Female');
INSERT INTO ANIMAL_INS (ANIMAL_ID,ANIMAL_TYPE,DATETIME,INTAKE_CONDITION,NAME,SEX_UPON_INTAKE)
	VALUES ('A377750','Dog',to_date('2017-10-25 17:17:00','yyyy-mm-dd hh24:mi:ss'),'Normal','Lucy','Spayed Female');
INSERT INTO ANIMAL_INS (ANIMAL_ID,ANIMAL_TYPE,DATETIME,INTAKE_CONDITION,NAME,SEX_UPON_INTAKE)
	VALUES ('A354540','Cat',to_date('2014-12-11 11:48:00','yyyy-mm-dd hh24:mi:ss'),'Normal','Tux','Neutered Female');
	
SELECT ANIMAL_TYPE,COUNT(*) count FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE;