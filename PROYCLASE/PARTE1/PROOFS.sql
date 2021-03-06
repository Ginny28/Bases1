﻿
--------- CLIENTE-PAIS---------------
SELECT * FROM CLIENTE;

SELECT C.CUSTOMERID,C.FIRSTNAME,C.LASTNAME,C.ADDRESS1,C.ZIP,C.PHONE,
C.CREDITCARD,C.AGE,C.INCOME,C.GENDER,P.COUNTRY_ID,P.COUNTRY FROM CLIENTE C, PAIS P
WHERE C.COUNTRY_ID = P.COUNTRY_ID;

---------- PRODUCTO-CATEGORIA ------------
SELECT * FROM PRODUCTO;

SELECT P.PROD_ID,P.TITLE,P.ACTOR,P.PRICE,P.SPECIAL,
P.COMMON_PROD_ID,P.QUAN_IN_STOCK,P.SALES, C.CATEGORY,
C.CATEGORYNAME FROM PRODUCTO P, CATEGORIA C
WHERE P.CATEGORY= C.CATEGORY;

--------- ORDEN-VENDEDOR-----------------
SELECT * FROM ORDEN;

SELECT O.* , V.VENDOR_NAME
FROM ORDEN O , VENDEDOR V 
WHERE O.VENDOR_ID = V.VENDOR_ID;

--------- ORDEN-CLIENTE-----------------
SELECT * FROM ORDEN;

SELECT O.* , C.FIRSTNAME,C.LASTNAME
FROM ORDEN O , CLIENTE C 
WHERE O.CUSTOMERID = C.CUSTOMERID;

--------- ORDEN-PRODUCTO-----------------
SELECT * FROM ORDEN;

SELECT O.* , P.TITLE,P.ACTOR
FROM ORDEN O , PRODUCTO P
WHERE O.PROD_ID = P.PROD_ID;


--------- CLIENTEHISTORIAL-CLIENTE-----------

SELECT * FROM CLIENTE_HISTORIAL;

SELECT CH.*,C.FIRSTNAME,C.LASTNAME
FROM CLIENTE_HISTORIAL CH, CLIENTE C
WHERE CH.CUSTOMERID = C.CUSTOMERID;

--------- CLIENTEHISTORIAL-PRODUCTO-----------

SELECT * FROM CLIENTE_HISTORIAL;

SELECT CH.*,P.TITLE,P.ACTOR
FROM CLIENTE_HISTORIAL CH, PRODUCTO P
WHERE CH.PROD_ID = P.PROD_ID;

--------- CLIENTEHISTORIAL-ORDEN-----------

SELECT * FROM CLIENTE_HISTORIAL;

SELECT CH.*,O.ORDERLINEID
FROM CLIENTE_HISTORIAL CH, ORDEN O
WHERE CH.ORDERID = O.ORDERID AND CH.CUSTOMERID= O.CUSTOMERID AND CH.PROD_ID=O.PROD_ID;