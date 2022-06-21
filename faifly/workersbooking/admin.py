from django.contrib import admin
from .models import Location, Schedules, Booking, Workers

# Register your models here.

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    '''
    Configuration of view at the admin panel
    '''
    list_display = ['id', 'proc_name', 'customer_name', 'master', 'starting_datetime', 'finish_datetime']
    list_filter = ('master',)
    search_fields = ('customer_name', 'master')
    ordering = ['id',]

@admin.register(Workers)
class WorkersAdmin(admin.ModelAdmin):
    '''
    Configuration of view at the admin panel
    '''
    list_display = ['id', 'name']
    list_display_links = ['id', 'name']
    list_filter = ('working_location',)
    search_fileds = ('name', 'working_location',)
    ordering = ['id',]

admin.site.register(Location)
admin.site.register(Schedules)
