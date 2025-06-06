from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from .forms import RejestracjaForm, LogowanieForm, MiejsceForm
from .models import Uzytkownik, Uprawnienia, Miejsce, Kategoria, Region, Zdjęcia, HistoriaWyszukiwan, Recenzja, Ranking
from django.utils import timezone
from django.core.files.base import ContentFile
from django.db.models import Q, Avg, Case, When, Value, IntegerField
from datetime import datetime
from django.core.paginator import Paginator
import os
from django.conf import settings
from itertools import islice
from collections import defaultdict
from django.contrib import messages
from django.utils.http import urlencode

def rejestracja(request):
    if request.method == 'POST':
        form = RejestracjaForm(request.POST)
        if form.is_valid():
            uzytkownik = form.save(commit=False)
            uzytkownik.ID_Uprawnienia = Uprawnienia.objects.get(ID_Uprawnienia=2)
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
                return redirect('strona_glowna')
            except Uzytkownik.DoesNotExist:
                blad = "Nieprawidłowy email lub hasło."
    else:
        form = LogowanieForm()
    return render(request, 'app/logowanie.html', {'form': form, 'blad': blad})

def atrakcje(request):
    query = request.GET.get('q', '')
    sort = request.GET.get('sort', '')

    selected_regions = request.GET.getlist('region')
    selected_categories = request.GET.getlist('category')
    selected_ratings = request.GET.getlist('rating')

    selected_regions = [r for r in selected_regions if r.strip()]
    selected_categories = [c for c in selected_categories if c.strip()]
    selected_ratings = [r for r in selected_ratings if r.strip().isdigit()]

    miejsca = Miejsce.objects.all()
    if query:
        miejsca = miejsca.filter(Nazwa__icontains=query)
    if selected_regions:
        miejsca = miejsca.filter(ID_Region__in=selected_regions)
    if selected_categories:
        miejsca = miejsca.filter(ID_Kategoria__in=selected_categories)
    if selected_ratings:
        rating_filters = Q()
        for rating in selected_ratings:
            lower_bound = int(rating) - 0.01
            upper_bound = int(rating) + 0.99
            rating_filters |= Q(recenzja__Ocena__gte=lower_bound, recenzja__Ocena__lte=upper_bound)
        miejsca = miejsca.annotate(avg_rating=Avg('recenzja__Ocena')).filter(rating_filters)
    if sort == 'asc':
        miejsca = miejsca.order_by('Nazwa')
    elif sort == 'desc':
        miejsca = miejsca.order_by('-Nazwa')
    elif sort == 'rating_asc':
        miejsca = miejsca.annotate(avg_rating=Avg('recenzja__Ocena')).order_by('avg_rating')
    elif sort == 'rating_desc':
        miejsca = miejsca.annotate(avg_rating=Avg('recenzja__Ocena')).order_by('-avg_rating')

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

    # Budujemy parametry GET oprócz 'page' - do linków paginacji
    get_params = request.GET.copy()
    if 'page' in get_params:
        del get_params['page']
    params = get_params.urlencode()

    context = {
        'page_obj': page_obj,
        'uzytkownik': uzytkownik,
        'query': query,
        'regions': regions,
        'categories': categories,
        'selected_regions': selected_regions,
        'selected_categories': selected_categories,
        'selected_ratings': selected_ratings,
        'params': params,
    }
    return render(request, 'app/atrakcje.html', context)

def strona_glowna(request):
    uzytkownik = None
    if 'uzytkownik_id' in request.session:
        uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=request.session['uzytkownik_id'])
    return render(request, 'app/strona_glowna.html', {'uzytkownik': uzytkownik})

def historia(request):
    biezaca_data = None
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
                    data_obj = datetime.strptime(data_wyszukiwania, '%Y-%m-%d').date()
                    historia_qs = historia_qs.filter(Data_wyszukiwania__date=data_obj)
                except ValueError:
                    pass

            # Grupowanie po dacie (bez godziny)
            historia_dict = defaultdict(list)
            for wpis in historia_qs:
                data_key = wpis.Data_wyszukiwania.date()
                historia_dict[data_key].append(wpis)

            # Posortuj daty malejąco
            historia_by_day = sorted(historia_dict.items(), key=lambda x: x[0], reverse=True)

            # Paginacja po dniach
            paginator = Paginator(historia_by_day, 1)  # 1 dzień = 1 strona
            page_number = request.GET.get('page')
            page_obj = paginator.get_page(page_number)

            # Bieżący dzień
            if page_obj.object_list:
                biezaca_data = page_obj.object_list[0][0]
                historia_lista = page_obj.object_list[0][1]
            else:
                biezaca_data = None
                historia_lista = []

        except Uzytkownik.DoesNotExist:
            request.session.flush()

    return render(request, 'app/historia.html', {
        'uzytkownik': uzytkownik,
        'historia_lista': historia_lista,
        'query': request.GET.get('q', ''),
        'data_wyszukiwania': request.GET.get('data_wyszukiwania', ''),
        'page_obj': page_obj if uzytkownik else None,
        'biezaca_data': biezaca_data,
    })



