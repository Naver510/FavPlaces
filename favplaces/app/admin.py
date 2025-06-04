from django.contrib import admin
from .models import Miejsce, Ranking, Zdjęcia

# Inline admin for Zdjęcia
class ZdjęciaInline(admin.TabularInline):
    model = Zdjęcia
    extra = 1  # Allows adding one new photo by default
    fields = ('URL',)  # Display only the URL field for editing
    can_delete = True  # Allow deletion of photos

@admin.register(Miejsce)
class MiejsceAdmin(admin.ModelAdmin):
    list_display = ('Nazwa', 'Miejscowość', 'Kod_pocztowy', 'Ulica', 'Data_dodania')
    search_fields = ('Nazwa', 'Miejscowość', 'Kod_pocztowy', 'Ulica')
    list_filter = ('ID_Region', 'ID_Kategoria', 'Data_dodania')
    inlines = [ZdjęciaInline]  # Add the Zdjęcia inline to MiejsceAdmin

@admin.register(Ranking)
class RankingAdmin(admin.ModelAdmin):
    list_display = ('Nazwa', 'Data_utworzenia')
    search_fields = ('Nazwa',)
    filter_horizontal = ('Miejsca',)  # Allows selecting multiple places
    ordering = ('-Data_utworzenia',)

@admin.register(Zdjęcia)
class ZdjęciaAdmin(admin.ModelAdmin):
    list_display = ('ID_Miejsce', 'URL', 'ID_Recenzja')
    search_fields = ('URL',)
    list_filter = ('ID_Miejsce',)
    ordering = ('ID_Miejsce',)