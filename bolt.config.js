module.exports = {
  framework: 'django',
  buildCommand: 'pip install -r requirements.txt && cd favplaces && python manage.py collectstatic --noinput',
  startCommand: 'cd favplaces && python manage.py runserver 0.0.0.0:8000',
  installCommand: 'pip install -r requirements.txt',
  env: {
    PYTHON_VERSION: '3.11.0',
    DJANGO_SETTINGS_MODULE: 'favplaces.settings'
  }
};
