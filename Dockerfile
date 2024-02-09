FROM oraclelinux:8

RUN mkdir /app
RUN mkdir /app/fastapi_app/
RUN mkdir /home/oracle
RUN mkdir /app/ssl



WORKDIR /home/oracle


RUN yum -y install oracle-release-el8 && \
    yum -y install gcc python3.11* && \
    rm -rf /var/cache/yum

WORKDIR /app


ADD ./main.py /app/fastapi_app/main.py
ADD ./requirements.txt /app/requirements.txt
ADD ./test.sh /app/test.sh


RUN python3.11 -m venv dbenv
RUN source /app/dbenv/bin/activate && pip3.11 install --upgrade pip && pip3.11 install -r requirements.txt 


ENTRYPOINT /app/test.sh