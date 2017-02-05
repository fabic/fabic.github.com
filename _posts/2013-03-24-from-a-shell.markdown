---
layout: post
title: "from a shell (SonataEasyExtends...)"
description: ""
category: diary
tags: []
---


	~/dev/nymfony2 (cmf ✗)  composer.phar require sonata-project/notification-bundle:2.2.*@dev
	composer.json has been updated
	Loading composer repositories with package information
	Updating dependencies (including require-dev)
	  - Installing sonata-project/notification-bundle (dev-master 228b5df)
		Cloning 228b5df96cb828098f6a0cab0b81a88210723110

	sonata-project/notification-bundle suggests installing guzzle/guzzle (3.*)
	sonata-project/notification-bundle suggests installing liip/monitor-bundle (0.4.*)
	sonata-project/notification-bundle suggests installing videlalvaro/php-amqplib (2.0.*)


	~/dev/nymfony2 (cmf ✗)  ./console sonata:easy-extends:generate --dest=src/ SonataPageBundle
	Processing bundle : "SonataPageBundle"
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/Resources/config/doctrine
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/Resources/config/routing
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/Resources/views
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/Command
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/DependencyInjection
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/Entity
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/Document
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/PHPCR
	  > generating bundle directory /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/Controller
	  > generating bundle file /home/fabi/dev/nymfony2/src/Application/Sonata/PageBundle/ApplicationSonataPageBundle.php
	Processing Doctrine ORM : "SonataPageBundle"
	 - Copy entity files
	   + Site.orm.xml
	   + Block.orm.xml
	   + Page.orm.xml
	   + Snapshot.orm.xml
	 - Generating entity files
	   + Site
	   + Block
	   + Page
	   + Snapshot
	 - Generating entity repository files
	   ! SiteRepository
	   ! BlockRepository
	   ! PageRepository
	   ! SnapshotRepository
	Processing Doctrine ODM : "SonataPageBundle"
	 - Copy document files
	 - Generating document files
	 - Generating document repository files
	Processing Doctrine PHPCR : "SonataPageBundle"
	 - Copy Document files
	 - Generating Document files
	 - Generating Document repository files

	done!
