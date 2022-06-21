from django.db import models


# Create your models here.

class Location(models.Model):
    '''
    Working place for workers.
    '''
    name = models.CharField(max_length=255, verbose_name = 'Название')  # Name of location

    class Meta:
        verbose_name = 'Локация'
        verbose_name_plural = 'Локации'

    def __str__(self):
        return self.name


class Schedules(models.Model):
    '''
    Schedules for workers
    '''
    date_start = models.DateTimeField(verbose_name = 'Начало смены')  # Start work datetime
    date_finish = models.DateTimeField(verbose_name = 'Конец смены')  # Finish work datetime

    class Meta:
        verbose_name = 'Расписание'
        verbose_name_plural = 'Расписания'

    def __str__(self):
        return f'{self.date_start} - {self.date_finish}'
        # 21.06.2022 23:45 - 22.06.2022 08:00


class Booking(models.Model):
    '''
    Booked procedures by customers
    '''
    proc_name = models.CharField(max_length=255, verbose_name = 'Процедура')  # Name of procedure
    customer_name = models.CharField(max_length=255, verbose_name = 'Имя посетителя')  # Customer's name
    master = models.ForeignKey('Workers', on_delete=models.SET_NULL, null=True, verbose_name = 'Мастер')  # Master's name
    starting_datetime = models.DateTimeField(verbose_name = 'Начало процедуры')  # Starting datetime of proc
    finish_datetime = models.DateTimeField(verbose_name = 'Конец процедуры')  # Finish datetime of proc

    class Meta:
        verbose_name = 'Запись'
        verbose_name_plural = 'Записи'

    def __str__(self):
        return str(self.pk)  # Returning the id of booked procedure


class Workers(models.Model):
    '''
    Workers, schedules and booked procedures.
    '''
    name = models.CharField(max_length=255, verbose_name = 'Имя')  # Worker's name
    working_location = models.ForeignKey('Location', on_delete=models.SET_NULL, null=True, verbose_name = 'Место работы')  # Worker Location
    working_schedule = models.ManyToManyField('Schedules', verbose_name = 'Расписание', blank = True, related_name='schedule')  # Worker schedule
    booked_proc = models.ManyToManyField('Booking', verbose_name = 'Записи', blank = True)  # Booked procedures

    class Meta:
        verbose_name = 'Работник'
        verbose_name_plural = 'Работники'

    def __str__(self):
        return str(self.name)  # Returning the worker's name
