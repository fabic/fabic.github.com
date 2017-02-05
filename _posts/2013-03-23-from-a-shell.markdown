---
layout: post
title: "from a shell (SonataUserBundle)"
description: ""
category: diary
tags: []
---



## SonataUserBundle

<http://sonata-project.org/bundles/user/master/doc/reference/installation.html#extending-the-bundle>

		~/dev/nymfony2 (cmf ✗)  ./console sonata:easy-extends:generate --dest=src/ SonataUserBundle
		Processing bundle : "SonataUserBundle"
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/Resources/config/doctrine
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/Resources/config/routing
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/Resources/views
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/Command
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/DependencyInjection
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/Entity
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/Document
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/PHPCR
		  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/Controller
		  > generating bundle file /home/fabi/dev/nymfony2/src/Application/Sonata/UserBundle/ApplicationSonataUserBundle.php
		Processing Doctrine ORM : "SonataUserBundle"
		 - Copy entity files
		   + Group.orm.xml
		   + User.orm.xml
		 - Generating entity files
		   + Group
		   + User
		 - Generating entity repository files
		   ! GroupRepository
		   ! UserRepository
		Processing Doctrine ODM : "SonataUserBundle"
		 - Copy document files
		   + User.mongodb.xml
		   + Group.mongodb.xml
		 - Generating document files
		   + User
		   + Group
		 - Generating document repository files
		   ! UserRepository
		   ! GroupRepository
		Processing Doctrine PHPCR : "SonataUserBundle"
		 - Copy Document files
		 - Generating Document files
		 - Generating Document repository files

		done!


		./console fos:user:create --super-admin fabi fabi@randombinarythoughts.com 1234
