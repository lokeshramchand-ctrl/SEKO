from django.contrib import admin
from django.urls import path, include
from django.views.generic import TemplateView
from django.contrib.auth.decorators import login_required
urlpatterns = [
    path('admin/', admin.site.urls),
    # your other urls, e.g. authentication app
    path('accounts/', include('allauth.urls')),   
    path('success/', login_required(TemplateView.as_view(template_name='success.html')), name='success'),
]
