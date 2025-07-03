FROM unidata/tomcat-docker:9.0-jdk11

RUN wget 'https://github.com/Reading-eScience-Centre/ncwms/releases/download/ncwms-2.5.2/ncWMS2.war' -O $CATALINA_HOME/webapps/ncWMS.war
RUN unzip $CATALINA_HOME/webapps/ncWMS.war -d $CATALINA_HOME/webapps/ncWMS/

COPY ./config /ncWMS/config
COPY entrypoint.sh /ncWMS/entrypoint.sh

RUN sed -i -e 's/DIGEST/BASIC/' $CATALINA_HOME/webapps/ncWMS/WEB-INF/web.xml && \
    cp /ncWMS/config/setenv.sh $CATALINA_HOME/bin/setenv.sh && \
    cp /ncWMS/config/ecache.xml $CATALINA_HOME/conf/ecache.xml && \
    cp /ncWMS/config/web.xml $CATALINA_HOME/conf/web.xml && \
    cp /ncWMS/config/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml && \
    mkdir -p $CATALINA_HOME/conf/Catalina/localhost/ && \
    cp /ncWMS/config/ncWMS.xml $CATALINA_HOME/conf/Catalina/localhost/ncWMS.xml && \
    mkdir -p $CATALINA_HOME/.ncWMS2 && \
    cp /ncWMS/config/config.xml $CATALINA_HOME/.ncWMS2/config.xml && \
    mkdir -p /usr/local/tomcat/.ncWMS2 && \
    mkdir -p /usr/local/tomcat/.ncWMS2/palettes && \
    mkdir -p /usr/local/tomcat/.ncWMS2/styles

ENTRYPOINT ["/ncWMS/entrypoint.sh"]

EXPOSE 8080 8443 9090
CMD ["catalina.sh", "run"]
