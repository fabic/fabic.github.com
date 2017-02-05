---
layout: post
title: "from a shell"
description: "Symfony CMF, by hand, non-terminated..."
tagline: "on a rainy day"
category: diary
tags: [Symfony, Symfony CMF]
---

_Now, that's a rainy and windy day, can't go out._

## Symfony CMF

<http://cmf.symfony.com/> : I guess I'm about to try to install that thing by hand.

	# Failed :
	composer.phar require symfony-cmf/symfony-cmf:1.0.*@dev

	# Had to make 1.0.*@dev explicit :
	composer.phar require \
		symfony-cmf/symfony-cmf:1.0.*@dev \
		doctrine/phpcr-odm:1.0.*@dev \
		symfony-cmf/core-bundle:1.0.*@dev \
		friendsofsymfony/jsrouting-bundle:dev-master \
		symfony-cmf/tree-browser-bundle:1.0.*@dev \
		symfony-cmf/content-bundle:1.0.*@dev \
		symfony-cmf/menu-bundle:1.0.*@dev \
		symfony-cmf/block-bundle:1.0.*@dev \
		doctrine/phpcr-bundle:1.0.*@dev
	...
	...
	doctrine/phpcr-odm suggests installing midgard/phpcr (>=1.3)
	doctrine/phpcr-odm suggests installing jackalope/jackalope-doctrine-dbal (>=1.0.0-alpha1)
	doctrine/phpcr-bundle suggests installing doctrine/data-fixtures (if you want to use the fixture loading)
	doctrine/phpcr-bundle suggests installing liip/imagine-bundle (when using the phpcr_odm_image form type)
	symfony-cmf/block-bundle suggests installing eko/feedbundle (To use the RssBlock)
	symfony-cmf/block-bundle suggests installing liip/imagine-bundle (When using the ImagineBlock)
	symfony-cmf/menu-bundle suggests installing sonata-project/doctrine-phpcr-admin-bundle (if you want to have editing capabilities)
	symfony-cmf/content-bundle suggests installing friendsofsymfony/rest-bundle (Improved handling for different output formats)
	symfony-cmf/symfony-cmf suggests installing symfony-cmf/simple-cms-bundle (1.0.*)

_After miscellaneous wanderings in online doc., **[10 commits, no code, only setup & configuration](https://github.com/fabic/Nymfony/compare/cbe9008...b83f854)**._

_Humm... I shall have played with the sandbox instead :/_
