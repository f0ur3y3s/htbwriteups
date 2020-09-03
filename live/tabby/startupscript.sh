#!/bin/sh # # Startup script for Apache Tomcat with systemd # set -e # Load the service settings . /etc/default/tomcat9 # Find the Java runtime and set JAVA_HOME . /usr/libexec/tomcat9/tomcat-locate-java.sh # Set the JSP compiler if configured in the /etc/default/tomcat9 file [ -n "$JSP_COMPILER" ] && JAVA_OPTS="$JAVA_OPTS -Dbuild.compiler=\"$JSP_COMPILER\"" export JAVA_OPTS # Enable the Java security manager? SECURITY="" [ "$SECURITY_MANAGER" = "true" ] && SECURITY="-security" # Start Tomcat cd $CATALINA_BASE && exec $CATALINA_HOME/bin/catalina.sh run $SECURITY 