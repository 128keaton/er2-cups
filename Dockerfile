############################################################
# Based on Debian Streaaaaaaaaaaaaaaaaaaåtch
############################################################

FROM debian:stretch

MAINTAINER Keaton Burleson keaton.burleson@me.com 


############################################################
# Arguments
############################################################
ENV DEBIAN_FRONTEND noninteractive
ENV WK_VERSION 0.12.4


############################################################
# Install Essential Packages
############################################################
RUN apt-get update
RUN apt-get install -y cups \
                        build-essential \
                        xorg \
                        libssl-dev \
                        libxrender-dev \
                        wget \
                        gdebi

############################################################
# Install WKHTMLTOPDF
############################################################                  
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/$WK_VERSION/wkhtmltox-$WK_VERSION_linux-generic-amd64.tar.xz
RUN gdebi --n wkhtmltox-0.12.2.1_linux-trusty-amd64.deb


############################################################
# Configure and start cups
############################################################       
COPY scripts/add-printer.sh /usr/local/sbin/cupsd
CMD ["cupsd", "-f"]

EXPOSE 631

VOLUME /var/log/cups /var/run/cups