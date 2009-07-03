com! -nargs=1 PGrep vimgrep <args> lib*/**/*.cpp lib*/**/*.h python*/**/*.py lib*/**/*.py lib*/**/SC* lib*/**/*.yaml release/**/SC*
set makeprg=scons/scons.py\ -j\ `distcc\ -j`
