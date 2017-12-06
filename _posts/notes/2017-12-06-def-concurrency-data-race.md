---
layout: note
title: "Data race (definition)"
tagline: ""
category : notes
tags : [note, memory, concurrency]
---

A data race is a particular type of race condition in which these three
behaviors occur [[Rust](https://doc.rust-lang.org/book/second-edition/ch04-02-references-and-borrowing.html)]:

* Two or more pointers access the same data at the same time.
* At least one of the pointers is being used to write to the data.
* There’s no mechanism being used to synchronize access to the data.
