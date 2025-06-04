from django.db import migrations, models
import django.db.models.deletion

class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name='Uprawnienia',
            fields=[
                ('ID_Uprawnienia', models.AutoField(primary_key=True, serialize=False)),
                ('Nazwa', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'Uprawnienia',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Uzytkownik',
            fields=[
                ('ID_Użytkownik', models.AutoField(primary_key=True, serialize=False)),
                ('Imie', models.CharField(max_length=100)),
                ('Nazwisko', models.CharField(max_length=100)),
                ('Mail', models.CharField(max_length=100)),
                ('Hasło', models.CharField(max_length=100)),
                ('ID_Uprawnienia', models.ForeignKey(db_column='ID_Uprawnienia', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Uprawnienia')),
            ],
            options={
                'db_table': 'Użytkownik',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Miejsce',
            fields=[
                ('ID_Miejsce', models.AutoField(primary_key=True, serialize=False)),
                ('Nazwa', models.CharField(max_length=100)),
                ('Ulica', models.CharField(max_length=100)),
                ('Opis', models.CharField(max_length=100)),
                ('Data_dodania', models.DateTimeField(auto_now_add=True)),
                ('Miejscowość', models.CharField(max_length=100)),
                ('Kod_pocztowy', models.CharField(max_length=6)),
                ('Link', models.CharField(max_length=255)),
                ('ID_Region', models.ForeignKey(db_column='ID_Region', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Region')),
                ('ID_Kategoria', models.ForeignKey(db_column='ID_Kategoria', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Kategoria')),
                ('ID_Użytkownik', models.ForeignKey(db_column='ID_Użytkownik', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Uzytkownik')),
            ],
            options={
                'db_table': 'Miejsce',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Recenzja',
            fields=[
                ('ID_Recenzja', models.AutoField(primary_key=True, serialize=False)),
                ('Ocena', models.IntegerField()),
                ('Komentarz', models.CharField(max_length=100)),
                ('Data_dodania', models.DateTimeField(auto_now_add=True)),
                ('ID_Użytkownik', models.ForeignKey(db_column='ID_Użytkownik', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Uzytkownik')),
                ('ID_Miejsce', models.ForeignKey(db_column='ID_Miejsce', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Miejsce')),
            ],
            options={
                'db_table': 'Recenzja',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Region',
            fields=[
                ('ID_Regionu', models.AutoField(primary_key=True, serialize=False)),
                ('Nazwa', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'Region',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Kategoria',
            fields=[
                ('ID_Kategoria', models.AutoField(primary_key=True, serialize=False)),
                ('Nazwa', models.CharField(max_length=100)),
            ],
            options={
                'db_table': 'Kategoria',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Zdjęcia',
            fields=[
                ('ID_Zdjęcie', models.AutoField(primary_key=True, serialize=False)),
                ('URL', models.CharField(max_length=255, null=True, blank=True)),
                ('ID_Miejsce', models.ForeignKey(db_column='ID_Miejsce', on_delete=django.db.models.deletion.DO_NOTHING, null=True, blank=True, related_name='zdjęcia')),
                ('ID_Recenzja', models.ForeignKey(db_column='ID_Recenzja', on_delete=django.db.models.deletion.DO_NOTHING, null=True, blank=True)),
            ],
            options={
                'db_table': 'Zdjęcia',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='HistoriaWyszukiwan',
            fields=[
                ('ID_Historii', models.AutoField(primary_key=True, serialize=False)),
                ('Data_wyszukiwania', models.DateTimeField(auto_now_add=True)),
                ('ID_Użytkownik', models.ForeignKey(db_column='ID_Użytkownik', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Uzytkownik')),
                ('ID_Miejsca', models.ForeignKey(db_column='ID_Miejsce', on_delete=django.db.models.deletion.DO_NOTHING, to='app.Miejsce')),
            ],
            options={
                'db_table': 'historia_wyszukiwan',
                'managed': False,
            },
        ),
    ]