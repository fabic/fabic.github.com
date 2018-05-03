---
layout: page
title: "Databases - notes"
tagline: "playground"
category : notes
tags : [draft, wide]
published: true
---

SchemaSpy : how to & your repo remember ?

## Postgresql

```bash
$ sudo pacman -S postgresql{,-docs} php-pgsql phppgadmin
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

## Elastic Search

From <http://sundog-education.com/elasticsearch/>
(Udemy course [udemy.com/elasticsearch-6-and-elastic-stack-in-depth-and-hands-on](https://www.udemy.com/elasticsearch-6-and-elastic-stack-in-depth-and-hands-on/) by Frank Kane;
[slides](http://media.sundog-soft.com/es6/ElasticStack.pdf "es6/ElasticStack.pdf")).

Setup the schema for `/shakespeare` :

```bash
$ curl http://media.sundog-soft.com/es6/shakes-mapping.json |
    curl -H 'Content-Type: application/json' \
      -XPUT 127.0.0.1:9200/shakespeare       \
      --data-binary @-
```

Where `shakes-mapping.json` is :

```json
{
        "mappings" : {
                "doc" : {
                        "properties" : {
                                "speaker" : {"type": "keyword" },
                                "play_name" : {"type": "keyword" },
                                "line_id" : { "type" : "integer" },
                                "speech_number" : { "type" : "integer" }
                        }
                }
        }
}
```

He then proceeds with loading the actual data :

```bash
$ curl -H 'Content-Type: application/json' -X POST \
    'localhost:9200/shakespeare/doc/_bulk?pretty'  \
    --data-binary  @shakespeare_6.0.json
```

And one simple query :

```bash
$ cat <<EOF | curl -H 'Content-Type: application/json' \
                -XGET '127.0.0.1:9200/shakespeare/_search?pretty' \
                --data-binary @-
{
  "query" : {
    "match_phrase" : {
    "text_entry" : "to be or not to be"
    }
  }
}
EOF
```

Query result :

```json
{
  "took" : 88,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : 1,
    "max_score" : 13.874454,
    "hits" : [
      {
        "_index" : "shakespeare",
        "_type" : "doc",
        "_id" : "34229",
        "_score" : 13.874454,
        "_source" : {
          "type" : "line",
          "line_id" : 34230,
          "play_name" : "Hamlet",
          "speech_number" : 19,
          "line_number" : "3.1.64",
          "speaker" : "HAMLET",
          "text_entry" : "To be, or not to be: that is the question:"
        }
      }
    ]
  }
}
```

## Algorithms

### B-trees, B+ trees

__[Wikipedia : B+ tree](https://en.wikipedia.org/wiki/B%2B_tree)__

* [2014: Oracle B-Tree Index: From the concept to Internals](http://www.toadworld.com/platforms/oracle/w/wiki/11001.oracle-b-tree-index-from-the-concept-to-internals)
via [SO: How to lay out B-Tree data on disk?](https://stackoverflow.com/a/40740893)
* [2014: B+Trees – How SQL Server Indexes are Stored on Disk](http://sqlity.net/en/2445/b-plus-tree/)
