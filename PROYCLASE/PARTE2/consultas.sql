---------------CONSULTA 1 ------------------------
SELECT ORDERID,SUM(PRICE*QUANTITY) AS TOTALPRICE 
FROM ORDEN
GROUP BY ORDERID ORDER BY TOTALPRICE DESC
LIMIT 1;

 --------------CONSULTA 2------------------------

SELECT  C.CUSTOMERID,C.FIRSTNAME,SUM(O.PRICE* O.QUANTITY) AS TOTALPRICE
FROM ORDEN O , CLIENTE C WHERE C.CUSTOMERID = O.CUSTOMERID
GROUP BY C.CUSTOMERID,C.FIRSTNAME
ORDER BY TOTALPRICE DESC
LIMIT 1;


 ------------- CONSULTA 3 ----------------------

SELECT C.COUNTRY_ID,CO.COUNTRY,SUM(O.QUANTITY*O.PRICE) AS TOTALPRICE FROM ORDEN O,CLIENTE C,PAIS CO
WHERE O.CUSTOMERID= C.CUSTOMERID AND C.COUNTRY_ID = CO.COUNTRY_ID
GROUP BY C.COUNTRY_ID,CO.COUNTRY
ORDER BY TOTALPRICE 
LIMIT 1;



---------- CONSULTA 4 ----------
SELECT CUSTOMERID,COUNT(ORDERID)AS ORDENES,SUM(TOTALPRICE)AS TOTAL FROM(
SELECT O.ORDERID,O.CUSTOMERID,SUM(O.QUANTITY*O.PRICE) AS TOTALPRICE FROM ORDEN O,CLIENTE C
WHERE O.CUSTOMERID= C.CUSTOMERID AND C.COUNTRY_ID = 11
GROUP BY O.CUSTOMERID,O.ORDERID) T1
GROUP BY CUSTOMERID 
ORDER BY TOTAL DESC


---------- CONSULTA 5 ----------------------


SELECT  EXTRACT(MONTH FROM orderdate)AS MONTHS,SUM(QUANTITY*PRICE) AS TOTAL FROM ORDEN
GROUP BY MONTHS
ORDER BY TOTAL DESC 
LIMIT 1;



----------- CONSULTA 6 ----------------------
SELECT  EXTRACT(DAY FROM orderdate)AS DAYS,SUM(QUANTITY*PRICE)AS TOTAL FROM ORDEN
GROUP BY DAYS
ORDER BY TOTAL DESC
LIMIT 5; 



----------- CONSULTA 7 ----------------------
SELECT  EXTRACT(DAY FROM orderdate)AS DAYS,AVG(QUANTITY*PRICE)AS TOTAL FROM ORDEN
GROUP BY DAYS
ORDER BY TOTAL DESC 
LIMIT 5;



------------------CONSULTA 8 ---------------------------------------
SELECT C.CATEGORYNAME , LT.SUM AS TOTAL   FROM (
SELECT T1.CATEGORY,T1.SUM FROM (
SELECT SUM(O.PRICE * O.QUANTITY),P.CATEGORY FROM 
ORDEN O, PRODUCTO P
WHERE P.PROD_ID = O.PROD_ID 
GROUP BY P.CATEGORY) AS T1
WHERE T1.SUM = (SELECT MAX(T2.SUM) FROM(SELECT SUM(O.PRICE * O.QUANTITY) 
FROM ORDEN O, PRODUCTO P WHERE P.PROD_ID = O.PROD_ID GROUP BY P.CATEGORY)T2 ) OR  
T1.SUM =(SELECT MIN(T2.SUM) FROM(SELECT SUM(O.PRICE * O.QUANTITY),P.CATEGORY FROM 
ORDEN O, PRODUCTO P WHERE P.PROD_ID = O.PROD_ID 
GROUP BY P.CATEGORY)T2 ))LT , CATEGORIA C  
WHERE LT.CATEGORY = C.CATEGORY;

