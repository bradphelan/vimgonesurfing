com! -nargs=1 PGrep vimgrep <args> scripts/*.* SC* lib*/**/*.cpp lib*/**/*.h python*/**/*.py lib*/**/*.py lib*/**/SC* lib*/**/*.yaml release/**/SC* site_scons/**/*.*
set makeprg=scons/scons.py\ -j\ `distcc\ -j`
