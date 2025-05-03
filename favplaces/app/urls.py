from django.urls import path
from . import views


urlpatterns = [
    path('rejestracja/', views.rejestracja, name='rejestracja'),
    path('logowanie/', views.logowanie, name='logowanie'),
    path('', views.strona_glowna, name='strona_glowna'),  # przykład strony po zalogowaniu
    path('wyloguj/', views.wyloguj, name='wyloguj'),
]