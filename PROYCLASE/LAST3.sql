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






