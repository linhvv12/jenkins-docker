FROM ubuntu:latest

RUN apt-get update
RUN apt-get install httpd
RUN apt-get install htop
WORKDIR /var/www/html
COPY .index.html/ /var/www/html/
ENTRYPOINT ["httpd","htop"]
CMD ["-D","FOREGROUND"]