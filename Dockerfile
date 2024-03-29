FROM ubuntu
MAINTAINER Ray van Toll

RUN apt-get update && apt-get install -y openssh-server xauth 
RUN mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && chmod 700 /root/.ssh \
    && ssh-keygen -A
RUN sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/g" /etc/ssh/sshd_config
RUN sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/g" /etc/ssh/sshd_config
RUN sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/g" /etc/ssh/sshd_config
RUN sed -i "s/^.*PermitUserEnvironment.*$/PermitUserEnvironment yes/g" /etc/ssh/sshd_config

ADD ./entrypoint.sh .
RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["sh", "entrypoint.sh"]
