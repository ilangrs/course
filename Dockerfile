FROM jetty:9.4.41
ENV WAR_FILE=""
WORKDIR ${WAR_FILE}
ADD . /var/lib/jetty/webapps/root.war
EXPOSE 8080