------------------ CONSULTA 9 --------------------------------
SELECT COUNTRY_ID,COUNTRY,TOTALPRICE FROM (
SELECT C.COUNTRY_ID,CO.COUNTRY,SUM(O.QUANTITY*O.PRICE) AS TOTALPRICE 
FROM ORDEN O,CLIENTE C,PAIS CO
WHERE O.CUSTOMERID= C.CUSTOMERID AND C.COUNTRY_ID = CO.COUNTRY_ID
GROUP BY C.COUNTRY_ID,CO.COUNTRY
ORDER BY TOTALPRICE ) AS T
WHERE T.TOTALPRICE IN (
SELECT MIN(T1.TOTALPRICE) FROM(
SELECT C.COUNTRY_ID,CO.COUNTRY,SUM(O.QUANTITY*O.PRICE) AS TOTALPRICE 
FROM ORDEN O,CLIENTE C,PAIS CO
WHERE O.CUSTOMERID= C.CUSTOMERID AND C.COUNTRY_ID = CO.COUNTRY_ID
GROUP BY C.COUNTRY_ID,CO.COUNTRY)T1
UNION 
SELECT MAX(T1.TOTALPRICE) FROM(
SELECT C.COUNTRY_ID,CO.COUNTRY,SUM(O.QUANTITY*O.PRICE) AS TOTALPRICE 
FROM ORDEN O,CLIENTE C,PAIS CO
WHERE O.CUSTOMERID= C.CUSTOMERID AND C.COUNTRY_ID = CO.COUNTRY_ID
GROUP BY C.COUNTRY_ID,CO.COUNTRY)T1)



----------------- CONSULTA 10 --------------------------------
SELECT  T.COUNTRY ,T.MONTHS, SUM(T.QUANTITY * T.PRICE) AS TOTAL FROM (
SELECT O.ORDERID,O.QUANTITY,O.PRICE,EXTRACT(MONTH FROM O.ORDERDATE)AS MONTHS,P.COUNTRY_ID,P.COUNTRY 
FROM ORDEN O,CLIENTE C,PAIS P WHERE O.CUSTOMERID = C.CUSTOMERID  AND 
C.COUNTRY_ID = P.COUNTRY_ID AND C.COUNTRY_ID = (SELECT COUNTRY_ID FROM PAIS WHERE COUNTRY='Chile'))T
WHERE T.MONTHS IN (SELECT DISTINCT EXTRACT(MONTH FROM ORDERDATE) AS MONTHS FROM ORDEN ORDER BY MONTHS ASC)
GROUP BY T.COUNTRY,T.MONTHS
ORDER BY T.MONTHS ASC;

----------------- CONSULTA 11 --------------------------------
SELECT T.COUNTRY,T.YEARS,SUM(T.QUANTITY*T.PRICE)AS TOTAL FROM (
SELECT C.COUNTRY_ID,PA.COUNTRY, O.QUANTITY,O.PRICE,P.CATEGORY,
EXTRACT(YEAR FROM O.ORDERDATE)AS YEARS FROM ORDEN O,PRODUCTO P,CLIENTE C,PAIS PA 
WHERE O.PROD_ID = P.PROD_ID AND O.CUSTOMERID = C.CUSTOMERID AND C.COUNTRY_ID = PA.COUNTRY_ID 
AND P.CATEGORY = (SELECT CATEGORY FROM CATEGORIA WHERE CATEGORYNAME = 'Comedy')) T
WHERE T.COUNTRY_ID IN(SELECT COUNTRY_ID FROM PAIS) AND T.YEARS =( SELECT DISTINCT 
EXTRACT (YEAR FROM ORDERDATE)AS ANIO FROM ORDEN)
GROUP BY T.COUNTRY,T.YEARS

----------------  CONSULTA 12 ---------------------------
SELECT  T1.VENDOR_NAME,T1.CATEGORYNAME ,T1.MONTHS,SUM (T1.PRICE * T1.QUANTITY)AS TOTAL FROM (
SELECT V.VENDOR_NAME ,C.CATEGORYNAME, O.QUANTITY ,O.PRICE,EXTRACT(MONTH FROM O.ORDERDATE)AS MONTHS 
FROM ORDEN O ,PRODUCTO P,CATEGORIA C , VENDEDOR V WHERE O.PROD_ID = P.PROD_ID  AND O.VENDOR_ID = 1 AND
P.CATEGORY = (SELECT category from CATEGORIA WHERE categoryname = 'Sports') AND P.CATEGORY = C.CATEGORY
AND O.VENDOR_ID = V.VENDOR_ID )T1 
WHERE  T1.MONTHS IN (SELECT DISTINCT EXTRACT(MONTH FROM ORDERDATE) AS MONTHS FROM ORDEN ORDER BY MONTHS ASC)
GROUP BY T1.VENDOR_NAME,T1.CATEGORYNAME,T1.MONTHS ORDER BY T1.MONTHS ASC

