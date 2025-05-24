from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from .forms import RejestracjaForm, LogowanieForm, MiejsceForm
from .models import Uzytkownik, Uprawnienia, Miejsce, Kategoria, Region, Zdjęcia, HistoriaWyszukiwan
from django.utils import timezone
from django.core.files.base import ContentFile
from django.db.models import Q
from datetime import datetime

def rejestracja(request):
    if request.method == 'POST':
        form = RejestracjaForm(request.POST)
        if form.is_valid():
            uzytkownik = form.save(commit=False)
            uzytkownik.ID_Uprawnienia = Uprawnienia.objects.get(ID_Uprawnienia=2)
            uzytkownik.ID_Użytkownik = Uzytkownik.objects.count() + 1
            uzytkownik.save()
            return redirect('strona_glowna')  
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
    uzytkownik = None
    if 'uzytkownik_id' in request.session:
        uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=request.session['uzytkownik_id'])

    return render(request, 'app/strona_glowna.html', {'uzytkownik': uzytkownik})




def historia(request):
    uzytkownik = None
    historia_lista = []
    uzytkownik_id = request.session.get('uzytkownik_id')

    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)

            query = request.GET.get('q', '')
            data_wyszukiwania = request.GET.get('data_wyszukiwania', '')

            historia_qs = HistoriaWyszukiwan.objects.filter(ID_Użytkownik=uzytkownik).order_by('-Data_wyszukiwania')

            if query:
                historia_qs = historia_qs.filter(
                    Q(ID_Miejsca__Nazwa__icontains=query) |
                    Q(ID_Miejsca__Miejscowość__icontains=query)
                )

            if data_wyszukiwania:
                try:
                    # konwertujemy na obiekt daty
                    data_obj = datetime.strptime(data_wyszukiwania, '%Y-%m-%d').date()
                    historia_qs = historia_qs.filter(Data_wyszukiwania__date=data_obj)
                except ValueError:
                    pass  # zignoruj złą datę

            historia_lista = historia_qs

        except Uzytkownik.DoesNotExist:
            request.session.flush()

    return render(request, 'app/historia.html', {
        'uzytkownik': uzytkownik,
        'historia_lista': historia_lista,
        'query': request.GET.get('q', ''),
        'data_wyszukiwania': request.GET.get('data_wyszukiwania', ''),
    })


def ranking(request):
    uzytkownik = None
    uzytkownik_id = request.session.get('uzytkownik_id')
    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
        except Uzytkownik.DoesNotExist:
            request.session.flush()

    return render(request, 'app/ranking.html', {'uzytkownik': uzytkownik})



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

    uzytkownik = None
    uzytkownik_id = request.session.get('uzytkownik_id')
    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
        except Uzytkownik.DoesNotExist:
            request.session.flush()
            return redirect('logowanie')
            
    if request.method == 'POST':
        form = MiejsceForm(request.POST)

        if form.is_valid():
            # Zapisanie miejsca
            miejsce = form.save(commit=False)
            miejsce.ID_Użytkownik = uzytkownik
            miejsce.Data_dodania = timezone.now()
            miejsce.save()
            
            # Obsługa URL zdjęcia
            url_zdjecia = request.POST.get('URL_zdjecia')
            ocena = request.POST.get('ocena', 0)
            
            if url_zdjecia:
                # Zapisanie zdjęcia
                zdjecie = Zdjęcia()
                zdjecie.ID_Miejsce = miejsce
                zdjecie.URL = url_zdjecia
                zdjecie.ID_Recenzja = None
                zdjecie.save()
            
            return redirect('atrakcje')
    else:
        form = MiejsceForm()

    return render(request, 'app/dodaj_miejsce.html', {
        'form': form,
        'uzytkownik': uzytkownik
    })

def miejsce_szczegoly(request, id):
    miejsce = get_object_or_404(Miejsce, pk=id)

    uzytkownik = None
    uzytkownik_id = request.session.get('uzytkownik_id')
    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
            HistoriaWyszukiwan.objects.create(
                ID_Użytkownik=uzytkownik,
                ID_Miejsca=miejsce)
        except Uzytkownik.DoesNotExist:
            request.session.flush()

    return render(request, 'app/miejsce_szczegoly.html', {
        'miejsce': miejsce,
        'uzytkownik': uzytkownik
    })
    return render(request, 'app/miejsce_szczegoly.html', {'miejsce': miejsce})

def miejsca_lista(request):
    miejsca = Miejsce.objects.prefetch_related('zdjęcia').all()
    return render(request, 'twoj_szablon.html', {'miejsca': miejsca})
