CREATE DATABASE podemos_eval WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Mexico.1252' LC_CTYPE = 'Spanish_Mexico.1252';

ALTER DATABASE podemos_eval OWNER TO eval;

SET client_encoding = 'UTF8';

/* ------------------------------------------------------------------------------------- */

CREATE SCHEMA podemos_eval;

ALTER SCHEMA podemos_eval OWNER TO eval;

/* ------------------------------------------------------------------------------------- */

CREATE TABLE podemos_eval."Clientes"
(
  id character varying(7) NOT NULL,
  nombre character varying(60) NOT NULL,
  CONSTRAINT clientes_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE podemos_eval."Clientes"
  OWNER TO eval;

/* ------------------------------------------------------------------------------------- */

CREATE TABLE podemos_eval."Grupos"
(
  id character varying(5) NOT NULL,
  nombre character varying(20) NOT NULL,
  CONSTRAINT grupos_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE podemos_eval."Grupos"
  OWNER TO eval;

/* ------------------------------------------------------------------------------------- */

CREATE TABLE podemos_eval."Miembros"
(
  grupo_id character varying(5) NOT NULL,
  cliente_id character varying(7) NOT NULL,
  CONSTRAINT Miembros_pkey PRIMARY KEY (grupo_id, cliente_id),
  CONSTRAINT fk_cliente FOREIGN KEY (cliente_id)
      REFERENCES podemos_eval."Clientes" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_grupo FOREIGN KEY (grupo_id)
      REFERENCES podemos_eval."Grupos" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE podemos_eval."Miembros"
  OWNER TO eval;

CREATE INDEX fk_cliente_idx
  ON podemos_eval."Miembros"
  USING btree
  (cliente_id COLLATE pg_catalog."default");

/* ------------------------------------------------------------------------------------- */

CREATE TABLE podemos_eval."Cuentas"
(
  id character varying(5) NOT NULL,
  grupo_id character varying(5) NOT NULL,
  estatus character varying(15) NOT NULL,
  monto numeric(15,2) NOT NULL,
  saldo numeric(15,2) NOT NULL,
  CONSTRAINT Cuentas_pkey PRIMARY KEY (id),
  CONSTRAINT "fk_Cuentas_1" FOREIGN KEY (grupo_id)
      REFERENCES podemos_eval."Grupos" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE podemos_eval."Cuentas"
  OWNER TO eval;

CREATE INDEX fk_grupo_idx
  ON podemos_eval."Cuentas"
  USING btree
  (grupo_id COLLATE pg_catalog."default");

/* ------------------------------------------------------------------------------------- */

CREATE TABLE podemos_eval."CalendarioPagos"
(
  id integer NOT NULL,
  cuenta_id character varying(5) NOT NULL,
  num_pago integer NOT NULL,
  monto numeric(15,2) NOT NULL,
  fecha_pago date NOT NULL,
  estatus character varying(15) NOT NULL,
  CONSTRAINT CalendarioPagos_pkey PRIMARY KEY (id),
  CONSTRAINT fk_calendariopagos_1 FOREIGN KEY (cuenta_id)
      REFERENCES podemos_eval."Cuentas" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE podemos_eval."CalendarioPagos"
  OWNER TO eval;

CREATE INDEX fk_calendariopagos_1_idx
  ON podemos_eval."CalendarioPagos"
  USING btree
  (cuenta_id COLLATE pg_catalog."default");

/* ------------------------------------------------------------------------------------- */

CREATE TABLE podemos_eval."Transacciones"
(
  id integer NOT NULL,
  cuenta_id character varying(5) NOT NULL,
  fecha timestamp without time zone NOT NULL,
  monto numeric(15,2) NOT NULL,
  CONSTRAINT Transacciones_pkey PRIMARY KEY (id),
  CONSTRAINT fk_transacciones_1 FOREIGN KEY (cuenta_id)
      REFERENCES podemos_eval."Cuentas" (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE podemos_eval."Transacciones"
  OWNER TO eval;

CREATE INDEX fk_transacciones_1_idx
  ON podemos_eval."Transacciones"
  USING btree
  (cuenta_id COLLATE pg_catalog."default");

/* ------------------------------------------------------------------------------------- */

INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('MNOPQ01', 'GERTRUDIS LOPEZ MARTINEZ');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('QRSTU02', 'FERNANDA JUAREZ LOPEZ');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('ABCDE03', 'IRMA MARQUEZ RUBIO');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('OPQRS04', 'ALEIDA SANCHEZ AMOR');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('TYUIQ05', 'LORENA GARCIA ROCHA');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('QWERT06', 'ALBA PEREZ TORRES');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('YUIOP07', 'ELISEO CHAVEZ OLVERA');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('ASDFG08', 'SANDRA SANCHEZ GONZALEZ');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('HJKLL09', 'ANGELA GOMEZ MONROY');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('ZXCVB10', 'KARLA ENRIQUEZ NAVARRETE');
INSERT INTO podemos_eval."Clientes" (id, nombre) VALUES ('NMZXC11', 'DANIELA HERNANDEZ GUERRERO');

/* ------------------------------------------------------------------------------------- */

INSERT INTO podemos_eval."Grupos" (id, nombre) VALUES ('XYZW1', 'POWERPUFF GIRLS');
INSERT INTO podemos_eval."Grupos" (id, nombre) VALUES ('ABCD2', 'CHARLIE''S ANGELS');
INSERT INTO podemos_eval."Grupos" (id, nombre) VALUES ('GHIJK', 'KITTIE');

/* ------------------------------------------------------------------------------------- */

INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('XYZW1', 'MNOPQ01');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('XYZW1', 'QRSTU02');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('XYZW1', 'ABCDE03');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('XYZW1', 'OPQRS04');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('ABCD2', 'TYUIQ05');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('ABCD2', 'QWERT06');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('ABCD2', 'YUIOP07');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('ABCD2', 'ASDFG08');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('GHIJK', 'HJKLL09');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('GHIJK', 'ZXCVB10');
INSERT INTO podemos_eval."Miembros" (grupo_id, cliente_id) VALUES ('GHIJK', 'NMZXC11');

/* ------------------------------------------------------------------------------------- */

INSERT INTO podemos_eval."Cuentas" (id, grupo_id, estatus, monto, saldo) VALUES ('23001', 'XYZW1', 'CERRADA', 60000.00, 0.00);
INSERT INTO podemos_eval."Cuentas" (id, grupo_id, estatus, monto, saldo) VALUES ('12345', 'ABCD2', 'DESEMBOLSADA', 75000.00, 64500.00);
INSERT INTO podemos_eval."Cuentas" (id, grupo_id, estatus, monto, saldo) VALUES ('10001', 'XYZW1', 'DESEMBOLSADA', 150000.00, 74500.00);
INSERT INTO podemos_eval."Cuentas" (id, grupo_id, estatus, monto, saldo) VALUES ('89752', 'GHIJK', 'DESEMBOLSADA', 80000.00, 80000.00);

/* ------------------------------------------------------------------------------------- */

INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (1, '23001', 1, 15000.00, '2019-11-30', 'PAGADO');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (2, '23001', 2, 15000.00, '2019-12-07', 'PAGADO');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (3, '23001', 3, 15000.00, '2019-12-14', 'PAGADO');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (4, '23001', 4, 15000.00, '2019-12-21', 'PAGADO');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (5, '12345', 1, 18750.00, '2019-12-20', 'PARCIAL');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (6, '12345', 2, 18750.00, '2019-12-27', 'PENDIENTE');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (7, '12345', 3, 18750.00, '2020-01-03', 'PENDIENTE');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (8, '12345', 4, 18750.00, '2020-01-10', 'PENDIENTE');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (9, '10001', 1, 37500.00, '2019-12-07', 'PAGADO');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (10, '10001', 2, 37500.00, '2019-12-14', 'PAGADO');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (11, '10001', 3, 37500.00, '2019-12-21', 'PARCIAL');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (12, '10001', 4, 37500.00, '2019-12-28', 'PENDIENTE');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (13, '89752', 1, 20000.00, '2020-01-07', 'ATRASADO');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (14, '89752', 2, 20000.00, '2020-01-14', 'PENDIENTE');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (15, '89752', 3, 20000.00, '2020-01-21', 'PENDIENTE');
INSERT INTO podemos_eval."CalendarioPagos" (id, cuenta_id, num_pago, monto, fecha_pago, estatus) VALUES (16, '89752', 4, 20000.00, '2020-01-28', 'PENDIENTE');

/* ------------------------------------------------------------------------------------- */

INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (1, '23001', '2019-11-30 10:36:00', 15000.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (2, '23001', '2019-12-07 12:50:00', 15000.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (3, '23001', '2019-12-14 13:45:00', 15000.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (4, '23001', '2019-12-21 11:35:00', 15000.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (5, '12345', '2019-12-20 14:50:00', 5000.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (6, '12345', '2019-12-21 15:25:00', 5500.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (7, '10001', '2019-12-07 11:34:00', 37500.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (8, '10001', '2019-12-07 10:04:00', 37500.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (9, '10001', '2019-12-07 18:50:00', -30000.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (10, '10001', '2019-12-07 18:51:00', -7500.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (11, '10001', '2019-12-14 09:59:00', 37500.00);
INSERT INTO podemos_eval."Transacciones" (id, cuenta_id, fecha, monto) VALUES (12, '10001', '2019-12-21 11:05:00', 500.00);