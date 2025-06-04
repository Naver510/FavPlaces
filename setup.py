#!/usr/bin/env python
"""
Setup script for FavPlaces Django application
"""
import os
import subprocess
import sys

def main():
    """Main setup function"""
    print("🚀 Setting up FavPlaces application...")
    
    # Change to favplaces directory
    os.chdir('favplaces')
    
    # Install dependencies
    print("📦 Installing Python dependencies...")
    subprocess.run([sys.executable, '-m', 'pip', 'install', '-r', '../requirements.txt'])
    
    # Run migrations
    print("🗃️ Running database migrations...")
    subprocess.run([sys.executable, 'manage.py', 'migrate'])
    
    # Collect static files
    print("📁 Collecting static files...")
    subprocess.run([sys.executable, 'manage.py', 'collectstatic', '--noinput'])
    
    print("✅ Setup complete! You can now run: python favplaces/manage.py runserver")

if __name__ == '__main__':
    main()
