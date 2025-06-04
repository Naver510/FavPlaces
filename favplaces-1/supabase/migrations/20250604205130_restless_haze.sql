-- filepath: c:\Users\Micha\Documents\GitHub\FavPlaces\supabase\migrations\20250604205130_restless_haze.sql
-- Insert Region data
INSERT INTO "Region" ("ID_Regionu", "Nazwa") VALUES
(1, 'mazowieckie'),
(2, 'małopolskie'),
(3, 'dolnośląskie'),
(4, 'lubuskie'),
(5, 'łódzkie'),
(6, 'podkarpackie'),
(7, 'podlaskie'),
(8, 'zachodniopomorskie'),
(9, 'wielkopolskie'),
(10, 'opolskie'),
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