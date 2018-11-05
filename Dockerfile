FROM alpine:3.6

RUN apk --no-cache --update add openssl curl python py-pip && \
  pip install --no-cache-dir --upgrade pip && \
  pip install --no-cache-dir awscli==1.11.167 \
  && aws --version \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl \
  && mkdir opt \
  && mkdir /opt/bin \
  && cd /opt/bin \
  && curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator \
  && chmod +x ./aws-iam-authenticator \
  && cd ../.. \
  && chmod +x /opt/

ADD aws-pull.sh /
RUN chmod +x aws-pull.sh

CMD ./aws-pull.sh