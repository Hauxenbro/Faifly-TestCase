from rest_framework import serializers
from .models import Workers, Booking

class WorkersSerializer(serializers.ModelSerializer):
    '''
    Configuration of serializer for worker model class
    '''
    class Meta:
        model = Workers # model name
        fields = ('name', 'speciality', 'location', 'schedule') # fields would be shown

class ThinWorkerSerializer(serializers.ModelSerializer):
    '''
    Added for authenticated user detailed view for changing
    '''
    details = serializers.HyperlinkedIdentityField(view_name='workers-detail')
    class Meta:
        model = Workers
        fields = ('name', 'speciality', 'location', 'schedule', 'details')


class BookingSerializer(serializers.ModelSerializer):
    '''
    Configuration of serializer for booking model class
    '''
    class Meta:
        model = Booking
        fields = ('proc_name', 'customer_name', 'master', 'starting_date', 'starting_time', 'finish_date', 'finish_time')

class ThinBookingSerializer(serializers.ModelSerializer):
    '''
    Added for staff user detailed view
    '''
    details = serializers.HyperlinkedIdentityField(view_name='booking-detail')
    class Meta:
        model = Booking
        fields = fields = ('proc_name', 'customer_name', 'master', 'starting_date', 'starting_time', 'finish_date', 'finish_time', 'details')