def ranking(request):
    uzytkownik = None
    uzytkownik_id = request.session.get('uzytkownik_id')
    if uzytkownik_id:
        try:
            uzytkownik = Uzytkownik.objects.get(ID_Użytkownik=uzytkownik_id)
        except Uzytkownik.DoesNotExist:
            request.session.flush()

    rankingi = Ranking.objects.all().prefetch_related('Miejsca__zdjęcia')

    for ranking in rankingi:
        miejsca_z_ocenami = ranking.Miejsca.annotate(
            avg_ocena=Avg('recenzja__Ocena'),
            ocena_null=Case(
                When(recenzja__Ocena__isnull=True, then=Value(1)),
                default=Value(0),
                output_field=IntegerField()
            )
        ).order_by('ocena_null', '-avg_ocena')  # NULLs last

        ranking.sorted_miejsca = miejsca_z_ocenami

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
    success_message = None
    error_message = None
    if request.method == 'POST':
        form = MiejsceForm(request.POST)
        region_id = request.POST.get('ID_Region')
        
        # Check if rating was provided
        ocena = request.POST.get('ocena')
        if not ocena or ocena == '0':
            error_message = "Proszę ocenić miejsce (1-5 gwiazdek)"
            return render(request, 'app/dodaj_miejsce.html', {
                'form': form,
                'uzytkownik': uzytkownik,
                'success_message': None,
                'error_message': error_message,
            })
    
        # Jeśli wybrano region "Poza Polską", kod pocztowy nie jest wymagany
        if region_id == '17':
            if 'Kod_pocztowy' in form.errors:
                form.errors.pop('Kod_pocztowy')
            # Tworzymy kopię cleaned_data (jeśli istnieje) i dodajemy pusty kod pocztowy
            data_copy = form.data.copy()
            data_copy['Kod_pocztowy'] = None  # Używamy None zamiast pustego ciągu
            form.data = data_copy
            if hasattr(form, 'cleaned_data'):
                form.cleaned_data['Kod_pocztowy'] = None
    
        if form.is_valid():
            try:
                miejsce = form.save(commit=False)
                miejsce.ID_Użytkownik = uzytkownik
                miejsce.Data_dodania = timezone.now()
                if region_id == '17':
                    miejsce.Kod_pocztowy = None
                
                maps_link = request.POST.get('Link')  # Poprawiona nazwa pola
                if maps_link:
                    miejsce.Link = maps_link
                miejsce.save()

                url_zdjecia = request.POST.get('URL_zdjecia')
                upload_zdjecia = request.FILES.get('upload_zdjecia')
                if upload_zdjecia:
                    upload_path = os.path.join(settings.MEDIA_ROOT, 'zdjecia')
                    os.makedirs(upload_path, exist_ok=True)
                    filename = f"{miejsce.ID_Miejsce}_{upload_zdjecia.name}"
                    filepath = os.path.join(upload_path, filename)
                    with open(filepath, 'wb+') as destination:
                        for chunk in upload_zdjecia.chunks():
                            destination.write(chunk)
                    url_zdjecia = os.path.join(settings.MEDIA_URL, 'zdjecia', filename)
                    zdjecie = Zdjęcia()
                    zdjecie.ID_Miejsce = miejsce
                    zdjecie.URL = url_zdjecia
                    zdjecie.ID_Recenzja = None
                    zdjecie.save()
                elif url_zdjecia:
                    zdjecie = Zdjęcia()
                    zdjecie.ID_Miejsce = miejsce
                    zdjecie.URL = url_zdjecia
                    zdjecie.ID_Recenzja = None
                    zdjecie.save()
                
                # Ensure rating is added
                if ocena and ocena.isdigit() and int(ocena) > 0:
                    ocena_int = int(ocena)
                    recenzja = Recenzja()
                    recenzja.ID_Użytkownik = uzytkownik
                    recenzja.Ocena = ocena_int
                    recenzja.Komentarz = None
                    recenzja.Data_dodania = timezone.now()
                    recenzja.ID_Miejsce = miejsce
                    recenzja.save()
                else:
                    # If we get here without a valid rating, something went wrong with validation
                    # Remove the place we just added
                    miejsce.delete()
                    error_message = "Dodanie oceny jest wymagane. Miejsce nie zostało dodane."
                    return render(request, 'app/dodaj_miejsce.html', {
                        'form': form,
                        'uzytkownik': uzytkownik,
                        'success_message': None,
                        'error_message': error_message,
                    })
                
                # Dodaj komunikat i przekieruj na stronę atrakcji
                messages.success(request, "Miejsce zostało dodane pomyślnie!")
                return redirect('atrakcje')
            except Exception as e:
                error_message = f"Błąd podczas zapisywania: {e}"
        else:
            error_message = "Formularz nieprawidłowy: " + "; ".join([f"{k}: {v}" for k, v in form.errors.items()])
    else:
        form = MiejsceForm()
    return render(request, 'app/dodaj_miejsce.html', {
        'form': form,
        'uzytkownik': uzytkownik,
        'success_message': None,
        'error_message': error_message,
    })

def miejsce_szczegoly(request, id):
    miejsce = get_object_or_404(Miejsce, pk=id)
    page = request.GET.get('page', '1')
    rec_limit = int(request.GET.get('rec_limit', 6))  # domyślnie 6

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

    all_recenzje = Recenzja.objects.filter(ID_Miejsce=miejsce).select_related('ID_Użytkownik').order_by('-Data_dodania')
    recenzje = all_recenzje[:rec_limit]  # tylko część

    pokaz_wiecej = rec_limit < all_recenzje.count()  # czy są jeszcze jakieś recenzje?

    srednia_ocena = all_recenzje.aggregate(Avg('Ocena'))['Ocena__avg']
    zdjecia_miejsca = Zdjęcia.objects.filter(ID_Miejsce=miejsce, URL__isnull=False).exclude(URL='')

    return render(request, 'app/miejsce_szczegoly.html', {
        'miejsce': miejsce,
        'uzytkownik': uzytkownik,
        'recenzje': recenzje,
        'srednia_ocena': srednia_ocena or 0,
        'zdjecia_miejsca': zdjecia_miejsca,
        'page': page,
        'rec_limit': rec_limit,
        'pokaz_wiecej': pokaz_wiecej
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
