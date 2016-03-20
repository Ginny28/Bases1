

-------------- CONSULTA 1 ---------------------
select DISTINCT GENERO , count(*) as TOTAL  from cancion group by genero
having  
count(*) = (select MAX(count(*))   from cancion group by genero)  OR  
count(*) = (select MIN(count(*))   from cancion group by genero) ;


-------------- CONSULTA 2 ---------------------

SELECT P.PAIS ,P.counts  AS GENEROS FROM  (Select  F.PAIS, count (*) as counts   from (select distinct  ar.pais, ca.GENERO  from artista ar   inner join  cancion ca 
                        on  ar.nombre = ca.artista AND ca.GENERO IS NOT NULL  ORDER BY AR.PAIS )  F  
                        GROUP BY F.pais  ) P  WHERE P.counts =  (SELECT MAX(PS.COUNTS) FROM  (
                        Select  FS.PAIS, count (*) as counts   from (select distinct  ar.pais, ca.GENERO  from artista ar   inner join  cancion ca 
                        on  ar.nombre = ca.artista AND ca.GENERO IS NOT NULL  ORDER BY AR.PAIS )  FS  
                        GROUP BY FS.pais  ) PS)



-------------- CONSULTA 3 --------------------

Select distinct GENERO FROM CANCION WHERE 
ARTISTA = 'Ricchi e Poveri' AND GENERO IS NOT NULL;


-------------- CONSULTA 4 --------------------

select distinct  ar.pais   from artista ar   inner join  cancion ca 
                        on  ar.nombre = ca.artista AND ca.GENERO IS NOT NULL   WHERE  ca.GENERO = 'Pop'   ORDER BY AR.PAIS;


-------------- CONSULTA 5 --------------------

select distinct   ca.GENERO   from artista ar   inner join  cancion ca 
                        on  ar.nombre = ca.artista AND ca.GENERO IS NOT NULL   WHERE  ar.pais = 'Mexico'   ORDER BY AR.PAIS;


-------------- CONSULTA 6 --------------------
            
     SELECT * FROM  (  SELECT T1.artista, count(T1.album) as ALBUNS  from 
                      (select  distinct artista,album  from cancion   where album is not null  order by artista) T1  
                      GROUP BY T1.ARTISTA ORDER BY count(T1.album) DESC ) WHERE ROWNUM <=10

-------------- CONSULTA 7 --------------------
SELECT  T2.NOMBRE,T2.ANIOS,T2.GEN  FROM (
SELECT    T1.nombre, T1.ANIOS, COUNT(T1.GENERO) AS GEN  from
                        (SELECT DISTINCT AR.NOMBRE , AR. ANIOS , CA.GENERO  FROM ARTISTA  AR  INNER JOIN  CANCION CA ON  LENGTH(ANIOS) = 5 
                        AND  AR.NOMBRE = CA.ARTISTA  AND  CA.GENERO IS NOT NULL  ) T1  
                        GROUP BY T1.NOMBRE,T1.ANIOS  ) T2 
WHERE T2.GEN >= 2
ORDER BY T2.GEN DESC

---------------------  CONSULTA 8 -------------------
SELECT  ALBUM , SUM( DATEPART(MINUTE,DURACION))  FROM  CANCION   WHERE  ALBUM = 'Happy Nation' GROUP BY ALBUM;

---------------------  CONSULTA 9 -------------------

SELECT  T2.ARTISTA, T2.GEN  FROM 
              ( SELECT  T1.ARTISTA , COUNT(T1.GENERO) AS GEN  FROM 
                              ( SELECT DISTINCT ARTISTA,  GENERO  FROM CANCION  WHERE  GENERO  IS NOT NULL ORDER BY ARTISTA ) T1
              GROUP BY  T1.ARTISTA) T2 
              WHERE  T2.GEN = (  SELECT MAX( T4.GEN)  FROM     (SELECT  T3.ARTISTA , COUNT(T3.GENERO) AS GEN  FROM 
                                                             ( SELECT DISTINCT ARTISTA,  GENERO  FROM CANCION  WHERE  GENERO  IS NOT NULL ORDER BY ARTISTA ) T3
                                                              GROUP BY  T3.ARTISTA) T4);



------------------------ CONSULTA 10 ------------------

SELECT  DISTINCT AR.NOMBRE , AR.ANIOS, CA.GENERO  FROM ARTISTA  AR  INNER JOIN  CANCION CA ON  LENGTH(ANIOS) = 5 
                       AND  AR.NOMBRE = CA.ARTISTA  AND  CA.ALBUM IS NOT NULL 
                       where 
                       CA.GENERO IN ( SELECT  T1.GENERO FROM   ( select distinct  ar.pais, ca.GENERO, count (ca.NOMBRE ) CANCIONES  from artista ar   inner join  cancion ca 
                         on  ar.nombre = ca.artista AND ca.GENERO IS NOT NULL   WHERE  ar.pais = 'USA' GROUP BY ar.pais,ca.genero ORDER BY  count(ca.NOMBRE) DESC ) T1 WHERE ROWNUM <=2 ) 
                        ORDER BY AR.NOMBRE
                        
 






