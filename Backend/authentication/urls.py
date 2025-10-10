# core/urls.py
from django.urls import path, include
from django.contrib import admin

urlpatterns = [
    path('admin/', include('admin.site.urls')),
    path('accounts/', include('allauth.urls')),
]

