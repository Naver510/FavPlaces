from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from .forms import RejestracjaForm, LogowanieForm, MiejsceForm
from .models import Uzytkownik, Uprawnienia, Miejsce

def rejestracja(request):
    if request.method == 'POST':
        form = RejestracjaForm(request.POST)
        if form.is_valid():
            uzytkownik = form.save(commit=False)
            uzytkownik.ID_Uprawnienia = Uprawnienia.objects.get(ID_Uprawnienia=2)
            uzytkownik.ID_Użytkownik = Uzytkownik.objects.count() + 1
            uzytkownik.save()
            return redirect('/')  
    else:
        form = RejestracjaForm()
    
    return render(request, 'app/rejestracja.html', {'form': form})



def logowanie(request):
    blad = None
    if request.method == 'POST':
        form = LogowanieForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            haslo = form.cleaned_data['haslo']
            try:
                uzytkownik = Uzytkownik.objects.get(Mail=email, Hasło=haslo)
                request.session['uzytkownik_id'] = uzytkownik.ID_Użytkownik
                return redirect('strona_glowna')  # nazwij tak swój widok docelowy
            except Uzytkownik.DoesNotExist:
                blad = "Nieprawidłowy email lub hasło."
    else:
        form = LogowanieForm()

    return render(request, 'app/logowanie.html', {'form': form, 'blad': blad})



def strona_glowna(request):
    query = request.GET.get('q', '')  # pobranie zapytania z paska wyszukiwania
    miejsca = Miejsce.objects.all()

    if query:
        miejsca = miejsca.filter(Nazwa__icontains=query)

    uzytkownik = None
    uzytkownik_id = request.session.get('uzytkownik_id')
    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
        except Uzytkownik.DoesNotExist:
            del request.session['uzytkownik_id']

    context = {
        'miejsca': miejsca,
        'uzytkownik': uzytkownik,
        'query': query,
    }

    return render(request, 'app/strona_glowna.html', context)



@csrf_exempt
def wyloguj(request):
    try:
        del request.session['uzytkownik_id']
    except KeyError:
        pass
    return redirect('strona_glowna')


def dodaj_miejsce(request):
    if not request.session.get('uzytkownik_id'):
        return redirect('logowanie')

    if request.method == 'POST':
        form = MiejsceForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('strona_glowna')
    else:
        form = MiejsceForm()

    return render(request, 'uzytkownicy/dodaj_miejsce.html', {'form': form})


def miejsce_szczegoly(request, id):
    miejsce = get_object_or_404(Miejsce, pk=id)
    return render(request, 'uzytkownicy/miejsce_szczegoly.html', {'miejsce': miejsce})
