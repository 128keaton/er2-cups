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
RUN apt-get install -y cups

############################################################
# Install WKHTMLTOPDF
############################################################                  
RUN apt-get install -y wkhtmltopdf xvfb
RUN echo -e '#!/bin/bash\nxvfb-run -a --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf -q $*' > /usr/bin/wkhtmltopdf.sh
RUN chmod a+x /usr/bin/wkhtmltopdf.sh
RUN ln -s /usr/bin/wkhtmltopdf.sh /usr/local/bin/wkhtmltopdf


############################################################
# Configure and start cups
############################################################       
COPY scripts/add-printer.sh /usr/local/sbin/cupsd
CMD ["cupsd", "-f"]

EXPOSE 631

VOLUME /var/log/cups /var/run/cups