from rest_framework.routers import DefaultRouter
from .views import WorkerViewSet, BookingViewSet

router = DefaultRouter()
router.register('workers', WorkerViewSet, basename='workers')
router.register('booking', BookingViewSet, basename='booking')
urlpatterns = router.urls