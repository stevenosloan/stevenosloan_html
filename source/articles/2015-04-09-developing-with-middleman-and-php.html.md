---
title: Developing with Middleman and PHP
date: 2015/04/09
draft: true
---

sometimes you just need a simple form


now that php has a built in webserver

this isn't necesarraly perfect, need to make sure your php version matches between dev & production are the same

can setup apache/nginx locally to look at this directory as well for a little more performance or parity with your production environment


now, for the updating portion. previous was using some rack middleware to shell out and build the file, the flow is different here since we're just direclty service built files

use guard to watch the source directory and run a build as necessary.
