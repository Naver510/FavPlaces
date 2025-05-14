from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from .forms import RejestracjaForm, LogowanieForm, MiejsceForm
from .models import Uzytkownik, Uprawnienia, Miejsce, Kategoria, Region, Zdjęcia
from django.utils import timezone
from django.core.files.base import ContentFile

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
                return redirect('atrakcje')  # nazwij tak swój widok docelowy
            except Uzytkownik.DoesNotExist:
                blad = "Nieprawidłowy email lub hasło."
    else:
        form = LogowanieForm()

    return render(request, 'app/logowanie.html', {'form': form, 'blad': blad})



def atrakcje(request):
    query = request.GET.get('q', '')  # pobranie zapytania z paska wyszukiwania
    sort = request.GET.get('sort', '')  # pobranie parametru sortowania
    miejsca = Miejsce.objects.all()

    if query:
        miejsca = miejsca.filter(Nazwa__icontains=query)

    if sort == 'asc':
        miejsca = miejsca.order_by('Nazwa')  # sortowanie rosnąco
    elif sort == 'desc':
        miejsca = miejsca.order_by('-Nazwa')  # sortowanie malejąco

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

    return render(request, 'app/atrakcje.html', context)

def strona_glowna(request):
    return render(request, 'app/strona_glowna.html')


def historia(request):
    return render(request, 'app/historia.html')

def kontakt(request):
    return render(request, 'app/kontakt.html')


@csrf_exempt
def wyloguj(request):
    try:
        del request.session['uzytkownik_id']
    except KeyError:
        pass
    return redirect('atrakcje')



def dodaj_miejsce(request):
    if not request.session.get('uzytkownik_id'):
        return redirect('logowanie')

    if request.method == 'POST':
        form = MiejsceForm(request.POST)

        if form.is_valid():
            miejsce = form.save(commit=False)
            uzytkownik_id = request.session.get('uzytkownik_id')
            miejsce.ID_Użytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
            miejsce.ID_Miejsce = Miejsce.objects.count() + 1
            miejsce.Data_dodania = timezone.now()

            miejsce.save()
            return redirect('atrakcje')
    else:
        form = MiejsceForm()

    return render(request, 'app/dodaj_miejsce.html', {
        'form': form,
    })

def miejsce_szczegoly(request, id):
    miejsce = get_object_or_404(Miejsce, pk=id)
    return render(request, 'app/miejsce_szczegoly.html', {'miejsce': miejsce})

def miejsca_lista(request):
    miejsca = Miejsce.objects.prefetch_related('zdjęcia').all()
    return render(request, 'twoj_szablon.html', {'miejsca': miejsca})
