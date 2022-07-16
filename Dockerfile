FROM ubuntu:20.04

ENV TZ=Asia/Kathmandu
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y python3-dev libffi-dev gcc libssl-dev python3-pip

RUN pip3 install -U pip \
    && pip install 'ansible>=4,<6'

WORKDIR /srv/kolla-ansible

COPY . .

RUN pip3 install . \
    && kolla-ansible install-deps

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
