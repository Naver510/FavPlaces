#!/bin/bash

# FavPlaces Deployment Script for Bolt.new

echo "Starting FavPlaces deployment..."

# Install Python dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Run migrations
echo "Running database migrations..."
python manage.py makemigrations
python manage.py migrate

# Create superuser (optional)
echo "Creating superuser (optional)..."
python manage.py shell -c "
from app.models import Uzytkownik, Uprawnienia
if not Uzytkownik.objects.filter(Mail='admin@favplaces.com').exists():
    admin_perms = Uprawnienia.objects.get(ID_Uprawnienia=1)
    Uzytkownik.objects.create(
        Imie='Admin',
        Nazwisko='User',
        Mail='admin@favplaces.com',
        Hasło='admin123',
        ID_Uprawnienia=admin_perms
    )
    print('Admin user created')
else:
    print('Admin user already exists')
"

echo "Deployment completed!"
echo "Access your app at the provided bolt.new URL"
