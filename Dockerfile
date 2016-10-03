FROM nginx

RUN apt-get update
RUN apt-get install -y git python-virtualenv --force-yes
RUN mkdir /root/.ssh/

COPY ["devops/id_rsa", "/root/.ssh/id_rsa"]
COPY ["devops/id_rsa.pub", "/root/.ssh/id_rsa.pub"]
COPY ["devops/container_setup", "/home/root/container_setup"]

ADD ["devops/container_setup", "/usr/share/nginx/html"]
#
RUN touch /root/.ssh/known_hosts
RUN chmod 400 /root/.ssh/id_rsa
RUN chmod 755 /home/root/container_setup
RUN ssh-keyscan -t rsa github.com > /root/.ssh/known_hosts

RUN touch /usr/share/nginx/html/test
