from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from .forms import RejestracjaForm, LogowanieForm, MiejsceForm
from .models import Uzytkownik, Uprawnienia, Miejsce, Kategoria, Region, Zdjęcia, HistoriaWyszukiwan, Recenzja, Ranking
from django.utils import timezone
from django.core.files.base import ContentFile
from django.db.models import Q
from datetime import datetime
from django.core.paginator import Paginator
import os
from django.conf import settings
from django.db.models import Avg

def rejestracja(request):
    if request.method == 'POST':
        form = RejestracjaForm(request.POST)
        if form.is_valid():
            uzytkownik = form.save(commit=False)
            uzytkownik.ID_Uprawnienia = Uprawnienia.objects.get(ID_Uprawnienia=2)
            #uzytkownik.ID_Użytkownik = Uzytkownik.objects.count() + 1
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
    query = request.GET.get('q', '')
    sort = request.GET.get('sort', '')
    selected_regions = [region for region in request.GET.getlist('region') if region]
    selected_categories = [category for category in request.GET.getlist('category') if category]
    selected_ratings = [rating for rating in request.GET.getlist('rating') if rating]

    miejsca = Miejsce.objects.all()

    if query:
        miejsca = miejsca.filter(Nazwa__icontains=query)

    if selected_regions:
        miejsca = miejsca.filter(ID_Region__in=selected_regions)

    if selected_categories:
        miejsca = miejsca.filter(ID_Kategoria__in=selected_categories)  # Allow multiple categories

    if selected_ratings:
        miejsca = miejsca.filter(recenzja__Ocena__in=selected_ratings)

    if sort == 'asc':
        miejsca = miejsca.order_by('Nazwa')
    elif sort == 'desc':
        miejsca = miejsca.order_by('-Nazwa')

    # PAGINACJA — 6 elementów na stronę
    paginator = Paginator(miejsca, 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    uzytkownik = None
    uzytkownik_id = request.session.get('uzytkownik_id')
    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
        except Uzytkownik.DoesNotExist:
            del request.session['uzytkownik_id']

    regions = Region.objects.all()
    categories = Kategoria.objects.all()

    context = {
        'page_obj': page_obj,
        'uzytkownik': uzytkownik,
        'query': query,
        'regions': regions,
        'categories': categories,
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
                    Q(ID_Miejsca__Miejscowość__icontains(query))  # Fixed unclosed parenthesis
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

    rankingi = Ranking.objects.prefetch_related('Miejsca').all()

    return render(request, 'app/ranking.html', {
        'uzytkownik': uzytkownik,
        'rankingi': rankingi,
    })



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
            try:
                # Zapisanie miejsca
                miejsce = form.save(commit=False)
                miejsce.ID_Użytkownik = uzytkownik
                miejsce.Data_dodania = timezone.now()
                
                # Dodaj obsługę linku do Google Maps
                maps_link = request.POST.get('maps_link')
                if maps_link:
                    miejsce.Link = maps_link
                    
                miejsce.save()
                print(f"Miejsce zapisane: ID={miejsce.ID_Miejsce}")
                
                # Obsługa zdjęcia - albo z pliku albo z linku URL
                url_zdjecia = request.POST.get('URL_zdjecia')
                upload_zdjecia = request.FILES.get('upload_zdjecia')
                
                if upload_zdjecia:
                    # Zapisanie przesłanego pliku
                    # Utwórz folder 'zdjecia' jeśli nie istnieje
                    upload_path = os.path.join(settings.MEDIA_ROOT, 'zdjecia')
                    os.makedirs(upload_path, exist_ok=True)
                    
                    # Generuj unikalną nazwę pliku
                    filename = f"{miejsce.ID_Miejsce}_{upload_zdjecia.name}"
                    filepath = os.path.join(upload_path, filename)
                    
                    # Zapisz plik
                    with open(filepath, 'wb+') as destination:
                        for chunk in upload_zdjecia.chunks():
                            destination.write(chunk)
                    
                    # Utwórz URL dla zapisanego zdjęcia
                    url_zdjecia = os.path.join(settings.MEDIA_URL, 'zdjecia', filename)
                    
                    # Zapisanie informacji o zdjęciu
                    zdjecie = Zdjęcia()
                    zdjecie.ID_Miejsce = miejsce
                    zdjecie.URL = url_zdjecia
                    zdjecie.ID_Recenzja = None
                    zdjecie.save()
                    
                elif url_zdjecia:
                    # Zapisanie zdjęcia z URL
                    zdjecie = Zdjęcia()
                    zdjecie.ID_Miejsce = miejsce
                    zdjecie.URL = url_zdjecia
                    zdjecie.ID_Recenzja = None
                    zdjecie.save()
                
                # Sprawdź czy ocena została przekazana i jest liczbą
                ocena = request.POST.get('ocena')
                
                if ocena and ocena.isdigit():
                    # Konwersja oceny na liczbę całkowitą (ilość klikniętych gwiazdek)
                    ocena_int = int(ocena)
                    
                    # Zapisanie recenzji z oceną jako liczbą gwiazdek
                    recenzja = Recenzja()
                    recenzja.ID_Użytkownik = uzytkownik
                    recenzja.Ocena = ocena_int
                    recenzja.Komentarz = None 
                    recenzja.Data_dodania = timezone.now()
                    recenzja.ID_Miejsce = miejsce
                    recenzja.save()

                return redirect('atrakcje')
            except Exception as e:
                print(f"Błąd podczas zapisywania miejsca: {e}")
                # Możesz dodać błąd do formularza
                form.add_error(None, f"Błąd podczas zapisywania: {e}")
        else:
            print("Formularz nieprawidłowy:", form.errors)
    else:
        form = MiejsceForm()

    return render(request, 'app/dodaj_miejsce.html', {
        'form': form,
        'uzytkownik': uzytkownik
    })

def miejsce_szczegoly(request, id):
    miejsce = get_object_or_404(Miejsce, pk=id)
    page = request.GET.get('page', '1')

    uzytkownik = None
    uzytkownik_id = request.session.get('uzytkownik_id')
    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
            HistoriaWyszukiwan.objects.create(
                ID_Użytkownik=uzytkownik,
                ID_Miejsca=miejsce
            )
        except Uzytkownik.DoesNotExist:
            request.session.flush()

    recenzje = Recenzja.objects.filter(ID_Miejsce=miejsce).select_related('ID_Użytkownik')
    srednia_ocena = recenzje.aggregate(Avg('Ocena'))['Ocena__avg']
    zdjecia_miejsca = Zdjęcia.objects.filter(ID_Miejsce=miejsce, URL__isnull=False).exclude(URL='')

    return render(request, 'app/miejsce_szczegoly.html', {
        'miejsce': miejsce,
        'uzytkownik': uzytkownik,
        'recenzje': recenzje,
        'srednia_ocena': srednia_ocena or 0,
        'zdjecia_miejsca': zdjecia_miejsca,
        'page': page
    })

def miejsca_lista(request):
    miejsca = Miejsce.objects.prefetch_related('zdjęcia').all()
    return render(request, 'twoj_szablon.html', {'miejsca': miejsca})



def dodaj_recenzje(request, miejsce_id):
    if not request.session.get('uzytkownik_id'):
        return redirect('logowanie')

    miejsce = get_object_or_404(Miejsce, pk=miejsce_id)
    uzytkownik = get_object_or_404(Uzytkownik, pk=request.session['uzytkownik_id'])

    if request.method == 'POST':
        ocena = request.POST.get('ocena')
        komentarz = request.POST.get('Komentarz')

        if ocena and ocena.isdigit():
            recenzja = Recenzja()
            recenzja.ID_Użytkownik = uzytkownik
            recenzja.ID_Miejsce = miejsce
            recenzja.Ocena = int(ocena)
            recenzja.Komentarz = komentarz
            recenzja.Data_dodania = timezone.now()
            recenzja.save()
            return redirect('miejsce_szczegoly', id=miejsce_id)

    return render(request, 'app/dodaj_recenzje.html', {'miejsce': miejsce})
