FROM kelsoncm/django_psycopg2:1.3

ADD requirements-custom-build.txt /
RUN pip install -r /requirements-custom-build.txt
