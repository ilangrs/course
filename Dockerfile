FROM jetty:9.4.41
ENV WAR_FILE=""
ENV TARGET_FOLDER=""
WORKDIR ${TARGET_FOLDER}
ADD ${WAR_FILE} /var/lib/jetty/webapps/root.war
EXPOSE 8080
