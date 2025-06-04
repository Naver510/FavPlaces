from django.contrib import admin
from .models import Uprawnienia, Uzytkownik, Miejsce, Recenzja, Region, Kategoria, Zdjęcia, HistoriaWyszukiwan, Ranking

admin.site.register(Uprawnienia)
admin.site.register(Uzytkownik)
admin.site.register(Miejsce)
admin.site.register(Recenzja)
admin.site.register(Region)
admin.site.register(Kategoria)
admin.site.register(Zdjęcia)
admin.site.register(HistoriaWyszukiwan)
admin.site.register(Ranking)