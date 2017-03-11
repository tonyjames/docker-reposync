FROM registry.access.redhat.com/rhel6:latest
ARG username
ARG password
ARG pools
RUN subscription-manager register --username=${username} --password=${password} && \
    echo "${pools}" |subscription-manager attach --file=- && \
    subscription-manager repos --disable=* && \
    subscription-manager repos --enable=rhel-6-server-rpms
RUN yum install -y yum-utils createrepo less
