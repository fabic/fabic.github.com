---
layout: post
title: "PostgreSQL : from a shell"
tagline: "PostgreSql... is awkward from the command line."
category : notes
published: false
tags : [PostgreSQL]
---

* [SQL language &ndash; postgresql.org/docs/current/static/sql.html](https://www.postgresql.org/docs/current/static/sql.html)
    - [Data types &ndash; postgresql.org/docs/current/static/datatype.html](https://www.postgresql.org/docs/current/static/datatype.html)
    - [Constraints &ndash; postgresql.org/docs/current/static/ddl-constraints.html](https://www.postgresql.org/docs/current/static/ddl-constraints.html)
* [postgresql.org/docs/current/static/sql-comment.html](https://www.postgresql.org/docs/current/static/sql-comment.html)


## List all databases

```bash
$ psql -l
```

## Database administration

* todo: users and roles, confusion.

```bash
$ sudo -u postgres -i
```

Create a new database named `clong` owned by ~~user~~ role `fabi` :

```bash
$ createdb --owner=fabi clong
```

## Pointers

* <http://www.sqlines.com/postgresql/datatypes/serial>
* [Postgres-cheatsheet by Kartones (Gist)](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546)

__EOF__
