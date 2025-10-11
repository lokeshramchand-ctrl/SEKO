from django.urls import path
from . import views

urlpatterns = [
    path('auth/google/', views.google_auth_view, name='google_auth'),
    path('auth/logout/', views.custom_logout, name='logout'),
    path('auth/check/', views.check_auth, name='check_auth'),
]
