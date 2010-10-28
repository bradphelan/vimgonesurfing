com! -nargs=1 PGrep grep <args> scripts/*.* SC* app*/**/*.cpp app*/**/*.h lib*/**/*.cpp lib*/**/*.h python*/**/*.py lib*/**/*.py lib*/**/SC* lib*/**/*.yaml release/**/SC* site_scons/**/*.*
set makeprg=scons/scons.py\ -j\ `distcc\ -j`
