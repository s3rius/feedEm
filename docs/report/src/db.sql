\connect "app_development";

DROP TABLE IF EXISTS "admins";
DROP SEQUENCE IF EXISTS admins_id_seq;
CREATE SEQUENCE admins_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."admins" (
    "id" bigint DEFAULT nextval('admins_id_seq') NOT NULL,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    "email" character varying DEFAULT '' NOT NULL,
    "encrypted_password" character varying DEFAULT '' NOT NULL,
    "remember_created_at" timestamp,
    CONSTRAINT "admins_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "index_admins_on_email" UNIQUE ("email")
) WITH (oids = false);

INSERT INTO "admins" ("id", "created_at", "updated_at", "email", "encrypted_password", "remember_created_at") VALUES
(1,	'2018-12-25 08:59:05.660659',	'2018-12-25 08:59:05.660659',	's3rius@emial.mail',	'$2a$11$53.5QT9QnhlAPShy3i4cqOU7HO5i3L9v7Nxh.FdZRX5brjIVHkMxK',	NULL),
(2,	'2018-12-25 08:59:05.964432',	'2018-12-25 08:59:05.964432',	'kolaer@emial.mail',	'$2a$11$YRkxGSXwaNGJWgE2GgFEE.1UjSz4BHjcWWDscp4qHSIPdqU532pqG',	NULL),
(3,	'2018-12-25 08:59:06.249906',	'2018-12-25 08:59:06.249906',	'animethug@emial.mail',	'$2a$11$7tPgWtNiJUbRcWqiNvovIe1Fy6WM7n6F5Co3k/pOOWLTEl4QzC1va',	NULL);

DROP TABLE IF EXISTS "ar_internal_metadata";
CREATE TABLE "public"."ar_internal_metadata" (
    "key" character varying NOT NULL,
    "value" character varying,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    CONSTRAINT "ar_internal_metadata_pkey" PRIMARY KEY ("key")
) WITH (oids = false);

INSERT INTO "ar_internal_metadata" ("key", "value", "created_at", "updated_at") VALUES
('environment',	'development',	'2018-12-25 08:59:02.754075',	'2018-12-25 08:59:02.754075');

DROP TABLE IF EXISTS "cards";
DROP SEQUENCE IF EXISTS cards_id_seq;
CREATE SEQUENCE cards_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."cards" (
    "id" bigint DEFAULT nextval('cards_id_seq') NOT NULL,
    "customer_id" bigint,
    "number" character varying,
    "cvv" integer,
    "expire" date,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    CONSTRAINT "cards_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "index_cards_on_number" UNIQUE ("number"),
    CONSTRAINT "fk_rails_778182f614" FOREIGN KEY (customer_id) REFERENCES customers(id) NOT DEFERRABLE
) WITH (oids = false);

CREATE INDEX "index_cards_on_customer_id" ON "public"."cards" USING btree ("customer_id");


DROP TABLE IF EXISTS "customers";
DROP SEQUENCE IF EXISTS customers_id_seq;
CREATE SEQUENCE customers_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."customers" (
    "id" bigint DEFAULT nextval('customers_id_seq') NOT NULL,
    "name" character varying,
    "surname" character varying,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    "email" character varying DEFAULT '' NOT NULL,
    "encrypted_password" character varying DEFAULT '' NOT NULL,
    "remember_created_at" timestamp,
    CONSTRAINT "customers_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "index_customers_on_email" UNIQUE ("email")
) WITH (oids = false);

INSERT INTO "customers" ("id", "name", "surname", "created_at", "updated_at", "email", "encrypted_password", "remember_created_at") VALUES
(1,	'Pavel',	'Kirilin',	'2018-12-25 08:59:05.513541',	'2018-12-25 08:59:05.513541',	's3rius@emial.mail',	'$2a$11$8hXx4K1CVs0ZgEVt0T5Uae3zDCm1FCWgQQbx8qDei5GMqVYC1fbea',	NULL),
(2,	'Maxim',	'Naumov',	'2018-12-25 08:59:05.809281',	'2018-12-25 08:59:05.809281',	'kolaer@emial.mail',	'$2a$11$.9fNOUVqSjSEOAYb5Sw97eb9NuSy1zaNXp5EkdTevR44i6KevvH7G',	NULL),
(3,	'Andrei',	'Belousov',	'2018-12-25 08:59:06.108177',	'2018-12-25 08:59:06.108177',	'animethug@emial.mail',	'$2a$11$qU1C1V508dhX5bFqzubbeeM7pdMN9RC0lZosg/zTb3/TIJoiVu5yC',	NULL);

