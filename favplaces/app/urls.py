from django.urls import path
from . import views


urlpatterns = [
    path('rejestracja/', views.rejestracja, name='rejestracja'),
    path('logowanie/', views.logowanie, name='logowanie'),
    path('', views.strona_glowna, name='strona_glowna'),
    path('atrakcje/', views.atrakcje, name='atrakcje'),
    path('historia/', views.historia, name='historia'),  
    path('ranking/', views.ranking, name='ranking'),  
    path('wyloguj/', views.wyloguj, name='wyloguj'),
    path('dodaj/', views.dodaj_miejsce, name='dodaj_miejsce'),
    path('miejsce/<int:id>/', views.miejsce_szczegoly, name='miejsce_szczegoly'),
]