#!/bin/bash
set -e

# preferable to fire up Tomcat via start-tomcat.sh which will start Tomcat with
# security manager, but inheriting containers can also start Tomcat via
# catalina.sh

if [ "$1" = 'start-tomcat.sh' ] || [ "$1" = 'catalina.sh' ]; then
    ###
    # ETT Custom user
    groupadd --gid 2001 usremodnetdata && \
        useradd -u 2001 -g usremodnetdata -s /bin/bash usremodnetdata
    ###

    USER_ID=${TOMCAT_USER_ID:-1000}
    GROUP_ID=${TOMCAT_GROUP_ID:-1000}

    ###
    # Tomcat user
    ###
    groupadd -r tomcat -g ${GROUP_ID} && \
    useradd -u ${USER_ID} -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin \
        -c "Tomcat user" tomcat
    # Set GECOS field for tomcat user
    #chfn --other='umask=0002' tomcat

    ###
    # Change CATALINA_HOME ownership to tomcat user and tomcat group
    # Restrict permissions on conf
    ###

    chown -R tomcat:tomcat ${CATALINA_HOME} && chmod 400 ${CATALINA_HOME}/conf/*
    sync

    ###
    # ETT Custom user
    usermod -a -G usremodnetdata tomcat
    ###

    cd /usr/local/tomcat/bin
    pwd=$(digest.sh -a "sha-512" $ncwmspassword)    
    pwd=$(echo "$pwd"|grep $ncwmspassword)
    IFS=':'
    read -ra ADDR <<<"$pwd"
    pwd=${ADDR[1]}    
    sed -i "s/xxx/$pwd/g" /usr/local/tomcat/conf/tomcat-users.xml
    #sed -i "s/823f3f8e9a2727375993229e4a71593618441c07/$pwd/g" /usr/local/tomcat/conf/tomcat-users.xml

    exec gosu tomcat "$@"
fi

exec "$@"
