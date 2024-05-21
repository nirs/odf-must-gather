FROM quay.io/openshift/origin-cli:4.15 as builder

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

RUN microdnf update -y \
    && microdnf install -y tar rsync findutils gzip \
    && microdnf clean all

COPY --from=builder /usr/bin/oc /usr/bin/oc

COPY collection-scripts/* /usr/bin/
RUN mkdir -p /templates
COPY templates/* /templates/

ENTRYPOINT /usr/bin/gather
