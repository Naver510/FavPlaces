from django import forms
from .models import Uzytkownik, Miejsce

class RejestracjaForm(forms.ModelForm):
    class Meta:
        model = Uzytkownik
        fields = ['Imie', 'Nazwisko', 'Mail', 'Hasło']
        widgets = {
            'Hasło': forms.PasswordInput(),
        }

class LogowanieForm(forms.Form):
    email = forms.EmailField(label='Email')
    haslo = forms.CharField(widget=forms.PasswordInput(), label='Hasło')


class MiejsceForm(forms.ModelForm):
    class Meta:
        model = Miejsce
        fields = ['Nazwa', 'Adres', 'ID_Kategoria', 'ID_Region', 'Opis']
        widgets = {
            'Nazwa': forms.TextInput(attrs={'placeholder': 'Podaj nazwę'}),
            'Adres': forms.TextInput(attrs={'placeholder': 'Podaj adres'}),
            'ID_Kategoria': forms.Select(),
            'ID_Region': forms.Select(),
            'Opis': forms.Textarea(attrs={'placeholder': 'Dodaj opis...', 'rows': 4}),
        }