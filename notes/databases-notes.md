---
layout: page
title: "Databases - notes"
tagline: "playground"
category : notes
tags : [draft, wide]
published: true
maths: true
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

### Concepts

  * __TF-IDF__ : Relevance = Term Frequency x Inverse Document Frequency.

    - Assessing the __relevance of term__ in a given document ;
    - __Term Frequency :__ How often a term occurs in a document ;
    - __Document Frequency :__ How often it appears in _all_ documents.

  {% raw %}
  $$
  \begin{align*}
  Relevance = Term Frequency \times \frac{1}{Inverse Document Frequency}
  \end{align*}
  $$
  {% endraw %}

  * huh

### Examples

#### Importing MovieLens' movies data

* Several datasets (CSV) are available at [grouplens.org/datasets/movielens/](https://grouplens.org/datasets/movielens/)

```bash
$ cat mappings-movies.json |
    curl -H 'Content-Type: application/json' \
      -XPUT '127.0.0.1:9200/movies'          \
      --data-binary @-
```

With `mappings-movies.json` :

```bash
$ cat << EOF > mappings-movies.json
{
  "mappings": {
    "movie": {
      "properties": {
        "year": { "type": "date" }
      }
    }
  }
}
EOF
```

##### Query the mapping :

```bash
$ curl -H 'Content-Type: application/json' \
    -XGET '127.0.0.1:9200/movies/_mapping/?pretty'
```
which yields :

```json
{
  "movies" : {
    "mappings" : {
      "movie" : {
        "properties" : {
          "year" : {
            "type" : "date"
          }
        }
      }
    }
  }
}
```

__NOTE:__ We can request the mapping for a specific type, here `movie` for ex. :

```bash
$ curl -H 'Content-Type: application/json' \
    -XGET '127.0.0.1:9200/movies/_mapping/movie?pretty'
```


##### Bulk insertion of all the movies

###### Using any-json + jq to transform the CSV data to the JSON we want :

* [any-json](https://www.npmjs.com/package/any-json)
* [jq](https://stedolan.github.io/jq/manual/)
* Note: One may also write a __jq__ [script](https://stackoverflow.com/a/32002086)
  for parsing CSV.

```bash
$ head ml-latest/movies.csv |
    any-json convert /dev/stdin --input-format=csv |
      jq '[.[] | {id: .movieId, title: .title, genres: .genres|split("|"), year: (.title|capture("\\((?<y>[0-9]+)\\s*\\)$")|.y|tonumber)}]'
```

will transform :

```bash
$ head ml-latest/movies.csv
movieId,title,genres
1,Toy Story (1995),Adventure|Animation|Children|Comedy|Fantasy
2,Jumanji (1995),Adventure|Children|Fantasy
3,Grumpier Old Men (1995),Comedy|Romance
4,Waiting to Exhale (1995),Comedy|Drama|Romance
```

to

```json
[
  {
    "id": "1",
    "title": "Toy Story (1995)",
    "genres": [
      "Adventure",
      "Animation",
      "Children",
      "Comedy",
      "Fantasy"
    ],
    "year": 1995
  },
  {
    "id": "2",
    ...
    ...
  },
  ...
]
```

###### Preparing for \_bulk data insertion

ElasticSearch expects a strange format where a single record to be inserted
needs two JSON objects :

```json
{ "create": { "_index": "movies", "_type": "movie", "_id": "1" } }
{ "id": "1",
  "title": "Toy Story (1995)",
  "genres": [ "Adventure", "Animation" ],
  "year": 1995
}
```

Using __jq__ again so as to produce the expected format :

```bash
$ head ml-latest/movies.csv |
    any-json convert /dev/stdin --input-format=csv |
      jq '[.[] | {id: .movieId, title: .title, genres: .genres|split("|"), year: (.title|capture("\\((?<y>[0-9]+)\\s*\\)$")|.y|tonumber)}]' |
        jq '.[] | {create:{_index:"movies", _type:"movie", _id: .id}},.'
```

Applying this to the `movies.csv` revealed a few unescaped or malformed UTF-8
characters; had to fix things by hand.

```bash
$ any-json convert ml-latest/movies.csv > movies1.json
```

And finally :

```bash
$ time (
    cat movies1.json \
    | jq '[.[] | {id: .movieId, title: .title, genres: .genres|split("|"), year: (.title|capture("\\((?<y>[0-9]+)\\s*\\)$")|.y|tonumber)}]' \
    | jq -c '.[] | {create:{_index:"movies", _type:"movie", _id: .id}},.' \
    | curl -H 'Content-Type: application/json' \
        -XPUT '127.0.0.1:9200/_bulk?pretty'    \
        --data-binary @-
  )
```

###### Check what's in there with a `_search` query :

```bash
$ curl -H 'Content-Type: application/json' \
    -XGET '127.0.0.1:9200/movies/_search?pretty'
```

which yields :

```json
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : 45445,
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "movies",
        "_type" : "movie",
        "_id" : "14",
        "_score" : 1.0,
        "_source" : {
          "id" : "14",
          "title" : "Nixon (1995)",
          "genres" : [
            "Drama"
          ],
          "year" : 1995
        }
      },
      ...
    ]
  }
}
```

### Querying ElasticSearch

#### GET

```bash
$ curl -H 'Content-Type: application/json' \
    -XGET '127.0.0.1:9200/movies/movie/44?pretty'
```
Yields :

```json
{
  "_index" : "movies",
  "_type" : "movie",
  "_id" : "44",
  "_version" : 1,
  "found" : true,
  "_source" : {
    "id" : "44",
    "title" : "Mortal Kombat (1995)",
    "genres" : [
      "Action",
      "Adventure",
      "Fantasy"
    ],
    "year" : 1995
  }
}
```

* NOTE: `_version` here is `1`.

#### POST (update data)

```bash
$ curl -H 'Content-Type: application/json' \
    -XPOST '127.0.0.1:9200/movies/movie/44/_update?pretty' \
    -d '{ "doc": { "title": "Mortal Kombat" } }'
```

Yields :

```json
{
  "_index" : "movies",
  "_type" : "movie",
  "_id" : "44",
  "_version" : 2,
  "result" : "updated",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 9034,
  "_primary_term" : 1
}
```

* NOTE: `_version` bumped to `2`.
* NOTE: We had to wrap the actual data as value of a `"doc"` key.

#### PUT (add duplicate record)

```bash
$ curl -H 'Content-Type: application/json' \
    -XPUT '127.0.0.1:9200/movies/movie/44?pretty' \
    -d '{"title" : "Mortal Kombat", "genres" : ["Action"], "year" : 1995}'
```
Yields :

```json
{
  "_index" : "movies",
  "_type" : "movie",
  "_id" : "44",
  "_version" : 3,
  "result" : "updated",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 9035,
  "_primary_term" : 1
}
```

__NOTE:__ Trying to add a duplicate record will be handled seamlessly by having
a new version of it be inserted, here `_version` = `3`.

## Algorithms

### B-trees, B+ trees

__[Wikipedia : B+ tree](https://en.wikipedia.org/wiki/B%2B_tree)__

* [2014: Oracle B-Tree Index: From the concept to Internals](http://www.toadworld.com/platforms/oracle/w/wiki/11001.oracle-b-tree-index-from-the-concept-to-internals)
via [SO: How to lay out B-Tree data on disk?](https://stackoverflow.com/a/40740893)
* [2014: B+Trees – How SQL Server Indexes are Stored on Disk](http://sqlity.net/en/2445/b-plus-tree/)
