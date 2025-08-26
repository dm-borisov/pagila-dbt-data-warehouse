CREATE EXTENSION IF NOT EXISTS postgres_fdw;

DROP SERVER IF EXISTS pagila_backend CASCADE;

CREATE SERVER pagila_backend
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (
	host 'postgres-backend',
	dbname 'postgres',
	port '5432'
);

CREATE USER MAPPING IF NOT EXISTS FOR dwh_dev
SERVER pagila_backend
OPTIONS (
	user 'postgres',
	password '123456'
);

DROP SCHEMA IF EXISTS backend_src;
CREATE SCHEMA backend_src;


-- We need a type and domain to successfully import schema from our pagila backend database
-- Without that there would be an error
CREATE TYPE public.mpaa_rating AS ENUM (
    'G',
    'PG',
    'PG-13',
    'R',
    'NC-17'
);

CREATE DOMAIN public.year AS integer
    CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));


IMPORT FOREIGN SCHEMA public
FROM SERVER pagila_backend
INTO backend_src;
