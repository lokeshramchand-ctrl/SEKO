# core/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # Django Allauth routes for social logins (handles Google OAuth redirects)
    path('accounts/', include('allauth.urls')),
    
    # Your app's API endpoints
    path('api/', include('authentication.urls')),
]
