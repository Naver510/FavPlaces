from django.test import TestCase
from .models import Uzytkownik, Miejsce, Recenzja, HistoriaWyszukiwan

class UzytkownikModelTest(TestCase):
    def setUp(self):
        self.uzytkownik = Uzytkownik.objects.create(
            Imie='Jan',
            Nazwisko='Kowalski',
            Mail='jan.kowalski@example.com',
            Hasło='password123'
        )

    def test_str(self):
        self.assertEqual(str(self.uzytkownik), 'Jan Kowalski')

class MiejsceModelTest(TestCase):
    def setUp(self):
        self.miejsce = Miejsce.objects.create(
            Nazwa='Park',
            Ulica='Główna',
            Opis='Piękny park w centrum miasta',
            Miejscowość='Warszawa',
            Kod_pocztowy='00-001',
            Link='http://example.com'
        )

    def test_str(self):
        self.assertEqual(str(self.miejsce), 'Park')

class RecenzjaModelTest(TestCase):
    def setUp(self):
        self.uzytkownik = Uzytkownik.objects.create(
            Imie='Anna',
            Nazwisko='Nowak',
            Mail='anna.nowak@example.com',
            Hasło='password123'
        )
        self.miejsce = Miejsce.objects.create(
            Nazwa='Zamek',
            Ulica='Zamkowa',
            Opis='Zamek w pięknym stanie',
            Miejscowość='Kraków',
            Kod_pocztowy='30-001',
            Link='http://example.com'
        )
        self.recenzja = Recenzja.objects.create(
            ID_Użytkownik=self.uzytkownik,
            Ocena=5,
            Komentarz='Wspaniałe miejsce!',
            ID_Miejsce=self.miejsce
        )

    def test_str(self):
        self.assertEqual(str(self.recenzja), 'Wspaniałe miejsce!')

class HistoriaWyszukiwanModelTest(TestCase):
    def setUp(self):
        self.uzytkownik = Uzytkownik.objects.create(
            Imie='Kasia',
            Nazwisko='Wiśniewska',
            Mail='kasia.wisniewska@example.com',
            Hasło='password123'
        )
        self.miejsce = Miejsce.objects.create(
            Nazwa='Plaża',
            Ulica='Plażowa',
            Opis='Cudowna plaża nad morzem',
            Miejscowość='Gdańsk',
            Kod_pocztowy='80-001',
            Link='http://example.com'
        )
        self.historia = HistoriaWyszukiwan.objects.create(
            ID_Użytkownik=self.uzytkownik,
            ID_Miejsce=self.miejsce
        )

    def test_str(self):
        self.assertEqual(str(self.historia), 'Cudowna plaża nad morzem')