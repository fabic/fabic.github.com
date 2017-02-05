---
layout: post
title: "From a shell"
description: ""
category: diary
tags: [Symfony, Symfony CMF, PHPCR]
---


    $ mysql -u root -p
    > show databases;
    ...
    > grant all privileges on nymfony.* to fabi@localhost;

    $ ./console doctrine:database:create
    Created database for connection named `nymfony`

    $ ./console doctrine:phpcr:init:dbal
    Jackalope Doctrine DBAL tables have been initialized successfully.

    $ mysql -u cadet -p -e "show tables from nymfony;"
    +----------------------------+
    | Tables_in_nymfony          |
    +----------------------------+
    | phpcr_binarydata           |
    | phpcr_internal_index_types |
    | phpcr_namespaces           |
    | phpcr_nodes                |
    | phpcr_nodes_foreignkeys    |
    | phpcr_type_childs          |
    | phpcr_type_nodes           |
    | phpcr_type_props           |
    | phpcr_workspaces           |
    +----------------------------+

