from django import forms
from .models import Uzytkownik, Miejsce, Recenzja

class UzytkownikForm(forms.ModelForm):
    class Meta:
        model = Uzytkownik
        fields = ['Imie', 'Nazwisko', 'Mail', 'Hasło']

class MiejsceForm(forms.ModelForm):
    class Meta:
        model = Miejsce
        fields = ['Nazwa', 'Ulica', 'Opis', 'Miejscowość', 'Kod_pocztowy', 'Link', 'ID_Region', 'ID_Kategoria']

class RecenzjaForm(forms.ModelForm):
    class Meta:
        model = Recenzja
        fields = ['Ocena', 'Komentarz', 'ID_Miejsce']