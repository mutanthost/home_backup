#!/bin/bash

JDK6=/usr/lib/jvm/java-1.6.0-openjdk.x86_64/
JDK7=/usr/lib/jvm/java-1.7.0-openjdk.x86_64/
JDK8=/opt/jdk1.8.0_40/

case "$1" in
          "6")
              export JAVA_HOME=$JDK6
             ;;
          "7")
              export JAVA_HOME=$JDK7
             ;;
          "8")
              export JAVA_HOME=$JDK8
             ;;
          *)
echo "Unknown JDK version! Specify 6, 7 or 8!"
                                                                                                                                ;;
esac

export JDK_HOME=$JAVA_HOME

# echo "Calling 'java' to output the currently used java version"

# java -D -version
