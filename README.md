Editting
--------

This site is a collection of templates that can be compiled with
[jekyll](https://github.com/mojombo/jekyll). Before you compile though, there's an external
dependency that's referenced by a git submodule. To pull in that dependency run:

    git submodule update --init

This'll pull down that dependency at the right revision in your working directory. To compile the
site, run:

    jekyll

To test your changes locally, you can also run:

    jekyll --serve --auto

That'll start an http server that serves locally, at a port that it'll print out. --serve starts the
http server, and --auto tells jekyll to recompile whenever you make a change to the source files.

Deploying
---------

To deploy the site, run  `tasks/deploy [username]` with your ccis username as an argument. In order
to dpeloy, you must have sudo permissions on acm.ccs.neu.edu. Anyone in the acm unix group at ccis
should have that permission. See systems if you should be in that group, but aren't.
