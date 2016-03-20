OPTIONS (SKIP=1)
LOAD DATA  
INFILE 'C:\Users\Public\Documents\REPRO1.csv' 
INTO TABLE REPRODUCCION REPLACE FIELDS TERMINATED BY ',' optionally enclosed by '"'  TRAILING NULLCOLS
(USERID,
MUSICA,
FECHA "to_char(sysdate,'DD/MM/YYYY')"  ,
HORA    "to_char(sysdate,'HH:MI:SS')"
)