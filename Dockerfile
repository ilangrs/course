FROM jetty:9.4.41
ENV WAR_FILE=""
ENV WAR_FOLDER=""
WORKDIR ${WAR_FOLDER}
ADD ${WAR_FILE} /var/lib/jetty/webapps/root.war
EXPOSE 8080
