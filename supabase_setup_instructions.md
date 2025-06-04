# 🚀 Instrukcje konfiguracji Supabase dla FavPlaces

## Krok 1: Sprawdź dane połączenia
W Supabase Dashboard:
1. Idź do **Settings** → **Database**
2. Sprawdź czy dane się zgadzają:
   - **Host**: `db.hjlkbozrkpgsjgfgudhw.supabase.co`
   - **Database name**: `postgres`
   - **Username**: `postgres.hjlkbozrkpgsjgfgudhw` (albo `postgres`)
   - **Port**: `5432`

## Krok 2: Ustaw/sprawdź hasło
1. W sekcji **Database password**
2. Kliknij **Reset database password**
3. Ustaw hasło: `rabarbar123!@`
4. Kliknij **Update password**

## Krok 3: Uruchom schema SQL
1. Idź do **SQL Editor**
2. Kliknij **New query**
3. Wklej cały kod ze schematu (podany niżej)
4. Kliknij **Run**

## Schema SQL do uruchomienia:
```sql
-- Włącz rozszerzenia
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabela Uprawnienia
CREATE TABLE IF NOT EXISTS "Uprawnienia" (
    "ID_Uprawnienia" SERIAL PRIMARY KEY,
    "Nazwa" VARCHAR(100) NOT NULL
);

-- Tabela Region
CREATE TABLE IF NOT EXISTS "Region" (
    "ID_Regionu" SERIAL PRIMARY KEY,
    "Nazwa" VARCHAR(100) NOT NULL
);

-- Tabela Kategoria
CREATE TABLE IF NOT EXISTS "Kategoria" (
    "ID_Kategoria" SERIAL PRIMARY KEY,
    "Nazwa" VARCHAR(100) NOT NULL
);

-- Tabela Użytkownik
CREATE TABLE IF NOT EXISTS "Użytkownik" (
    "ID_Użytkownik" SERIAL PRIMARY KEY,
    "Imie" VARCHAR(100),
    "Nazwisko" VARCHAR(100),
    "Mail" VARCHAR(100) UNIQUE NOT NULL,
    "Hasło" VARCHAR(255) NOT NULL,
    "ID_Uprawnienia" INTEGER NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY ("ID_Uprawnienia") REFERENCES "Uprawnienia"("ID_Uprawnienia")
);

-- Tabela Miejsce
CREATE TABLE IF NOT EXISTS "Miejsce" (
    "ID_Miejsce" SERIAL PRIMARY KEY,
    "ID_Region" INTEGER NOT NULL,
    "ID_Kategoria" INTEGER NOT NULL,
    "ID_Użytkownik" INTEGER NOT NULL,
    "Nazwa" VARCHAR(255),
    "Ulica" VARCHAR(255),
    "Opis" TEXT,
    "Data_dodania" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "Miejscowość" VARCHAR(255),
    "Kod_pocztowy" VARCHAR(6),
    "Link" VARCHAR(500),
    FOREIGN KEY ("ID_Region") REFERENCES "Region"("ID_Regionu"),
    FOREIGN KEY ("ID_Kategoria") REFERENCES "Kategoria"("ID_Kategoria"),
    FOREIGN KEY ("ID_Użytkownik") REFERENCES "Użytkownik"("ID_Użytkownik"),
    CONSTRAINT "Miejsce_kod_pocztowy_check" CHECK (("Kod_pocztowy" IS NULL) OR ("Kod_pocztowy" ~ '^[0-9]{2}-[0-9]{3}$'))
);

-- Reszta tabel (Recenzja, Zdjęcia, etc.)
CREATE TABLE IF NOT EXISTS "Recenzja" (
    "ID_Recenzja" SERIAL PRIMARY KEY,
    "ID_Użytkownik" INTEGER NOT NULL,
    "Ocena" INTEGER CHECK ("Ocena" >= 1 AND "Ocena" <= 5),
    "Komentarz" TEXT,
    "Data_dodania" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "ID_Miejsce" INTEGER NOT NULL,
    FOREIGN KEY ("ID_Użytkownik") REFERENCES "Użytkownik"("ID_Użytkownik"),
    FOREIGN KEY ("ID_Miejsce") REFERENCES "Miejsce"("ID_Miejsce") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "Zdjęcia" (
    "ID_Zdjęcie" SERIAL PRIMARY KEY,
    "ID_Miejsce" INTEGER,
    "ID_Recenzja" INTEGER,
    "URL" VARCHAR(500) NOT NULL,
    "created_at" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY ("ID_Miejsce") REFERENCES "Miejsce"("ID_Miejsce") ON DELETE CASCADE,
    FOREIGN KEY ("ID_Recenzja") REFERENCES "Recenzja"("ID_Recenzja") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "historia_wyszukiwan" (
    "ID_Historia" SERIAL PRIMARY KEY,
    "ID_Użytkownik" INTEGER NOT NULL,
    "Data_wyszukiwania" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "ID_Miejsce" INTEGER NOT NULL,
    FOREIGN KEY ("ID_Użytkownik") REFERENCES "Użytkownik"("ID_Użytkownik"),
    FOREIGN KEY ("ID_Miejsce") REFERENCES "Miejsce"("ID_Miejsce") ON DELETE CASCADE
);

-- Wstaw podstawowe dane
INSERT INTO "Uprawnienia" ("Nazwa") VALUES 
('Administrator'),
('Użytkownik')
ON CONFLICT DO NOTHING;

INSERT INTO "Region" ("Nazwa") VALUES 
('Dolnośląskie'),('Kujawsko-pomorskie'),('Lubelskie'),('Lubuskie'),
('Łódzkie'),('Małopolskie'),('Mazowieckie'),('Opolskie'),
('Podkarpackie'),('Podlaskie'),('Pomorskie'),('Śląskie'),
('Świętokrzyskie'),('Warmińsko-mazurskie'),('Wielkopolskie'),
('Zachodniopomorskie'),('Poza Polską')
ON CONFLICT DO NOTHING;

INSERT INTO "Kategoria" ("Nazwa") VALUES 
('Zabytki'),('Przyroda'),('Muzea'),('Restauracje'),('Hotele'),
('Rozrywka'),('Sport'),('Kultura'),('Zakupy'),('Inne')
ON CONFLICT DO NOTHING;
```

## Krok 4: Sprawdź czy wszystko działa
1. Idź do **Table Editor**
2. Powinieneś zobaczyć wszystkie tabele
3. Sprawdź czy dane zostały dodane w tabelach Uprawnienia, Region, Kategoria

## Możliwe problemy:
- **Błąd hasła**: Sprawdź czy hasło `rabarbar123!@` działa w Database settings
- **Błąd username**: Spróbuj `postgres` zamiast `postgres.hjlkbozrkpgsjgfgudhw`
- **Błąd połączenia**: Sprawdź czy SSL jest włączony

✅ Po wykonaniu tych kroków będziesz mógł uruchomić aplikację na bolt.new!
