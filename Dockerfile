# FROM registry.access.redhat.com/ubi8-minimal
# FROM redhat/ubi8
# FROM registry.access.redhat.com/ubi8/ubi
FROM registry.access.redhat.com/ubi9/ubi-init
# LABEL maintainer=""
# ENV HOME='/runner/'

# RUN microdnf update -y && rm -rf /var/cache/yum
# RUN microdnf install nss_wrapper gettext tar gzip -y \
#     && microdnf clean all

RUN dnf update -y && rm -rf /var/cache/yum
RUN dnf install nss_wrapper gettext tar gzip unzip git dnsutils -y \
    && dnf clean all

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ; \
    unzip awscliv2.zip ; \
    mkdir /.aws ; \
    chmod 777 /.aws ; \
    ./aws/install

RUN curl https://rclone.org/install.sh | bash ; \
    mkdir -p ~/.config ; \
    mkdir -p ~/.config/rclone ; \
    touch ~/.config/rclone/rclone.conf

RUN curl -L -s \
    https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.2.12/openshift-client-linux-4.2.12.tar.gz \
    | tar -C /usr/local/bin/ -zxv oc kubectl ; \
    chmod +x /usr/local/bin/oc ; \
    chmod +x /usr/local/bin/kubectl

### RUN rclone rcd --rc-web-gui
# RUN mkdir /container-scripts/ && cp /etc/passwd /container-scripts/ && chmod 666 /container-scripts/passwd
# RUN mkdir -p /runner/.gitlab-runner/ && chmod -R 777 /runner

# ADD container-scripts/* /container-scripts/

# bla bla 
# chgrp: changing group of '/sys': Read-only file system
# error: build error: error building at STEP "RUN chgrp -R 0 / &&     chmod -R g=u /": error while running runtime: exit status 1
# RUN chgrp -R 0 / && \
    # chmod -R g=u /

### ENTRYPOINT ["/container-scripts/entrypoint.sh"]
ENTRYPOINT ["/bin/sh", "-c", "--" , "while true; do sleep 30; done;"]
### ENTRYPOINT ["/rclone rcd --rc-web-gui"]
