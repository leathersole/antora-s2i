# antora-s2i
FROM centos/nodejs-8-centos7

LABEL maintainer="Takayuki Konishi <seannos.takayuki@gmail.com>"

ENV ANTORA-S2I_VERSION 0.0.3

LABEL io.k8s.description="Platform for building static web site via Antora then publish it" \
      io.k8s.display-name="antora-s2i 0.0.1" \
      io.openshift.expose-services="8080:http" \    
      io.openshift.tags="antora-s2i,0.0.1"

USER root

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
RUN export PATH=$PATH:/opt/rh/rh-nodejs8/root/usr/bin/; npm i -g @antora/cli && BUILD_ONLY=true npm i -g @antora/site-generator-default --unsafe-perm && npm i -g superstatic

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
