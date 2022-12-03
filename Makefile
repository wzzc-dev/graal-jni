jni: 
	javac Hello.java
	javac -h ./ Hello.java

compile-lib:
	gcc -Wall -O2 -fPIC -I ./  -c -o lib/welcome.o lib/welcome.c
	ar crv libwelcome.a lib/welcome.o

compile-jni:
	gcc -Wall -O2 -fPIC -I $(JAVA_HOME)/include/ -I $(JAVA_HOME)/include/linux/ -I./  -c -o demo.o demo.c
	gcc -shared demo.o -L. -lwelcome -o libdemo.so

compile-jar: compile-lib jni compile-jni  Hello.class manifest.txt
	jar cfm ./Hello.jar manifest.txt Hello.class

run-jar: compile-jar
	java -jar -Djava.library.path=./ Hello.jar
	java -Djava.library.path=./ Hello

clean:
	rm -rf demo.o welcome.o Hello.build_artifacts.txt reports Hello.jar demo.o libdemo.so \
		Hello Hello.class

Hello.jar: Hello.class manifest.txt
	jar cfm ./Hello.jar manifest.txt Hello.class

compile-native: compile-lib jni compile Hello.jar
	$(JAVA_HOME)/bin/native-image \
		-jar Hello.jar \
		-H:Name=Hello \
		-H:+ReportExceptionStackTraces \
		-H:ConfigurationFileDirectories=config-dir \
		--initialize-at-run-time=Hello \
		--verbose \
		--no-fallback \
		--no-server \
		"-J-Xmx1g" \
		-H:+PrintClassInitialization
run-native:
	LD_LIBRARY_PATH=./ ./Hello
