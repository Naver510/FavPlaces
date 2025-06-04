/*
  # Insert Initial Data

  1. Insert base data for:
    - Permissions (Uprawnienia)
    - Regions (Region)
    - Categories (Kategoria)

  2. Security
    - Data is inserted with RLS policies in place
*/

-- Insert Uprawnienia data
INSERT INTO "Uprawnienia" ("ID_Uprawnienia", "Nazwa") VALUES
(1, 'Administrator'),
(2, 'Użytkownik');

-- Insert Region data
INSERT INTO "Region" ("ID_Regionu", "Nazwa") VALUES
(1, 'dolnośląskie'),
(2, 'kujawsko-pomorskie'),
(3, 'lubelskie'),
(4, 'lubuskie'),
(5, 'łódzkie'),
(6, 'małopolskie'),
(7, 'mazowieckie'),
(8, 'opolskie'),
(9, 'podkarpackie'),
(10, 'podlaskie'),
(11, 'pomorskie'),
(12, 'śląskie'),
(13, 'świętokrzyskie'),
(14, 'warmińsko-mazurskie'),
(15, 'wielkopolskie'),
(16, 'zachodniopomorskie'),
(17, 'Spoza Polski');

-- Insert Kategoria data
INSERT INTO "Kategoria" ("ID_Kategoria", "Nazwa") VALUES
(1, 'Punkt gastronomiczny'),
(2, 'Zabytek'),
(3, 'Krajobraz'),
(4, 'Roślinność'),
(5, 'Akwen wodny'),
(6, 'Park'),
(7, 'Kościół'),
(8, 'Inne');