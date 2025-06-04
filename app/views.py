from django.shortcuts import render
from django.http import HttpResponse
from .models import Uzytkownik, HistoriaWyszukiwan
from django.db.models import Q
from collections import defaultdict
from django.core.paginator import Paginator
from datetime import datetime

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

            historia_dict = defaultdict(list)
            for wpis in historia_qs:
                data_key = wpis.Data_wyszukiwania.date()
                historia_dict[data_key].append(wpis)

            historia_by_day = sorted(historia_dict.items(), key=lambda x: x[0], reverse=True)

            paginator = Paginator(historia_by_day, 1)
            page_number = request.GET.get('page')
            page_obj = paginator.get_page(page_number)

            if page_obj.object_list:
                biezaca_data = page_obj.object_list[0][0]
                historia_lista = page_obj.object_list[0][1]
            else:
                biezaca_data = None

        except Uzytkownik.DoesNotExist:
            return HttpResponse("Użytkownik nie znaleziony.", status=404)

    return render(request, 'app/historia.html', {
        'biezaca_data': biezaca_data,
        'historia_lista': historia_lista,
        'data_wyszukiwania': data_wyszukiwania,
    })