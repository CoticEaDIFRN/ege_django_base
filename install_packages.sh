#!/bin/sh


if [[ ! -s "/firsttime.lock" ]]; then
    if [[ -s "requirements-firsttime.txt" ]]; then
        pip install -r requirements-firsttime.txt
        date > /firsttime.lock
    fi
fi


if [[ -s "requirements-app.txt" ]]; then
    pip install -r requirements-app.txt
fi


if [[ "True" = "$DJANGO_DEBUG" ]]; then
    python3 manage.py runserver 0.0.0.0:8000
else
    gunicorn \
        wsgi:application \
        --bind 0.0.0.0:8000 \
        --name root \
        --user root \
        --group root \
        --timeout $GUNICORN_TIMEOUT \
        --workers $GUNICORN_NUM_WORKERS \
        --log-level $GUNICORN_LOG_LEVEL \
        --log-file=-
fi
