FROM tomcat:9.0-jdk21-temurin

# Limpia apps por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia el WAR generado por NetBeans al contenedor
# OJO: cambia Stream.war por el nombre REAL de tu .war en dist/
COPY dist/Stream.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
