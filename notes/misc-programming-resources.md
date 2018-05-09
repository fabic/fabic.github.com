---
layout: page
title: "Programming resources out there"
tagline: "Collected pointers to programming reference materials out there."
category : notes
tags : [draft]
published: true
---

* <https://github.com/timoxley/best-practices>
* <https://github.com/donnemartin/system-design-primer>
* <https://github.com/mtdvio/every-programmer-should-know>
* <https://github.com/P1xt/p1xt-guides>
* <https://github.com/passy/awesome-recursion-schemes>
* [Martin Fowler's PoEAA](https://martinfowler.com/eaaCatalog/) ~ 2003.
* [jefdigital/awesome](https://github.com/jefdigital/awesome) : Many pointers...

## Concepts

* [Syntactic Noise (M. Fowler)](https://martinfowler.com/bliki/SyntacticNoise.html)

* [Tree Shaking](https://webpack.js.org/guides/tree-shaking/)

* [Long polling (push technologies)](https://en.wikipedia.org/wiki/Push_technology#Long_polling)

* On [horizontal _versus_ vertical scaling](https://stackoverflow.com/a/11715598):

    > Horizontal scaling means that you scale by adding more machines into your
    > pool of resources whereas Vertical scaling means that you scale by adding
    > more power (CPU, RAM) to an existing machine.
    > ![horizontal-versus-vertical-scaling--On3tO.png](/assets/horizontal-versus-vertical-scaling--On3tO.png)
    > ![Scale Up versus Scale Out](/assets/scale-up--versus--scale-out--nati-shalom.png "Scale Up versus Scale Out (Nati Shalom)")

    - Horizontal scaling :
        * often based on partitioning the data where each node holds part of it.
        * scaling is achieved by adding more machines to the pool;
    - Vertical scaling :
        * all data reside on a single node;
        * scaling is achieved by adding more CPUs/cores and RAM;
        * => and will generally entail server downtime.
        * scaling is limited to the capacities of the machine (e.g. at most 2
          CPUs and some bounded amount of RAM).
    - Must read :
        * [Scale-out vs Scale-up (2010, Nati Shalom)](http://ht.ly/cAhPe)
        * [The Common Principles Behind the NOSQL Alternatives (2009, Nati Shalom)](http://ht.ly/cAhY6)

* RESTful
    - HATEOAS :: “Hypermedia As The Engine Of Application State” :
        > A hypermedia-driven site provides information to navigate the site's REST
        > interfaces dynamically __by including hypermedia links with the responses__.
        > This capability differs from that of SOA-based systems and WSDL-driven
        > interfaces. With SOA, servers and clients usually must access a __fixed
        > specification__ that might be staged somewhere else on the website, on
        > another website, or perhaps distributed by email.
        > <br>__via:__ <https://spring.io/understanding/HATEOAS>

        See also <https://en.wikipedia.org/wiki/HATEOAS>

## Metrics

* [SLOCs : Source Lines Of Code](https://en.wikipedia.org/wiki/Source_lines_of_code)
    - See also [Cost estimation in software engineering](https://en.wikipedia.org/wiki/Cost_estimation_in_software_engineering)

__EOF__
