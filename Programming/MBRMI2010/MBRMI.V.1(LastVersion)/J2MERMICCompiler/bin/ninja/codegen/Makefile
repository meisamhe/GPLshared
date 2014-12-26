# This Makefile takes care of running 'configure' and then invoking
# 'make -f Makefile.here' to build the code.

all: ./configure Make.rules buildit

./configure: configure.in 
	autoconf

Make.rules: Make.rules.in config.status
	./config.status
     
config.status: ./configure
	./configure

buildit: Makefile.here
	$(MAKE) -f Makefile.here

clean: Makefile.here
	$(MAKE) -f Makefile.here clean

Makefile.here: Make.rules
