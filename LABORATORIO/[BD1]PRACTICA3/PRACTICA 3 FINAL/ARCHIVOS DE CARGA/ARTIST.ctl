OPTIONS (SKIP=1)
LOAD DATA  
INFILE 'C:\Users\Public\Documents\ARTISTA.csv' 
INTO TABLE ARTISTA REPLACE FIELDS TERMINATED BY ',' 
(NOMBRE,PAIS,ANIOS)