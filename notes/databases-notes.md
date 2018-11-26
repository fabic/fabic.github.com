---
layout: page
title: "Databases - notes"
tagline: "playground"
category : notes
tags : [draft, wide]
published: true
maths: true
---

* [SchemaSpy](git@github.com:fabic/SchemaSpy-ng.git) : how to & your repo remember ?

![NoSQL: Not Only SQL](/assets/nosql--not-only-sql.png "NoSQL: Not Only SQL.")

## Postgresql

```bash
$ sudo pacman -S postgresql{,-docs} php-pgsql phppgadmin
```
### Postgresql : pointers, Q&A

* [Manual: Aggregate Functions (PostgreSQL)](https://www.postgresql.org/docs/current/static/functions-aggregate.html)
* [SO: about `string_agg()`](https://stackoverflow.com/a/43944/643087)
  also gives a couple of related custom functions.
* `SELECT array_to_string( array_agg(distinct ...) ) ...`

  ```sql
  select u.id, u.email, u.name, u.surname,
    -- string_agg(r.name, ', ') as user_roles,
    array_to_string(array_agg(distinct r.name), ', ') as user_roles,
    count(p.id) as nof_products,
    u.country_id, c.iso_code, c.name
  from users u
    left join countries c on u.country_id = c.id
    left join model_has_roles ur
      on ur.model_type = 'App\User' and ur.model_id = u.id
    left join roles r on r.id = ur.role_id
    left join products p on p.user_id = u.id
  group by u.id, u.email, u.name, u.surname, c.iso_code, c.name
  having count(p.id) > 0
  order by nof_products desc, u.surname ;
  ```
* __todo/read:__ [The many faces of DISTINCT in PostgreSQL (2017, by Haki Benita @ Medium)](https://medium.com/statuscode/the-many-faces-of-distinct-in-postgresql-c52490de5954)


#### anonymous PL/PgSQL proc. for declaring variables.

```sql
do $$
declare
  OrderID int := 159;
  FromProductID int := 4048;
  ToProductID int := 2220;
begin

  update order_items
  set object_id = ToProductID
  where order_id = OrderID
    and object_id = FromProductID ;

  -- Rewire the parcel's supplier_id = the product seller user id
  -- (we also update the parcel `reference` = "{seller user.id}-{order_item.id}).
  update parcels p set supplier_id = pr.user_id,
                       reference = concat(pr.user_id, '-', oi.id)
  from order_items oi
  inner join products pr on pr.id = oi.object_id and oi.object = 'product'
  where oi.order_id = OrderID and oi.object_id = ToProductID
    and oi.id = p.order_item_id;

end $$ LANGUAGE plpgsql ;
```

Note: `return query select ...` appears not possible when resorting to anonymous procedures.

#### Partial/transformed indexes

Fount [at](https://hackernoon.com/javascript-experience-of-migrating-from-mongodb-to-postgresql-21f8bf140c05);
have a unique index that lowercases user names, and allows reuse of a user name
if all others are marked as removed.

```sql
CREATE UNIQUE INDEX “magical_idx”
  ON “users” (LOWER(“name”), NULLIF(“removed”, true));
```

Non-guessable string indentifier column, with some randomness:

```sql
“id” varchar PRIMARY KEY
               NOT NULL
               DEFAULT ( ‘us’
                         || nextval(‘users_id_seq’)::text
                         || (LPAD(floor(random()*1000)::text, 3, ‘0’)) ),
```

[Base62 encoder func. `ls_crypt_convert_base()`](https://www.postgresql.org/message-id/482B7FAF.7000902%40lorenso.com) :

```PLpgSQL
CREATE OR REPLACE FUNCTION "public"."ls_crypt_convert_base"
  (in_value TEXT, in_base INTEGER)
  RETURNS text AS
$body$
   my ($value, $base) = @_;
   $base = ($base > 62) ? 62 : (($base < 2) ? 2 : $base);
   my @nums = (0..9,'a'..'z','A'..'Z')[0..$base-1];
   my $index = 0;
   my %nums = map {$_, $index++} @nums;

   # short circuit if no value
   $value =~ s/\D//g;
   return if ($value == 0);

   # this will be the end value.
   my $rep = '';
   while ($value > 0) {
       $rep = $nums[$value % $base] . $rep;
       $value = int($value / $base);
   }
   return $rep;
$body$
LANGUAGE 'plperl' IMMUTABLE RETURNS NULL ON NULL INPUT SECURITY INVOKER;
```

### Postgres :: dump database

This one command is what you actually want :

```bash
$ pg_dump my_database | bzip2 -c > tmp/my_database.db.dump.sql.bz2
```

There's also the `-F tar` argument to `pg_dump` which will produce a tarball:

```bash
$ pg_dump -F tar my_database > `date -Is`--my_database.db-dump.sql.tar
```

But note that it contains several files, probably one per table:

```bash
$ tar -tf my_database.db-dump.sql.tar
toc.dat
2660.dat
2662.dat
...
...
2733.dat
restore.sql
```

### Postgre :: restore (load) dump

```bash
$ pg_dump my_funky_db | psql my_funky_db_dup
```

### Postgres :: one-liner dump/restore "test" database

```bash
$ dropdb -e --if-exists funkydb &&
    createdb -O "`whoami`" -e funkydb &&
      ( pg_dump funkydb | psql funkydb_test )
```

Or with a bash variable:

```bash
$ ( dasdb="funkydb"; dropdb -e --if-exists "${dasdb}_test" &&
      createdb -O "`whoami`" -e "${dasdb}_test" &&
        ( pg_dump "${dasdb}" | psql "${dasdb}_test" ) )
```

## MySQL / MariaDB

### Users, security, access control

#### List all users with remote access

```
MariaDB [(none)]> SELECT User, Host FROM mysql.user WHERE Host <> 'localhost';
+------+-----------+
| User | Host      |
+------+-----------+
| root | 127.0.0.1 |
| root | ::1       |
|      | wall      |
| root | wall      |
+------+-----------+
4 rows in set (0.00 sec)
```

#### List all users that do not have remote access

This would list users that _have_ localhost access _but no_ remote access:

```sql
SELECT u.User, u.Host, u.Password
FROM mysql.user u
WHERE NOT EXISTS (
    SELECT * FROM mysql.user uu
    WHERE uu.User = u.User
      AND uu.Host NOT IN ('localhost', '127.0.0.1', '::1')
  ) ;
```

```
+------+-----------+-------------------------------------------+
| User | Host      | Password                                  |
+------+-----------+-------------------------------------------+
| fabi | localhost | *12344E8CABCDEFA5812346BABCDFE90FEDCBA123 |
+------+-----------+-------------------------------------------+
1 row in set (0.00 sec)
```

Then one may add a corresponding user with remote access _using the same password_ :

```sql
CREATE USER fabi@'%'
  IDENTIFIED BY PASSWORD '*12344E8CABCDEFA5812346BABCDFE90FEDCBA123' ;
```

## Algorithms

### B-trees, B+ trees

__[Wikipedia : B+ tree](https://en.wikipedia.org/wiki/B%2B_tree)__

* [2014: Oracle B-Tree Index: From the concept to Internals](http://www.toadworld.com/platforms/oracle/w/wiki/11001.oracle-b-tree-index-from-the-concept-to-internals)
via [SO: How to lay out B-Tree data on disk?](https://stackoverflow.com/a/40740893)
* [2014: B+Trees – How SQL Server Indexes are Stored on Disk](http://sqlity.net/en/2445/b-plus-tree/)

## Other, pointers, articles

* <https://hackernoon.com/javascript-experience-of-migrating-from-mongodb-to-postgresql-21f8bf140c05>

