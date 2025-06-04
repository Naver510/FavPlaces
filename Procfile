web: cd favplaces && python manage.py collectstatic --noinput && python manage.py migrate && gunicorn favplaces.wsgi:application --bind 0.0.0.0:$PORT
