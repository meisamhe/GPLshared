path=c:\jdk1.3.1\bin
javac -d tmp MnuPrincipal.java
cd tmp
jar cvfm ..\loca.jar manif.txt .
cd ..
java -jar loca.jar