from rest_framework.permissions import BasePermission, SAFE_METHODS

class IsAdminOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
    def has_object_permission(self, request, view, obj):
        if request.user.is_authenticated:
            return request.user.is_staff
        else:
            return False


class IsAdminOrPostOnly(BasePermission):
    permission_map = {
        'GET': ['%(app_label)s.view_%(model_name)s'],
        'POST': ['%(app_label)s.add_%(model_name)s'],
        'PUT' : [],
        'PATCH' : [],
        'DELETE' : [],
    }

    def has_permission(self, request, view):
        if request.user.is_authenticated:
            if request.user.is_staff:
                self.permission_map = {
                    'GET': ['%(app_label)s.view_%(model_name)s'],
                    'POST': ['%(app_label)s.add_%(model_name)s'],
                    'PUT': ['%(app_label)s.change_%(model_name)s'],
                    'PATCH': ['%(app_label)s.change_%(model_name)s'],
                    'DELETE': ['%(app_label)s.delete_%(model_name)s'],
                }
                return True
        self.permission_map = {
            'GET': ['%(app_label)s.view_%(model_name)s'],
            'POST': ['%(app_label)s.add_%(model_name)s'],
            'PUT': [],
            'PATCH': [],
            'DELETE': [],
        }
        return True
    def has_object_permission(self, request, view, obj):
        return True