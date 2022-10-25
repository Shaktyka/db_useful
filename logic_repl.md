# Логическая репликация

SELECT * FROM pg_ls_waldir();

select * from pg_stat_replication
limit 20;

select * from pg_replication_slots
limit 20;

select * from pg_stat_databases_conflicts
limit 20;

### Найти таблицы без уникальных идентификаторов

SELECT pgn.nspname || '.' || pgc.relname AS "Таблицы без репликационных идентификаторов"
  FROM pg_class AS pgc,
       pg_namespace AS pgn
  WHERE pgn.nspname !~ '^(?:pg_.*|information_schema)$'
    AND pgc.relreplident IN ('n', 'd')
    AND pgc.relkind IN ('r', 'p') 
    AND pgc.oid NOT IN (SELECT pgi.indrelid FROM pg_index AS pgi WHERE pgi.indisprimary)
    AND pgc.relnamespace = pgn.oid
    ORDER BY 1;
