create extension postgres_fdw;

create server remote_server 
foreign data wrapper postgres_fdw
options (
    host 'localhost',
    port '5432',
    dbname 'northwind'
);

create user mapping for postgres
server remote_server
options (
    user 'postgres',
    password '6669'
);

create user mapping for justcoffee
server remote_server
options (
    user 'postgres',
    password '6669'
);

create foreign table remote_categories (
    id smallint options(column_name 'category_id') not null,
    name varchar(15) options(column_name 'category_name') not null,
    description text,
    picture bytea
)
server remote_server
options (
    schema_name 'public',
    table_name 'categories'
);

select * from remote_categories;

-- Возможность импортировать некоторые таблицы из удалённой схемы:
import foreign schema public
limit to (users, sessions)
from server remote_server
into public;

