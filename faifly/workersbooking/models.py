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
    date_work_start = models.DateField(verbose_name = 'Дата начала смены')
    date_work_finish = models.DateField(verbose_name = 'Дата окончания смены')
    time_start = models.TimeField(verbose_name = 'Начало смены')  # Start work datetime
    time_finish = models.TimeField(verbose_name = 'Конец смены')  # Finish work datetime

    class Meta:
        verbose_name = 'Расписание'
        verbose_name_plural = 'Расписания'

    def __str__(self):
        return f'{self.date_work_start} {self.time_start} - {self.date_work_finish} {self.time_finish}'
        # 21.06.2022 23:45 - 22.06.2022 08:00

class Specialities(models.Model):
    '''
    Specialities of workers
    '''
    name = models.CharField(max_length = 255, verbose_name = 'Специальность')
    slug = models.CharField(max_length = 255)

    class Meta:
        verbose_name = 'Специальность'
        verbose_name_plural = 'Специальности'
        ordering = ('name',)

    def __str__(self):
        return self.name


class Booking(models.Model):
    '''
    Booked procedures by customers
    '''
    proc_name = models.CharField(max_length=255, verbose_name = 'Процедура')  # Name of procedure
    customer_name = models.CharField(max_length=255, verbose_name = 'Имя посетителя')  # Customer's name
    master = models.ForeignKey('Workers', on_delete=models.SET_NULL, null=True, verbose_name = 'Мастер')  # Master's name
    starting_date = models.DateField(verbose_name='Дата начала процедуры')
    finish_date = models.DateField(verbose_name='Дата окончания процедуры')
    starting_time = models.TimeField(verbose_name = 'Время начала процедуры')  # Starting datetime of proc
    finish_time = models.TimeField(verbose_name = 'Время конца процедуры')  # Finish datetime of proc

    class Meta:
        verbose_name = 'Запись'
        verbose_name_plural = 'Записи'

    def __str__(self):
        return f'{self.proc_name} from {self.starting_datetime} to {self.finish_datetime}'
        # returning <proc_name> from <date_time> to <date_time>


class Workers(models.Model):
    '''
    Workers and their schedules with location
    '''
    name = models.CharField(max_length=255, verbose_name = 'Имя')  # Worker's name
    speciality = models.ForeignKey('Specialities', on_delete = models.SET_NULL, null=True, verbose_name='Специальность')
    location = models.ForeignKey('Location', on_delete=models.SET_NULL, null=True, verbose_name = 'Место работы')  # Worker Location
    schedule = models.ManyToManyField('Schedules', verbose_name = 'Расписание', blank = True, related_name='schedule')  # Worker schedule

    class Meta:
        verbose_name = 'Работник'
        verbose_name_plural = 'Работники'

    def __str__(self):
        return str(self.name)  # Returning the worker's name
