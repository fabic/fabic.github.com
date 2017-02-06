---
layout: page
title: "Sybase ASE (Adaptative Server Enterprise)"
description: "Scattered notes about Sybase ASE RDBMS"
published: false
---

# isql : From a shell prompt

	me@localhost ~$ isql -S SYBSERV -U dbuser -P dbuserpass -D testdb

	1>
	2>
	3> GO

	1>
	2> SELECTT * FROM table1 -- OUPS!
	3> RESET
	1>

* Note: The « default » database ?

### Selecting a database :

	1> USE testdb
	2> GO

### :r sql/sql_file.sql

_For reading in the content of an sql file._

	1> :r sql/sql_file.sql
	8> GO


## sp_* procedures :

* <http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.infocenter.help.ase.15.5/title.htm>

* sp_help table/view/object...
* sp_helptext viewName
* sp_helpdb

### sp_helptext viewName

_For having a dump of the actual CREATE VIEW DQL that was used to create it._

