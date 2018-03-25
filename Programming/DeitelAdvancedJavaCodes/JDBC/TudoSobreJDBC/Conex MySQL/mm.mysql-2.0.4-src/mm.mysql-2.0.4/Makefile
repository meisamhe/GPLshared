#
# Makefile for mm mysql drivers
#

JAVAC_1 = ///f/jdk1.1.8/bin/javac
JAVAC_2 = ///f/jdk1.3/bin/javac
JAVAC_FLAGS =-g 
JAR = ///f/jdk1.3/bin/jar

JDBC_CORE_PREFIX=org/gjt/mm/mysql

JDBC_CORE_TARGETS=$(JDBC_CORE_PREFIX)/Buffer.class \
                  $(JDBC_CORE_PREFIX)/Connection.class \
                  $(JDBC_CORE_PREFIX)/DatabaseMetaData.class \
                  $(JDBC_CORE_PREFIX)/Debug.class \
                  $(JDBC_CORE_PREFIX)/Driver.class \
                  $(JDBC_CORE_PREFIX)/EscapeProcessor.class \
                  $(JDBC_CORE_PREFIX)/EscapeTokenizer.class \
                  $(JDBC_CORE_PREFIX)/Field.class \
                  $(JDBC_CORE_PREFIX)/MysqlDefs.class \
                  $(JDBC_CORE_PREFIX)/MysqlIO.class \
                  $(JDBC_CORE_PREFIX)/PreparedStatement.class \
                  $(JDBC_CORE_PREFIX)/ResultSet.class \
                  $(JDBC_CORE_PREFIX)/ResultSetMetaData.class \
                  $(JDBC_CORE_PREFIX)/SQLError.class \
                  $(JDBC_CORE_PREFIX)/Statement.class \
                  $(JDBC_CORE_PREFIX)/Token.class \
                  $(JDBC_CORE_PREFIX)/Util.class

JDBC1_TARGETS = $(JDBC_CORE_PREFIX)/jdbc1/Connection.class \
                $(JDBC_CORE_PREFIX)/jdbc1/DatabaseMetaData.class \
                $(JDBC_CORE_PREFIX)/jdbc1/IO.class \
                $(JDBC_CORE_PREFIX)/jdbc1/Statement.class \
                $(JDBC_CORE_PREFIX)/jdbc1/ResultSet.class \
                $(JDBC_CORE_PREFIX)/jdbc1/ResultSetMetaData.class

JDBC2_TARGETS = $(JDBC_CORE_PREFIX)/jdbc2/Connection.class \
                $(JDBC_CORE_PREFIX)/jdbc2/DatabaseMetaData.class \
                $(JDBC_CORE_PREFIX)/jdbc2/IO.class \
                $(JDBC_CORE_PREFIX)/jdbc2/NotImplemented.class \
                $(JDBC_CORE_PREFIX)/jdbc2/PreparedStatement.class \
                $(JDBC_CORE_PREFIX)/jdbc2/ResultSet.class \
                $(JDBC_CORE_PREFIX)/jdbc2/ResultSetMetaData.class \
                $(JDBC_CORE_PREFIX)/jdbc2/Statement.class

JAVAX_TARGETS = $(JDBC_CORE_PREFIX)/MysqlDataSource.class \
                $(JDBC_CORE_PREFIX)/MysqlDataSourceFactory.class

all: jdbc1 jdbc2 
#javax

jdbc_core: $(JDBC_CORE_TARGETS) 

jdbc1: jdbc_core $(JDBC1_TARGETS) 

jdbc2: jdbc_core $(JDBC2_TARGETS)

javax: jdbc_core $(JAVAX_TARGETS)

$(JDBC_CORE_TARGETS): %.class: %.java
	$(JAVAC_1) $(JAVAC_FLAGS) $<

$(JDBC1_TARGETS): %.class: %.java
	$(JAVAC_1) $(JAVAC_FLAGS) $<

$(JDBC2_TARGETS): %.class: %.java
	$(JAVAC_2) $(JAVAC_FLAGS) $<

$(JAVAX_TARGETS): %.class: %.java
	$(JAVAC_2) $(JAVAC_FLAGS) $<

jar: all
	$(JAR) -cv0f mysql_1_uncomp.jar org/gjt/mm/mysql/*.class org/gjt/mm/mysql/jdbc1/*.class; $(JAR) -cvf mysql_1_comp.jar org/gjt/mm/mysql/*.class org/gjt/mm/mysql/jdbc1/*.class;$(JAR) -cv0f mysql_2_uncomp.jar org/gjt/mm/mysql/*.class org/gjt/mm/mysql/jdbc2/*.class; $(JAR) -cvf mysql_2_comp.jar org/gjt/mm/mysql/*.class org/gjt/mm/mysql/jdbc2/*.class; $(JAR) -cvf mysql_both_comp.jar org/gjt/mm/mysql/*.class org/gjt/mm/mysql/jdbc1/*.class org/gjt/mm/mysql/jdbc2/*.class; $(JAR) -cv0f mysql_both_uncomp.jar org/gjt/mm/mysql/*.class org/gjt/mm/mysql/jdbc1/*.class org/gjt/mm/mysql/jdbc2/*.class

clean:
	rm -f $(JDBC_CORE_PREFIX)/*.class \
	      $(JDBC_CORE_PREFIX)/jdbc1/*.class \
	      $(JDBC_CORE_PREFIX)/jdbc2/*.class \
	      $(JDBC_CORE_PREFIX)/*~ \
	      $(JDBC_CORE_PREFIX)/jdbc1/*~ \
	      $(JDBC_CORE_PREFIX)/jdbc2/*~

gjt:
	cp CHANGES README COPYING ../mm-for-gjt/java/org/gjt/mm/mysql; cp org/gjt/mm/mysql/*.java ../mm-for-gjt/java/org/gjt/mm/mysql
