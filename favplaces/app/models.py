from django.db import models
from django.db.models import Avg
from decimal import Decimal, ROUND_HALF_UP

class Uprawnienia(models.Model):
    ID_Uprawnienia = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)

    class Meta:
        managed = True  # Changed to True for Supabase
        db_table = 'Uprawnienia'  

    def __str__(self):
        return self.Nazwa  # Fixed reference

class Region(models.Model):
    ID_Regionu = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)

    class Meta:
        managed = True  # Changed to True for Supabase
        db_table = 'Region'  

    def __str__(self):
        return self.Nazwa

class Kategoria(models.Model):
    ID_Kategoria = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)

    class Meta:
        managed = True  # Changed to True for Supabase
        db_table = 'Kategoria'  

    def __str__(self):
        return self.Nazwa

class Uzytkownik(models.Model):
    ID_Użytkownik = models.AutoField(primary_key=True)  
    Imie = models.CharField(max_length=100)
    Nazwisko = models.CharField(max_length=100)
    Mail = models.EmailField(max_length=100, unique=True)  # Changed to EmailField with unique constraint
    Hasło = models.CharField(max_length=255)  # Increased length for better password hashing
    ID_Uprawnienia = models.ForeignKey(Uprawnienia, db_column='ID_Uprawnienia', on_delete=models.CASCADE)  # Changed to CASCADE
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        managed = True  # Changed to True for Supabase
        db_table = 'Użytkownik'  

    def __str__(self):
        return f"{self.Imie} {self.Nazwisko}"

class Miejsce(models.Model):
    ID_Miejsce = models.AutoField(primary_key=True)
    ID_Region = models.ForeignKey(Region, db_column='ID_Region', on_delete=models.CASCADE)
    ID_Kategoria = models.ForeignKey(Kategoria, db_column='ID_Kategoria', on_delete=models.CASCADE)
    ID_Użytkownik = models.ForeignKey(Uzytkownik, db_column='ID_Użytkownik', on_delete=models.CASCADE)
    Nazwa = models.CharField(max_length=255)  # Increased length
    Ulica = models.CharField(max_length=255)  # Increased length
    Opis = models.TextField()  # Changed to TextField for longer descriptions
    Data_dodania = models.DateTimeField(auto_now_add=True)
    Miejscowość = models.CharField(max_length=255)  # Increased length
    Kod_pocztowy = models.CharField(max_length=6, null=True, blank=True)  # Allow null
    Link = models.URLField(max_length=500, null=True, blank=True)  # Changed to URLField

    class Meta:
        managed = True  # Changed to True for Supabase
        db_table = 'Miejsce'  
        verbose_name = 'Miejsce'
        verbose_name_plural = 'Miejsca'
    
    @property
    def ocena(self):
        avg = self.recenzja_set.aggregate(srednia=Avg('Ocena'))['srednia']
        if avg is not None:
            rounded = Decimal(avg).quantize(Decimal('0.1'), rounding=ROUND_HALF_UP)
            if rounded == rounded.to_integral():
                return int(rounded)
            return float(rounded)
        return 0

    def __str__(self):
        return self.Nazwa

class Recenzja(models.Model):
    ID_Recenzja = models.AutoField(primary_key=True)
    ID_Użytkownik = models.ForeignKey('Uzytkownik', db_column='ID_Użytkownik', on_delete=models.DO_NOTHING)
    Ocena = models.IntegerField()
    Komentarz = models.CharField(max_length=100)
    Data_dodania = models.DateTimeField(auto_now_add=True)
    ID_Miejsce = models.ForeignKey('Miejsce', db_column='ID_Miejsce', on_delete=models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'Recenzja'  

    def __str__(self):
        return self.opinia
    
class Ranking(models.Model):
    ID_Ranking = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)
    Opis = models.TextField(null=True, blank=True)
    Data_utworzenia = models.DateTimeField(auto_now_add=True)
    Miejsca = models.ManyToManyField('Miejsce', through='RankingMiejsca', related_name='rankingi')

    class Meta:
        managed = True
        db_table = 'Ranking'
        verbose_name = 'Ranking'
        verbose_name_plural = 'Rankingi'

    def __str__(self):
        return self.Nazwa

class RankingMiejsca(models.Model):
    id = models.AutoField(primary_key=True)
    ranking = models.ForeignKey(Ranking, on_delete=models.CASCADE, db_column='ranking_id')
    miejsce = models.ForeignKey(Miejsce, on_delete=models.CASCADE, db_column='miejsce_id')

    class Meta:
        managed = True
        db_table = 'Ranking_Miejsca'
        unique_together = ('ranking', 'miejsce')