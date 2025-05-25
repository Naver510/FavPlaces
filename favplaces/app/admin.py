from django.contrib import admin
from .models import Miejsce, Ranking

# Register your models here.
@admin.register(Miejsce)
class MiejsceAdmin(admin.ModelAdmin):
    list_display = ('Nazwa', 'Miejscowość', 'Kod_pocztowy', 'Ulica', 'Data_dodania')
    search_fields = ('Nazwa', 'Miejscowość', 'Kod_pocztowy', 'Ulica')
    list_filter = ('ID_Region', 'ID_Kategoria', 'Data_dodania')

@admin.register(Ranking)
class RankingAdmin(admin.ModelAdmin):
    list_display = ('Nazwa', 'Data_utworzenia')
    search_fields = ('Nazwa',)
    filter_horizontal = ('Miejsca',)  # Allows selecting multiple places
