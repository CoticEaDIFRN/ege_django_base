# ege_django_base

A **Docker** image with **Django 2**, **psycopg2** and **gunicorn**.

Added **python-brfied** to help to read environment variables.

If environment variable `DJANGO_DEBUG` are set to `True` the apps **django-extensions**, **django-debug-toolbar** e **ipdb** will be activates by default to help development.

At **build** cycle the imagem will install packages from `requirements-build.txt`. If you want to add ou change packages at **build** cycle create a file like `requirements-custom.txt` and a `Dockerfile` like this:

```

FROM ege_django_base:1.1-alpine
ADD requirements-custom.txt . 
RUN pip install --upgrade -r requirements-custom.txt

WORKDIR /apps/my_app

```

At **up** cycle the image will install all packages listed at `requirements-app.txt` from yout working dir.
