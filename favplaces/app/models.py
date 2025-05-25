from django.db import models

class HistoriaWyszukiwan(models.Model):
    ID_Historii = models.AutoField(primary_key=True, db_column='ID_Historia')
    ID_Użytkownik = models.ForeignKey('Uzytkownik', db_column='ID_Użytkownik', on_delete=models.DO_NOTHING)
    Data_wyszukiwania = models.DateTimeField(auto_now_add=True)
    ID_Miejsca = models.ForeignKey('Miejsce', db_column='ID_Miejsce', on_delete=models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'historia_wyszukiwan'  

    def __str__(self):
        return self.wyszukiwana_fraza
    


class Miejsce(models.Model):
    ID_Miejsce = models.AutoField(primary_key=True)
    ID_Region = models.ForeignKey('Region', db_column='ID_Region', on_delete=models.DO_NOTHING)
    ID_Kategoria = models.ForeignKey('Kategoria', db_column='ID_Kategoria', on_delete=models.DO_NOTHING)
    ID_Użytkownik = models.ForeignKey('Uzytkownik', db_column='ID_Użytkownik', on_delete=models.DO_NOTHING)
    Nazwa = models.CharField(max_length=100)
    Ulica = models.CharField(max_length=100)
    Opis = models.CharField(max_length=100)
    Data_dodania = models.DateTimeField(auto_now_add=True)
    Miejscowość = models.CharField(max_length=100)
    Kod_pocztowy = models.CharField(max_length=6)
    """
    ID_Zdjęcie = models.ForeignKey('Zdjęcia', db_column='ID_Zdjęcie', on_delete=models.DO_NOTHING)"""

    class Meta:
        managed = False
        db_table = 'Miejsce'  
        verbose_name = 'Miejsce'  # Singular name
        verbose_name_plural = 'Miejsca'  # Plural name

    def __str__(self):
        return self.Nazwa  # Corrected attribute name

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
    
class Region(models.Model):
    ID_Regionu = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'Region'  

    def __str__(self):
        return self.Nazwa

class Uprawnienia(models.Model):
    ID_Uprawnienia = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'Uprawnienia'  

    def __str__(self):
        return self.nazwa

class Uzytkownik(models.Model):
    ID_Użytkownik = models.AutoField(primary_key=True)  
    Imie = models.CharField(max_length=100)
    Nazwisko = models.CharField(max_length=100)
    Mail = models.CharField(max_length=100)    #można zmienić na EmailField tu i w bazie
    Hasło = models.CharField(max_length=100)
    ID_Uprawnienia = models.ForeignKey(Uprawnienia, db_column='ID_Uprawnienia', on_delete=models.DO_NOTHING) 

    class Meta:
        managed = False
        db_table = 'Użytkownik'  

    def __str__(self):
        return f"{self.Imie} {self.Nazwisko}"  # Corrected attribute names
    
class Zdjęcia(models.Model):
    ID_Zdjęcie = models.AutoField(primary_key=True)
    ID_Miejsce = models.ForeignKey('Miejsce', db_column='ID_Miejsce', on_delete=models.DO_NOTHING, null=True, blank=True, related_name='zdjęcia')
    ID_Recenzja = models.ForeignKey('Recenzja', db_column='ID_Recenzja', on_delete=models.DO_NOTHING, null=True, blank=True)
    #obraz = models.ImageField(upload_to='zdjecia/', null=True, blank=True)  # dla plików lokalnych
    URL = models.CharField(max_length=255, null=True, blank=True)  # dla zewnętrznych linków


    class Meta:
        managed = False
        db_table = 'Zdjęcia'  

    def __str__(self):
        return self.zdjęcie


class Kategoria(models.Model):
    ID_Kategoria = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'Kategoria'  

    def __str__(self):
        return self.Nazwa

class Ranking(models.Model):
    ID_Ranking = models.AutoField(primary_key=True)
    Nazwa = models.CharField(max_length=100)
    Opis = models.TextField(null=True, blank=True)
    Data_utworzenia = models.DateTimeField(auto_now_add=True)
    Miejsca = models.ManyToManyField('Miejsce', related_name='rankingi')

    class Meta:
        managed = True  # Ensure Django manages this table
        db_table = 'Ranking'
        verbose_name = 'Ranking'
        verbose_name_plural = 'Rankingi'

    def __str__(self):
        return self.Nazwa