FROM ubuntu:14.04
MAINTAINER mukki
#plugins
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install apache2 openssl git nano 
RUN mkdir /opt/in
RUN git clone -b prod https://github.com/mukendra/new1.git /opt/in
RUN cp /opt/in/new1/000-default.conf  /etc/apache2/sites-available
RUN a2enmod ssl
RUN mkdir /etc/apache2/ssl
RUN cp /opt/in/new1/apache.key /etc/apache2/ssl
RUN cp /opt/in/new1/apache.crt /etc/apache2/ssl
RUN a2ensite default-ssl
RUN a2ensite  default-ssl.conf
RUN apt-get -y install php5
RUN apt-get -y install php5-mysql wget nano
WORKDIR /opt
RUN git clone -b prod https://github.com/mukendra/new.git
#RUN tar xvzf latest.tar.gz
RUN chmod 777 /opt/new
RUN chmod 777 /opt/new/*
#RUN cp /opt/wp-config.php /opt/wp-config.php
RUN cp -R /opt/* /var/www/html/
RUN cp /opt/in/new1/wp-config.php /var/www/html/wp-config.php
RUN chown -R www-data:www-data  /var/www/html
RUN chmod -R 755 /var/www/html/
EXPOSE 80 3306 443
ENTRYPOINT service apache2 restart && sleep 3600
