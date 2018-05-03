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

    - Horizontal scaling :
        * often based on partitioning the data where each node holds part of it.
        * scaling is achieved by adding more machines to the pool;
    - Vertical scaling :
        * all data reside on a single node;
        * scaling is achieved by adding more CPUs/cores and RAM;
        * => and will generally entail server downtime.
        * scaling is limited to the capacities of the machine (e.g. at most 2
          CPUs and some bounded amount of RAM).

## Metrics

* [SLOCs : Source Lines Of Code](https://en.wikipedia.org/wiki/Source_lines_of_code)
    - See also [Cost estimation in software engineering](https://en.wikipedia.org/wiki/Cost_estimation_in_software_engineering)

__EOF__
