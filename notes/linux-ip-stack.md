---
#layout: default
ayout: page
title: "Networks: Linux IP stack, routing, iptables firewall, etc (notes)"
tagline: "Personal notes about Linux networking."
category : networking
tags : [draft, network]
published: false
---

???

`host fabic.net`
`dig`
`curl`
`netcat` vs `socat`

Query the RIPE database with `whois <ip>`

```bash
$ ip rule list
```

__TODO:__ [Monty Hall problem](https://en.wikipedia.org/wiki/Monty_Hall_problem) and
statistical packets classification (with e.g. __fwmark, connmark__) :

> Vos Savant's response was that the contestant should switch to the other door
> (vos Savant 1990a). Under the standard assumptions, contestants who switch
> have a 2/3 chance of winning the car, while contestants who stick to their
> initial choice have only a 1/3 chance.


## Pointers, references

* [Linux Advanced Routing & Traffic Control HOWTO @ lartc.org](http://lartc.org/howto/)

* [ip-sysctl.txt @ kernel.org](https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt)
  about those `sysctl -a | grep '^net\.'` IPv4 and IPv6 kernel variables, e.g. :

    - ip\_forward
    - fwmark\_reflect
    - tcp\_syncookies
    - ip\_local\_port\_range
    - ip\_local\_reserved\_ports
    - ip\_unprivileged\_port\_start
    - forwarding
    - secure\_redirects
    - rp\_filter

* Linux' Netfilter packet flow graph :

    ![Netfilter-packet-flow.SVG](https://upload.wikimedia.org/wikipedia/commons/3/37/Netfilter-packet-flow.svg)
    ([Netfilter-packet-flow.PNG](http://inai.de/images/nf-packet-flow.png))

## EOF