----------------  CONSULTA 13 ---------------------------
SELECT T1.*  FROM (
select c.categoryname as category,
sum(case when extract(MONTH FROM o.orderdate)= 1 then o.quantity*o.price else null end)ENERO,
sum(case when extract(MONTH FROM o.orderdate)= 2 then o.quantity*o.price else null end)FEBRERO,
sum(case when extract(MONTH FROM o.orderdate)= 3 then o.quantity*o.price else null end)MARZO,
sum(case when extract(MONTH FROM o.orderdate)= 4 then o.quantity*o.price else null end)ABRIL,
sum(case when extract(MONTH FROM o.orderdate)= 5 then o.quantity*o.price else null end)MAYO,
sum(case when extract(MONTH FROM o.orderdate)= 6 then o.quantity*o.price else null end)JUNIO,
sum(case when extract(MONTH FROM o.orderdate)= 7 then o.quantity*o.price else null end)JULIO,
sum(case when extract(MONTH FROM o.orderdate)= 8 then o.quantity*o.price else null end)AGOSTO,
sum(case when extract(MONTH FROM o.orderdate)= 9 then o.quantity*o.price else null end)SEPTIEMBRE,
sum(case when extract(MONTH FROM o.orderdate)= 10 then o.quantity*o.price else null end)OCTUBRE,
sum(case when extract(MONTH FROM o.orderdate)= 11 then o.quantity*o.price else null end)NOVIEMBRE,
sum(case when extract(MONTH FROM o.orderdate)= 12 then o.quantity*o.price else null end)DICIEMBRE,
sum(case when extract(MONTH FROM o.orderdate)>=1 AND extract(MONTH FROM o.orderdate) <=12 then o.quantity*o.price else null end)SUBTOTAL
from orden o, producto p,categoria c
where o.prod_id= p.prod_id and c.category = p.category
group by c.categoryname
UNION
select 'TTOTAL' as TOTAL,
sum(case when extract(MONTH FROM o.orderdate)= 1 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 2 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 3 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 4 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 5 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 6 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 7 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 8 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 9 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 10 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 11 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)= 12 then o.quantity*o.price else null end),
sum(case when extract(MONTH FROM o.orderdate)>=1 AND extract(MONTH FROM o.orderdate) <=12 then o.quantity*o.price else null end)
from orden o, producto p
where o.prod_id= p.prod_id ) T1
ORDER BY T1.CATEGORY

----------------  CONSULTA 14 ---------------------------
SELECT T.* FROM (
SELECT P.COUNTRY,
sum(case when PO.CATEGORY=1 then o.quantity*o.price else null end)ACCION,
sum(case when PO.CATEGORY=2 then o.quantity*o.price else null end)ANIMATION,
sum(case when PO.CATEGORY=3 then o.quantity*o.price else null end)CHILDREN,
sum(case when PO.CATEGORY=4 then o.quantity*o.price else null end)CLASSICS,
sum(case when PO.CATEGORY=5 then o.quantity*o.price else null end)COMEDY,
sum(case when PO.CATEGORY=6 then o.quantity*o.price else null end)DOCUMENTARY,
sum(case when PO.CATEGORY=7 then o.quantity*o.price else null end)DRAMA,
sum(case when PO.CATEGORY=8 then o.quantity*o.price else null end)FAMILIES,
sum(case when PO.CATEGORY=9 then o.quantity*o.price else null end)FOREIGNS,
sum(case when PO.CATEGORY=10 then o.quantity*o.price else null end)GAMES,
sum(case when PO.CATEGORY=11 then o.quantity*o.price else null end)HORROR,
sum(case when PO.CATEGORY=12 then o.quantity*o.price else null end)MUSIC,
sum(case when PO.CATEGORY=13 then o.quantity*o.price else null end)NEW,
sum(case when PO.CATEGORY=14 then o.quantity*o.price else null end)SCIFI,
sum(case when PO.CATEGORY=15 then o.quantity*o.price else null end)SPORTS,
sum(case when PO.CATEGORY=16 then o.quantity*o.price else null end)TRAVEL,
sum(case when PO.CATEGORY>=1 AND PO.CATEGORY <=16 then o.quantity*o.price else null end)SUBTOTAL
FROM ORDEN O,PRODUCTO PO,PAIS P,CLIENTE C WHERE O.PROD_ID= PO.PROD_ID AND O.CUSTOMERID= C.CUSTOMERID AND C.COUNTRY_ID = P.COUNTRY_ID
GROUP BY P.COUNTRY 

UNION
SELECT 'ZTOTAL' AS TOTAL,
sum(case when PO.CATEGORY=1 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=2 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=3 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=4 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=5 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=6 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=7 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=8 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=9 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=10 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=11 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=12 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=13 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=14 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=15 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=16 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY>=1 AND PO.CATEGORY <=16 then o.quantity*o.price else null end)
FROM ORDEN O,PRODUCTO PO,PAIS P,CLIENTE C WHERE O.PROD_ID= PO.PROD_ID AND
O.CUSTOMERID= C.CUSTOMERID AND C.COUNTRY_ID = P.COUNTRY_ID) T
ORDER BY T.COUNTRY ASC


