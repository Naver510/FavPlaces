from django import forms
from django.core.exceptions import ValidationError
from .models import Uzytkownik, Miejsce

class RejestracjaForm(forms.ModelForm):
    Haslo2 = forms.CharField(
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        label='Potwierdź hasło'
    )

    class Meta:
        model = Uzytkownik
        fields = ['Imie', 'Nazwisko', 'Mail', 'Hasło']
        widgets = {
            'Imie': forms.TextInput(attrs={'class': 'form-control'}),
            'Nazwisko': forms.TextInput(attrs={'class': 'form-control'}),
            'Mail': forms.EmailInput(attrs={'class': 'form-control'}),
            'Hasło': forms.PasswordInput(attrs={'class': 'form-control'}),
        }

    def clean(self):
        cleaned_data = super().clean()
        haslo1 = cleaned_data.get("Hasło")
        haslo2 = cleaned_data.get("Haslo2")

        if haslo1 and haslo2 and haslo1 != haslo2:
            raise ValidationError("Hasła nie są takie same.")

        return cleaned_data



class LogowanieForm(forms.Form):
    email = forms.EmailField(label='Email')
    haslo = forms.CharField(widget=forms.PasswordInput(), label='Hasło')


class MiejsceForm(forms.ModelForm):
    class Meta:
        model = Miejsce
        fields = ['Nazwa', 'Ulica', 'Miejscowość', 'Kod_pocztowy', 'ID_Kategoria', 'ID_Region', 'Opis', 'Link']
        widgets = {
            'Nazwa': forms.TextInput(attrs={'placeholder': 'Podaj nazwę'}),
            'Ulica': forms.TextInput(attrs={'placeholder': 'Podaj ulicę'}),
            'Miejscowość': forms.TextInput(attrs={'placeholder': 'Podaj miejscowość'}),
            'Kod_pocztowy': forms.TextInput(attrs={'placeholder': 'Podaj kod pocztowy'}),
            'ID_Kategoria': forms.Select(attrs={'placeholder': 'Wybierz kategorię'}),
            'ID_Region': forms.Select(attrs={'placeholder': 'Wybierz region'}),
            'Opis': forms.Textarea(attrs={'placeholder': 'Dodaj opis...', 'rows': 4}),
            'Link': forms.URLInput(attrs={'placeholder': 'Link do strony atrakcji (opcjonalne)', 'required': False}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['ID_Kategoria'].empty_label = "Wybierz kategorię"
        self.fields['ID_Region'].empty_label = "Wybierz region"
        # Make Link field optional
        self.fields['Link'].required = False