DROP TABLE IF EXISTS "merchandises";
DROP SEQUENCE IF EXISTS merchandises_id_seq;
CREATE SEQUENCE merchandises_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."merchandises" (
    "id" bigint DEFAULT nextval('merchandises_id_seq') NOT NULL,
    "seller_id" bigint,
    "name" character varying,
    "description" text,
    "price" integer,
    "cook_time" integer,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    CONSTRAINT "merchandises_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "fk_rails_63736ada83" FOREIGN KEY (seller_id) REFERENCES sellers(id) NOT DEFERRABLE
) WITH (oids = false);

CREATE INDEX "index_merchandises_on_seller_id" ON "public"."merchandises" USING btree ("seller_id");

INSERT INTO "merchandises" ("id", "seller_id", "name", "description", "price", "cook_time", "created_at", "updated_at") VALUES
(1,	1,	'Burger',	'made from Burger',	20,	20,	'2018-12-25 08:59:05.179458',	'2018-12-25 08:59:05.179458'),
(2,	1,	'CheeseBurger',	'made from CheeseBurger',	25,	20,	'2018-12-25 08:59:05.187246',	'2018-12-25 08:59:05.187246'),
(3,	1,	'Chocolate',	'made from Chocolate',	15,	20,	'2018-12-25 08:59:05.198679',	'2018-12-25 08:59:05.198679'),
(4,	1,	'Cola',	'made from Soda',	10,	20,	'2018-12-25 08:59:05.210367',	'2018-12-25 08:59:05.210367'),
(5,	1,	'Sprite',	'made from Soda',	10,	20,	'2018-12-25 08:59:05.221047',	'2018-12-25 08:59:05.221047'),
(6,	2,	'Burger',	'made from Burger',	20,	20,	'2018-12-25 08:59:05.243941',	'2018-12-25 08:59:05.243941'),
(7,	2,	'CheeseBurger',	'made from CheeseBurger',	25,	20,	'2018-12-25 08:59:05.255126',	'2018-12-25 08:59:05.255126'),
(8,	2,	'Chocolate',	'made from Chocolate',	15,	20,	'2018-12-25 08:59:05.265752',	'2018-12-25 08:59:05.265752'),
(9,	2,	'Cola',	'made from Soda',	10,	20,	'2018-12-25 08:59:05.27669',	'2018-12-25 08:59:05.27669'),
(10,	2,	'Sprite',	'made from Soda',	10,	20,	'2018-12-25 08:59:05.287987',	'2018-12-25 08:59:05.287987'),
(11,	3,	'Burger',	'made from Burger',	20,	20,	'2018-12-25 08:59:05.309411',	'2018-12-25 08:59:05.309411'),
(12,	3,	'CheeseBurger',	'made from CheeseBurger',	25,	20,	'2018-12-25 08:59:05.32063',	'2018-12-25 08:59:05.32063'),
(13,	3,	'Chocolate',	'made from Chocolate',	15,	20,	'2018-12-25 08:59:05.331886',	'2018-12-25 08:59:05.331886'),
(14,	3,	'Cola',	'made from Soda',	10,	20,	'2018-12-25 08:59:05.343125',	'2018-12-25 08:59:05.343125'),
(15,	3,	'Sprite',	'made from Soda',	10,	20,	'2018-12-25 08:59:05.354625',	'2018-12-25 08:59:05.354625');

DROP TABLE IF EXISTS "order_items";
DROP SEQUENCE IF EXISTS order_items_id_seq;
CREATE SEQUENCE order_items_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."order_items" (
    "id" bigint DEFAULT nextval('order_items_id_seq') NOT NULL,
    "order_id" bigint,
    "merchandise_id" bigint,
    "quantity" integer DEFAULT '1',
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    CONSTRAINT "order_items_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "fk_rails_4b64fa6392" FOREIGN KEY (merchandise_id) REFERENCES merchandises(id) NOT DEFERRABLE,
    CONSTRAINT "fk_rails_e3cb28f071" FOREIGN KEY (order_id) REFERENCES orders(id) NOT DEFERRABLE
) WITH (oids = false);

