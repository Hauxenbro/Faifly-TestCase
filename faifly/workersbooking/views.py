from datetime import datetime
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
from rest_framework import status
from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from .models import Workers, Booking
from .serializers import WorkersSerializer, BookingSerializer, ThinWorkerSerializer, ThinBookingSerializer
from .permissions import IsAdminOrReadOnly, IsAdminOrPostOnly


# Create your views here.

class CustomWorkerFilter(filters.BaseFilterBackend):
    def filter_queryset(self, request, queryset, view):
        speciality = request.query_params.get('spec', None)
        period_date = request.query_params.get('date', None)
        if period_date and speciality:
            period_date = datetime.strptime(period_date, '%Y-%M-%d').date()
            return queryset.filter(speciality__slug=speciality, schedule__date_work_start__lte=period_date, schedule__date_work_finish__gte=period_date)
        elif period_date:
            return queryset.filter(schedule__date_work_start__lte=period_date, schedule__date_work_finish__gte=period_date)
        elif speciality:
            return queryset.filter(speciality__slug=speciality)
        else:
            return queryset.all()

class CustomBookingFilter(filters.BaseFilterBackend):
    def filter_queryset(self, request, queryset, view):
        period_date = request.query_params.get('date', None)
        if period_date:
            # period_date = datetime.strptime(period_date, '%Y-%M-%d').date()
            return queryset.filter(starting_date=period_date)
        else:
            return queryset.all()

class WorkerViewSet(ModelViewSet):
    '''
    Configuration of worker view set

    filters: /?spec=...&date=<y-m-d>
    '''
    permission_classes = (IsAuthenticatedOrReadOnly,) # Permission for reading only if user is not authenticated
    queryset = Workers.objects.all()
    filter_backends = (DjangoFilterBackend, CustomWorkerFilter,)

    def get_serializer_class(self):
        if self.request.user.is_staff:
            return ThinWorkerSerializer
        else:
            return WorkersSerializer

class BookingViewSet(ModelViewSet):
    '''
    Configuration of booking view set

    filters : /?date=<y-m-d>
    '''
    permission_classes = (IsAdminOrPostOnly,) # Permission for posting if user is not a stuff
    filter_backends = (DjangoFilterBackend, CustomBookingFilter)

    def get_queryset(self):
        if self.request.user.is_staff: # If user is admin can see all records
            return Booking.objects.all()
        elif self.request.user.is_authenticated: # If user is authenticated can see only his records
            return Booking.objects.filter(master_id=self.request.user.id)
        else:
            return []

    def get_serializer_class(self):
        if self.request.user.is_staff:
            return ThinBookingSerializer
        else:
            return BookingSerializer

    def create(self, request, *args, **kwargs):
        booked_proc = Booking.objects.filter(master_id=request.data['master'], starting_date=request.data['starting_date'])
        # Taking booked processes with collected starting date and current master
        worker = Workers.objects.get(id=request.data['master']) # Taking appropriate worker
        req_st_d = datetime.strptime(request.data['starting_date'], '%Y-%m-%d').date()  # Taking starting date from collected data
        req_fin_d = datetime.strptime(request.data['finish_date'], '%Y-%m-%d').date() # Taking finish date from collected data
        req_start = datetime.strptime(request.data['starting_time'], '%H:%M').time() # Taking starting time from collected data
        req_finish = datetime.strptime(request.data['finish_time'], '%H:%M').time() # Taking finish time from collected data
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid()
        invalid = False # Check valid flag
        for proc in booked_proc: # Taking every process from booked processes
            if req_fin_d == proc.finish_date: # One day finishing
                if req_start >= proc.starting_time and req_start < proc.finish_time:
                    invalid = True
                    break
            else: # Different day of finishing
                if req_start >= proc.starting_time:
                    invalid = True
                    break
        if invalid:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST) # Calling error
        else:
            for sched in worker.schedule.all(): # Taking all schedules of appropriate master

                #One day start and finish, Scheduled finish time > Starting time of proc > Scheduled start time
                if req_st_d == sched.date_work_finish and req_start >= sched.time_start and req_start < sched.time_finish:
                    if req_finish <= sched.time_finish:
                        serializer.save()
                        return Response(serializer.data, status = status.HTTP_201_CREATED)
                # Different days of starting and finishing, starting time of process > scheduled starting time of work
                elif req_st_d != sched.date_work_finish and req_start > sched.time_start:
                    # If current finish day differs from scheduled finish date or finish date < scheduled finish of next day if one day
                    if req_fin_d < sched.date_work_finish or req_finish <= sched.time_finish:
                        serializer.save()
                        return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


