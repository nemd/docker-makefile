docker-makefile
===============

Unified Makefile to work with docker. It's reusable and customised with `Makefile.cfg`.

cfg file is gitignored by default as it might have secrets inside. See example as reference.

Defined tasks
-------------
```
help                           This help.
build                          build tagged image
run-test                       test run container with vars and ports and remove it after stop
run                            start production container in background
ps                             prints docker ps for current container
up                             alias for build and run
stop                           stops container
rm                             removes container
rmi                            removes image
clean                          stop and remove container
clean-all                      stops and removes container and image
logs                           show logs for working container
```
