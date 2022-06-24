FROM tomcat:8.0-jre8
MAINTAINER rcharlapalli@gmail.com
COPY target/*.war /usr/local/tomcat/webapps/maven-web-project-1.0-SNAPSHOT.war
EXPOSE 8888
CMD ["catalina.sh", "run"]
