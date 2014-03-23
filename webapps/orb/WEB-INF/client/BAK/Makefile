JC	= javac
#CFLAGS	= -O

# generic
JAVA	= $(wildcard *.java)
CLASS	= $(patsubst %.java, %.class, $(JAVA))

# suffix rules
.SUFFIXES: .java .class

.java.class:
	$(JC) $(CFLAGS) $<

all: $(CLASS)

Client.class : Probe.class

clean:
	rm -f *.class

package: clean
	$(RM) java.tgz
	tar -zcvf java.tgz -C ../ java/


