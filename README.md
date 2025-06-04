# FavPlaces - Aplikacja do zarządzania ulubionymi miejscami

## Uruchomienie na bolt.new

### 1. Konfiguracja Supabase
1. Idź do [Supabase Dashboard](https://supabase.com/dashboard)
2. Otwórz projekt `hjlkbozrkpgsjgfgudhw`
3. W SQL Editor uruchom schema:

```sql
-- Skopiuj zawartość z supabase_schema.sql i uruchom
```

### 2. Ustawienie hasła bazy danych
1. W Supabase: Settings → Database
2. Ustaw nowe hasło dla użytkownika `postgres`
3. Zaktualizuj `SUPABASE_DB_PASSWORD` w pliku `.env`

### 3. Uruchomienie w bolt.new
```bash
# Instalacja zależności
pip install -r requirements.txt

# Przejście do katalogu aplikacji
cd favplaces

# Migracje bazy danych
python manage.py migrate

# Uruchomienie serwera
python manage.py runserver 0.0.0.0:8000
```

## Struktura projektu
