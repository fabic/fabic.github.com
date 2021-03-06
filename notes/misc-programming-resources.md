---
layout: page
title: "Programming resources out there"
tagline: "Collected pointers to programming reference materials out there."
category : notes
tags : [draft]
published: true
---

* __<https://dev.to/rly>__ ([thepracticaldev/orly-full-res](https://github.com/thepracticaldev/orly-full-res "Full resolution images of the O RLY book covers made by The Practical Dev"))
* <https://github.com/timoxley/best-practices>
* <https://github.com/donnemartin/system-design-primer>
* <https://github.com/mtdvio/every-programmer-should-know>
* <https://github.com/P1xt/p1xt-guides>
* <https://github.com/passy/awesome-recursion-schemes>
* [Martin Fowler's PoEAA](https://martinfowler.com/eaaCatalog/) ~ 2003.
* [jefdigital/awesome](https://github.com/jefdigital/awesome) : Many pointers...
* <http://geektyper.com/>
* <https://geekprank.com/hacker/>
* <https://www.trapfi.com/> payment through Git service.
* <https://github.com/felixrieseberg/windows95>
* __[kamranahmedse/developer-roadmap's “Roadmap to becoming a web developer in 2018”](https://github.com/kamranahmedse/developer-roadmap)__

## Concepts

* [Linus Torvalds on debuggers](http://lwn.net/2000/0914/a/lt-debugger.php3)

    > And quite frankly, for most of the real problems (as opposed to the stupid
    > bugs - of which there are many, as the latest crap with "truncate()" has
    > shown us) a debugger doesn't much help. And the real problems are what I
    > worry about. The rest is just details. It will get fixed eventually.

* __YAGNI :__ “You Aren't Gonna Need It”
    - <https://martinfowler.com/bliki/Yagni.html>
    - <https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it>

* __KISS :__ “Keep It Simple, Stupid”
    - <https://en.wikipedia.org/wiki/KISS_principle>

* And __DTSTTCPW :__ “do the simplest thing that could possibly work”

* __Other:__
    - <https://en.wikipedia.org/wiki/If_it_ain%27t_broke,_don%27t_fix_it>
    - <https://en.wikipedia.org/wiki/Don%27t_repeat_yourself>
    - <https://en.wikipedia.org/wiki/Feature_creep>
    - <https://en.wikipedia.org/wiki/Overengineering>
    - _Other, more or less [un]related :_
        * <https://en.wikipedia.org/wiki/Minimum_viable_product>
        * <https://en.wikipedia.org/wiki/List_of_software_development_philosophies>

* [Syntactic Noise (M. Fowler)](https://martinfowler.com/bliki/SyntacticNoise.html)

* [Tree Shaking](https://webpack.js.org/guides/tree-shaking/)

* [Long polling (push technologies)](https://en.wikipedia.org/wiki/Push_technology#Long_polling)

* “The Twelve-factor App” deployment thing (about the (ideology) of a strict
  separation of concerns btw. code and configuration) <https://12factor.net/config>

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

### Design patterns

* [Strategy-pattern @ doctrine-project.org](https://www.doctrine-project.org/projects/doctrine-orm/en/latest/cookbook/strategy-cookbook-introduction.html)

## Semantic Versioning

* [__semver.org__](http://semver.org/)
* [node-semver](https://github.com/npm/node-semver) : That which NPM uses for
  parsing version contraints.
* [2014: "npm install --save" No Longer Using Tildes \| fredkschott.com](http://fredkschott.com/post/2014/02/npm-no-longer-defaults-to-tildes/)
    > - In the simplest terms, the tilde matches the __most recent minor version__
    > (the middle number). ~1.2.3 will match all 1.2.x versions but will miss 1.3.0.
    > - The caret, on the other hand, is more relaxed. It will update you to the
    > __most recent major version__ (the first number). ^1.2.3 will match any 1.x.x
    > release including 1.3.0, but will hold off on 2.0.0.
    > <br>__&mdash; fredkschott.com__

From [semver.org](http://semver.org/) :
> Given a version number MAJOR.MINOR.PATCH, increment the:
> - MAJOR version when you make __incompatible__ API changes,
> - MINOR version when you __add functionality__ in a __backwards-compatible__ manner, and
> - PATCH version when you make __backwards-compatible bug fixes__.
> <br>**― semver.org**

From <https://stackoverflow.com/a/31733623> :

[![Semantic Versioning Cheatsheet; bytearcher.com](https://bytearcher.com/articles/semver-explained-why-theres-a-caret-in-my-package-json/promopics/1-table-semver-plain.png)](https://stackoverflow.com/a/31733623)
[![Semantic Versioning Cheatsheet; bytearcher.com](https://bytearcher.com/goodies/semantic-versioning-cheatsheet/wheelbarrel-with-tilde-caret-white-bg-w1000.jpg "Semantic Versioning Cheatsheet; bytearcher.com")](http://bytearcher.com/goodies/semantic-versioning-cheatsheet/)

### Pre-release versioning 0.x.y

> Major version zero (0.y.z) is for initial development. Anything may change at
> any time. The public API should not be considered stable.
> **― semver.org**

* __0.x__ => Anything can change at anytime => BC breaks are to be expected,
  however the common practice is to to reserve __patches for fixes and internal
  changes__ that _try_ to __maintain BC__; while the minor updates may be anything else.
* __Hence__ NPM (maybe PHP's Composer too?) will have the caret `^` behave like
  tilde `~` for __0.x.y__ “pre-release” version constraints; where for ex.
  `~0.1.2` <=> `^0.1.2` => upgrade to the most recent `0.1` minor but restrict
  to be `<0.2`.

### Examples

__~1.2.3__ | >=1.2.3-0 <1.3.0-0 | _“Reasonably close to 1.2.3”_.
__^1.2.3__ | >=1.2.3-0 <2.0.0-0 | _“Compatible with 1.2.3”_.
__~0.1.2__<br>__^0.1.2__ | >=0.1.2 < 0.2.0 | _pre-release_


### OOP's S.O.L.I.D.

<https://en.wikipedia.org/wiki/SOLID> :

* __SRP:__ Single Responsibility principle ;
* __Open/Closed__ principle ;
* __Liskov substitution__ principle ;
* __Interface Segregation__ principle ;
* __Dependency Inversion__ principle.

__to/read/?:__ [GRASP](https://en.wikipedia.org/wiki/GRASP_(object-oriented_design))

## Metrics

* [SLOCs : Source Lines Of Code](https://en.wikipedia.org/wiki/Source_lines_of_code)
    - See also [cost estimation in software engineering](https://en.wikipedia.org/wiki/Cost_estimation_in_software_engineering)
    - Joke found at [why are software development task estimations regularly off by a factor of 2-3?](http://qr.ae/TUp81w)
    > Typical developer’s day:
    > <br>&ndash; Listen man, you are a developer. Tell me why do you estimate tasks incorrectly so often?
    > <br>&mdash; Imagine that you have to unload a truck. How long does it take?
    > <br>&ndash; A couple of hours.
    > <br>&mdash; It’s a Kamaz.
    > <br>&ndash; 8 hours.
    > <br>&mdash; It’s a Kamaz loaded with sand.
    > <br>&ndash; 12 hours.
    > <br>&mdash; You don’t have any shovel or tools, just your bare hands.
    > <br>&ndash; 2 days.
    > <br>&mdash; It is -40℃ outside.
    > <br>&ndash; 4 days.
    > <br>&mdash; The Kamaz is underwater.
    > <br>&ndash; It doesn’t make any sense, you are changing the conditions! What’s the point? You developers are constantly telling some nonsense instead of simply estimating your work time…

* __tool:__ [AlDanial´s cloc](https://github.com/AlDanial/cloc)
  &ndash; “Count lines of code” &ndash; written in Perl; does a good job &ndash;
  ability to give it a commit hash, or `HEAD` and it will consider just those files
  that are under Git control, ex.:

    ```
    $ cloc HEAD
        1821 text files.
        1785 unique files.
         598 files ignored.

    github.com/AlDanial/cloc v 1.76  T=3.02 s (410.4 files/s, 106625.6 lines/s)
    -------------------------------------------------------------------------------
    Language                     files          blank        comment           code
    -------------------------------------------------------------------------------
    CSS                            166          13764           4230         122450
    JavaScript                     323          13314          18795          75322
    PHP                            487           6480           9048          25284
    Blade                          211           1854            882          11649
    JSON                             8              3              0          10534
    Sass                             9            795            101           4699
    Markdown                         8            309              0            764
    HTML                            15            163              3            662
    Vuejs Component                  7             29              2            390
    Bourne Shell                     1             16              9             38
    XML                              1              1              0             30
    Cucumber                         1              1              0              8
    YAML                             1              1              1              6
    -------------------------------------------------------------------------------
    SUM:                          1238          36730          33071         251836
    -------------------------------------------------------------------------------
    ```

* [Evidence Based Scheduling (2007, Joel Spolsky)](https://www.joelonsoftware.com/2007/10/26/evidence-based-scheduling/)

## Parsing, parsers, top-down / recursive descent, etc

* <http://www.craftinginterpreters.com/parsing-expressions.html> “Crafting Interpreters” online book, __must read__.
* <https://en.wikipedia.org/wiki/Parsing_expression_grammar> (PEGs)
* <https://en.wikipedia.org/wiki/Operator-precedence_parser>
* [1999: Parsing Expressions by Recursive Descent &ndash; Theodore Norvell](https://www.engr.mun.ca/~theo/Misc/exp_parsing.htm)

## CORS

* <https://www.moesif.com/blog/technical/cors/Authoritative-Guide-to-CORS-Cross-Origin-Resource-Sharing-for-REST-APIs/>
* <https://stackoverflow.com/a/13006338/643087>
* <http://promincproductions.com/blog/cross-domain-ajax-request-cookies-cors/>
* <https://stackoverflow.com/a/1850482>
* <https://stackoverflow.com/a/22533680/643087>
* __todo/read:__ [CSRF Mitigation for AJAX Requests (2017, markitzeroday.com)](https://markitzeroday.com/x-requested-with/cors/2017/06/29/csrf-mitigation-for-ajax-requests.html)

## Other

* <https://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149>

    Nice article about common regular expression related to web development.

* [OWASP: Logging cheat sheet](https://www.owasp.org/index.php/Logging_Cheat_Sheet)

* [Slack notification flowchart diagram](https://imgur.com/gallery/0p5bV)

## Misc.

* <https://m.signalvnoise.com/real-work-vs-imaginary-work-8bdb84a7d1da>

__EOF__
