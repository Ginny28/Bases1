CREATE TABLE categoria
(
  category integer NOT NULL PRIMARY KEY,
  categoryname character varying(50)
);

CREATE TABLE pais
(
  country_id bigint NOT NULL PRIMARY KEY,
  country character varying(50)
);

CREATE TABLE vendedor
(
  vendor_id integer NOT NULL PRIMARY KEY,
  vendor_name text
);

CREATE TABLE cliente
(
  customerid integer NOT NULL PRIMARY KEY,
  firstname character varying(50),
  lastname character varying(50),
  address1 character varying(50),
  zip integer,
  phone character varying(50),
  creditcard character varying(50),
  age smallint,
  income integer,
  gender character varying(1),
  country_id bigint references pais(country_id)
);

CREATE TABLE producto
(
  prod_id integer NOT NULL PRIMARY KEY,
  title character varying(50),
  actor character varying(50),
  price numeric(12,2),
  special smallint,
  common_prod_id integer,
  quan_in_stock integer,
  sales integer,
  category integer references categoria(category)
  
);
CREATE TABLE orden
(
  orderid integer NOT NULL,
  orderlineid integer NOT NULL,
  prod_id integer references producto(prod_id),
  vendor_id integer references vendedor(vendor_id),
  quantity smallint,
  orderdate date,
  customerid integer references cliente(customerid),
  price numeric(12,2),
  CONSTRAINT orden_pkey PRIMARY KEY (orderid, orderlineid) 
);

CREATE TABLE cliente_historial
(
  cli_hist_id bigint NOT NULL PRIMARY KEY,
  customerid integer references cliente(customerid),
  orderid integer,
  orderlineid integer,
  prod_id integer references producto(prod_id),
  FOREIGN KEY (orderid,orderlineid)references orden(orderid,orderlineid)
);