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
        fields = ['Nazwa', 'Adres', 'Opis']
