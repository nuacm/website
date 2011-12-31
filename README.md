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