----------------  CONSULTA 15 ---------------------------
SELECT TUDO.* FROM(
SELECT T1.* FROM(SELECT V.VENDOR_NAME AS VENDEDOR, 
sum(case when PO.CATEGORY=1 then o.quantity*o.price else null end)ACCION,
sum(case when PO.CATEGORY=2 then o.quantity*o.price else null end)ANIMATION,
sum(case when PO.CATEGORY=3 then o.quantity*o.price else null end)CHILDREN,
sum(case when PO.CATEGORY=4 then o.quantity*o.price else null end)CLASSICS,
sum(case when PO.CATEGORY=5 then o.quantity*o.price else null end)COMEDY,
sum(case when PO.CATEGORY=6 then o.quantity*o.price else null end)DOCUMENTARY,
sum(case when PO.CATEGORY=7 then o.quantity*o.price else null end)DRAMA,
sum(case when PO.CATEGORY=8 then o.quantity*o.price else null end)FAMILIES,
sum(case when PO.CATEGORY=9 then o.quantity*o.price else null end)FOREIGNS,
sum(case when PO.CATEGORY=10 then o.quantity*o.price else null end)GAMES,
sum(case when PO.CATEGORY=11 then o.quantity*o.price else null end)HORROR,
sum(case when PO.CATEGORY=12 then o.quantity*o.price else null end)MUSIC,
sum(case when PO.CATEGORY=13 then o.quantity*o.price else null end)NEW,
sum(case when PO.CATEGORY=14 then o.quantity*o.price else null end)SCIFI,
sum(case when PO.CATEGORY=15 then o.quantity*o.price else null end)SPORTS,
sum(case when PO.CATEGORY=16 then o.quantity*o.price else null end)TRAVEL,
sum(case when PO.CATEGORY>=1 AND PO.CATEGORY <=16 then o.quantity*o.price else null end)SUBTOTAL
FROM ORDEN O , VENDEDOR V,PRODUCTO PO
WHERE O.VENDOR_ID = V.VENDOR_ID AND O.PROD_ID = PO.PROD_ID
GROUP BY V.VENDOR_NAME
ORDER BY SUBTOTAL DESC
LIMIT 5)T1

UNION
SELECT 'ZTOTAL' AS TOTAL, 
sum(case when PO.CATEGORY=1 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=2 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=3 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=4 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=5 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=6 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=7 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=8 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=9 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=10 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=11 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=12 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=13 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=14 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=15 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY=16 then o.quantity*o.price else null end),
sum(case when PO.CATEGORY>=1 AND PO.CATEGORY <=16 then o.quantity*o.price else null end)
FROM ORDEN O , VENDEDOR V,PRODUCTO PO
WHERE O.PROD_ID = PO.PROD_ID AND O.VENDOR_ID = V.VENDOR_ID 
AND O.VENDOR_ID IN (SELECT T.VENDEDOR FROM (
SELECT V.VENDOR_ID AS VENDEDOR, 
sum(case when PO.CATEGORY>=1 AND PO.CATEGORY <=16 then o.quantity*o.price else null end)SUBTOTAL
FROM ORDEN O , VENDEDOR V,PRODUCTO PO WHERE O.VENDOR_ID = V.VENDOR_ID AND O.PROD_ID = PO.PROD_ID 
GROUP BY V.VENDOR_ID ORDER BY SUBTOTAL DESC LIMIT 5) T))TUDO 
ORDER BY TUDO.VENDEDOR 






