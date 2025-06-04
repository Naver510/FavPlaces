# FavPlaces Project

## Overview
FavPlaces is a Django web application designed to help users discover and manage their favorite places. The application allows users to search for places, view details, and save their favorites.

## Project Structure
The project consists of the following main components:

- **app/**: Contains the core application logic, including models, views, and templates.
- **favplaces/**: Contains the project configuration, including settings and URL routing.
- **media/**: Directory for uploaded media files.
- **supabase/**: Contains migration scripts for setting up and populating the database in Supabase.

## Features
- User authentication and management
- Search functionality for places
- Ability to save and manage favorite places
- Admin interface for managing data

## Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd FavPlaces
   ```
3. Install the required packages:
   ```
   pip install -r requirements.txt
   ```
4. Set up the database:
   - Configure your database settings in `favplaces/settings.py`.
   - Run the migrations:
     ```
     python manage.py migrate
     ```

## Usage
To run the development server, use the following command:
```
python manage.py runserver
```
You can then access the application at `http://127.0.0.1:8000/`.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for any suggestions or improvements.

## License
This project is licensed under the MIT License. See the LICENSE file for details.