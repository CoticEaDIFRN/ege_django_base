FROM python:3.9.5-alpine3.13

ENV PYTHONUNBUFFERED 1

RUN apk update && \
    apk add --virtual .build-deps gcc python3-dev musl-dev postgresql-dev jpeg-dev zlib-dev libffi-dev openssl-dev cargo && \
    apk add postgresql-libs py3-cffi libjpeg && \
    pip install --upgrade pip && \
    pip install psycopg2-binary==2.8.6 && \
    pip install pillow==8.2.0 && \
    pip install social-auth-app-django==4.0.0 && \
    apk --purge del .build-deps

ADD install_packages.sh .
ADD startup.sh .

ADD requirements.txt .
RUN pip install --use-feature=2020-resolver -r /requirements.txt

WORKDIR /apps/app
CMD /startup.sh