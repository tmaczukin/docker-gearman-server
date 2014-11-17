FROM debian:jessie

MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

# SYSTEM PREPARE
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y # update_20140910111213
RUN apt-get install -y --no-install-recommends locales && apt-get clean


# Set locale (fix locale warnings)
RUN echo "Europe/Warsaw" > /etc/timezone
RUN sed -i 's/# pl_PL.UTF-8/pl_PL.UTF-8/' /etc/locale.gen
RUN export LANG=pl_PL.UTF-8
RUN dpkg-reconfigure locales
RUN dpkg-reconfigure tzdata

RUN apt-get install -y --no-install-recommends gearman-job-server && apt-get clean

ADD init /usr/local/sbin/init
RUN chown root:root /usr/local/sbin/init && chmod 700 /usr/local/sbin/init

EXPOSE 4730

ENTRYPOINT ["/usr/local/sbin/init"]
CMD ["start"]

