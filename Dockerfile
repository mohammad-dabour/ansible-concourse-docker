FROM williamyeh/ansible:centos7
ARG SSH_KEY
ARG USER
WORKDIR /tmp
COPY  .  /tmp
RUN mkdir ~/.ssh
RUN echo "$SSH_KEY" > /tmp/tsa_host_key && chmod 600 /tmp/tsa_host_key
RUN echo "$USER"
RUN echo -e "Host *" > ~/.ssh/config && echo -e "StrictHostKeyChecking no" >> ~/.ssh/config

CMD ansible-playbook -v -i /tmp/inventory /tmp/playbook.yml  -u $USER --private-key /tmp/tsa_host_key --sudo
