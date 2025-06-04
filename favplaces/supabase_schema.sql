-- Supabase schema for FavPlaces application

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create tables with proper constraints and indexes

CREATE TABLE IF NOT EXISTS "Uprawnienia" (
    "ID_Uprawnienia" SERIAL PRIMARY KEY,
    "Nazwa" VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS "Region" (
    "ID_Regionu" SERIAL PRIMARY KEY,
    "Nazwa" VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS "Kategoria" (
    "ID_Kategoria" SERIAL PRIMARY KEY,
    "Nazwa" VARCHAR(100) NOT NULL
);

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
    FOREIGN KEY ("ID_Recenzja") REFERENCES "Recenzja"("ID_Recenzja") ON DELETE CASCADE,
    CHECK (("ID_Miejsce" IS NOT NULL) OR ("ID_Recenzja" IS NOT NULL))
);

CREATE TABLE IF NOT EXISTS "Ranking" (
    "ID_Ranking" SERIAL PRIMARY KEY,
    "Nazwa" VARCHAR(100) NOT NULL,
    "Opis" TEXT,
    "Data_utworzenia" TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS "Ranking_Miejsca" (
    "id" SERIAL PRIMARY KEY,
    "ranking_id" INTEGER NOT NULL,
    "miejsce_id" INTEGER NOT NULL,
    FOREIGN KEY ("ranking_id") REFERENCES "Ranking"("ID_Ranking") ON DELETE CASCADE,
    FOREIGN KEY ("miejsce_id") REFERENCES "Miejsce"("ID_Miejsce") ON DELETE CASCADE,
    UNIQUE("ranking_id", "miejsce_id")
);

CREATE TABLE IF NOT EXISTS "historia_wyszukiwan" (
    "ID_Historia" SERIAL PRIMARY KEY,
    "ID_Użytkownik" INTEGER NOT NULL,
    "Data_wyszukiwania" TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    "ID_Miejsce" INTEGER NOT NULL,
    FOREIGN KEY ("ID_Użytkownik") REFERENCES "Użytkownik"("ID_Użytkownik"),
    FOREIGN KEY ("ID_Miejsce") REFERENCES "Miejsce"("ID_Miejsce") ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_miejsce_region ON "Miejsce"("ID_Region");
CREATE INDEX IF NOT EXISTS idx_miejsce_kategoria ON "Miejsce"("ID_Kategoria");
CREATE INDEX IF NOT EXISTS idx_miejsce_uzytkownik ON "Miejsce"("ID_Użytkownik");
CREATE INDEX IF NOT EXISTS idx_recenzja_miejsce ON "Recenzja"("ID_Miejsce");
CREATE INDEX IF NOT EXISTS idx_recenzja_uzytkownik ON "Recenzja"("ID_Użytkownik");
CREATE INDEX IF NOT EXISTS idx_historia_uzytkownik ON "historia_wyszukiwan"("ID_Użytkownik");
CREATE INDEX IF NOT EXISTS idx_historia_data ON "historia_wyszukiwan"("Data_wyszukiwania");

-- Insert default data
INSERT INTO "Uprawnienia" ("Nazwa") VALUES 
('Administrator'),
('Użytkownik')
ON CONFLICT DO NOTHING;

-- Insert sample regions
INSERT INTO "Region" ("Nazwa") VALUES 
('Dolnośląskie'),
('Kujawsko-pomorskie'),
('Lubelskie'),
('Lubuskie'),
('Łódzkie'),
('Małopolskie'),
('Mazowieckie'),
('Opolskie'),
('Podkarpackie'),
('Podlaskie'),
('Pomorskie'),
('Śląskie'),
('Świętokrzyskie'),
('Warmińsko-mazurskie'),
('Wielkopolskie'),
('Zachodniopomorskie'),
('Poza Polską')
ON CONFLICT DO NOTHING;

-- Insert sample categories
INSERT INTO "Kategoria" ("Nazwa") VALUES 
('Zabytki'),
('Przyroda'),
('Muzea'),
('Restauracje'),
('Hotele'),
('Rozrywka'),
('Sport'),
('Kultura'),
('Zakupy'),
('Inne')
ON CONFLICT DO NOTHING;
