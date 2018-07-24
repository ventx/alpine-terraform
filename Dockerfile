FROM ventx/alpine

ENV GLIBC 2.25-r0
ENV TERRAFORM_VERSION 0.11.7

RUN curl -L https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
    curl -L https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC}/glibc-${GLIBC}.apk -o glibc-${GLIBC}.apk && \
    apk add glibc-${GLIBC}.apk && \
    rm glibc-${GLIBC}.apk

RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN apk --update --no-cache add git openssh-client python py-pip python3 && pip install awscli

WORKDIR /work

CMD ["/bin/bash"]
