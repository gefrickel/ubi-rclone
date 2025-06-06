# ARG OCP_CLI_VERSION=4.16.8
# FROM registry.access.redhat.com/ubi8-minimal
# FROM redhat/ubi8
# FROM ubi9/python-39
# FROM registry.access.redhat.com/ubi9/ubi-init
FROM ubi9/ubi-init
# LABEL maintainer=""
# ENV HOME='/runner/'

# RUN microdnf update -y && rm -rf /var/cache/yum
# RUN microdnf install nss_wrapper gettext tar gzip -y \
#     && microdnf clean all

# RUN dnf config-manager --set-enabled epel && dnf update -y
# RUN subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
# RUN dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
# RUN dnf config-manager --set-enabled epel && dnf update -y

RUN dnf update -y && rm -rf /var/cache/yum
RUN dnf install -y nss_wrapper gettext tar gzip unzip git dnsutils skopeo wget iputils nmap-ncat screen btop nginx \
    && dnf clean all

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" ; \
    unzip awscliv2.zip ; \
    mkdir /.aws ; \
    chmod 777 /.aws ; \
    ./aws/install

# RUN curl https://rclone.org/install.sh | bash ; \
    # mkdir -p /.config ; \
    # mkdir -p /.config/rclone ; \
    # touch /.config/rclone/rclone.conf

RUN dnf -y install rclone

RUN mkdir -p /tmp/screen ; \
    chmod -R 700 /tmp/screen ; \
    mkdir -p /tmp/rclone

RUN curl -L -s \
    https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.18.8/openshift-client-linux-4.18.8.tar.gz \
    | tar -C /usr/local/bin/ -zxv oc kubectl ; \
    chmod +x /usr/local/bin/oc ; \
    chmod +x /usr/local/bin/kubectl

RUN curl -O \
    https://download2.boulder.ibm.com/sar/CMA/XSA/06asm/2/ibm_utl_sraidmr_storcli-1.18.11_linux_32-64.zip ; \
    unzip ibm_utl_sraidmr_storcli-1.18.11_linux_32-64.zip ; \
    dnf install Linux/storcli-1.18.11-1.noarch.rpm -y

RUN curl \
    https://github.com/operator-framework/operator-registry/releases/download/v1.55.0/linux-amd64-opm -o /usr/local/bin/opm ; \
    chmod +x /usr/local/bin/opm

# RUN dnf -y install httpd 

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

EXPOSE 5722

# CMD ["/usr/sbin/sshd", "-D", "-d", "-e"]
# CMD ["/usr/bin/rclone", "rcd", "--rc-web-gui"]

CMD ["/usr/bin/rclone", "rcd", "--rc-web-gui", "--rc-addr :5572", "--rc-web-gui-no-open-browser", "-vv"  ]


