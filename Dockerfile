FROM python:3.8-alpine

ENV PYTHONUNBUFFERED 1

RUN apk update && \
    apk add postgresql-libs && \
    apk add --virtual .build-deps gcc python3-dev musl-dev postgresql-dev jpeg-dev zlib-dev && \
    pip install psycopg2-binary pillow && \
    apk --purge del .build-deps gcc python3-dev musl-dev postgresql-dev

ADD requirements-build.txt . 

RUN pip install -r /requirements-build.txt

ADD install_packages.sh .

ADD startup.sh .
WORKDIR /apps/app
CMD /startup.sh