CREATE INDEX "index_order_items_on_merchandise_id" ON "public"."order_items" USING btree ("merchandise_id");

CREATE INDEX "index_order_items_on_order_id" ON "public"."order_items" USING btree ("order_id");


DROP TABLE IF EXISTS "orders";
DROP SEQUENCE IF EXISTS orders_id_seq;
CREATE SEQUENCE orders_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."orders" (
    "id" bigint DEFAULT nextval('orders_id_seq') NOT NULL,
    "customer_id" bigint,
    "time" timestamp,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    "card_id" bigint,
    "status" character varying,
    "seller_id" bigint,
    CONSTRAINT "orders_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "fk_rails_3dad120da9" FOREIGN KEY (customer_id) REFERENCES customers(id) NOT DEFERRABLE,
    CONSTRAINT "fk_rails_5ee51a3f64" FOREIGN KEY (card_id) REFERENCES cards(id) NOT DEFERRABLE,
    CONSTRAINT "fk_rails_f569184c98" FOREIGN KEY (seller_id) REFERENCES sellers(id) NOT DEFERRABLE
) WITH (oids = false);

CREATE INDEX "index_orders_on_card_id" ON "public"."orders" USING btree ("card_id");

CREATE INDEX "index_orders_on_customer_id" ON "public"."orders" USING btree ("customer_id");

CREATE INDEX "index_orders_on_seller_id" ON "public"."orders" USING btree ("seller_id");


DROP TABLE IF EXISTS "pg_search_documents";
DROP SEQUENCE IF EXISTS pg_search_documents_id_seq;
CREATE SEQUENCE pg_search_documents_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."pg_search_documents" (
    "id" bigint DEFAULT nextval('pg_search_documents_id_seq') NOT NULL,
    "content" text,
    "searchable_type" character varying,
    "searchable_id" bigint,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    CONSTRAINT "pg_search_documents_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "index_pg_search_documents_on_searchable_type_and_searchable_id" ON "public"."pg_search_documents" USING btree ("searchable_type", "searchable_id");


DROP TABLE IF EXISTS "schema_migrations";
CREATE TABLE "public"."schema_migrations" (
    "version" character varying NOT NULL,
    CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version")
) WITH (oids = false);

INSERT INTO "schema_migrations" ("version") VALUES
('20181219173022'),
('20181108165412'),
('20181209102221'),
('20181209102156'),
('20181108165429'),
('20181108164659'),
('20181219131334'),
('20181219172103'),
('20181107183125'),
('20181204145632'),
('20181107182554'),
('20181107180845'),
('20181128154124'),
('20181107184320');

DROP TABLE IF EXISTS "sellers";
DROP SEQUENCE IF EXISTS sellers_id_seq;
CREATE SEQUENCE sellers_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE "public"."sellers" (
    "id" bigint DEFAULT nextval('sellers_id_seq') NOT NULL,
    "name" character varying,
    "likes" integer DEFAULT '0',
    "dislikes" integer DEFAULT '0',
    "auth_token" character varying,
    "created_at" timestamp NOT NULL,
    "updated_at" timestamp NOT NULL,
    CONSTRAINT "index_sellers_on_auth_token" UNIQUE ("auth_token"),
    CONSTRAINT "index_sellers_on_name" UNIQUE ("name"),
    CONSTRAINT "sellers_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "sellers" ("id", "name", "likes", "dislikes", "auth_token", "created_at", "updated_at") VALUES
(1,	'CoolFood',	'0',	'0',	'Y8BYWrzNKAUSfLUF8n1T2PMs',	'2018-12-25 08:59:05.13454',	'2018-12-25 08:59:05.13454'),
(2,	'FakeBurgers',	'0',	'0',	'fTqC8A6Ab79PyQfLGR9YUyEz',	'2018-12-25 08:59:05.232299',	'2018-12-25 08:59:05.232299'),
(3,	'FunnyMall',	'0',	'0',	'SLBm3zKzsjFcHGTa7KUrjKir',	'2018-12-25 08:59:05.298075',	'2018-12-25 08:59:05.298075');
