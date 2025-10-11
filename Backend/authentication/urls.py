from django.urls import path, include

from Backend.authentication.views import LoginAPIView, LogoutView, UserView, registerAPIView

urlpatterns = [
    path('register/', registerAPIView.as_view()),
    path('login/', LoginAPIView.as_view()),
    path('user/', UserView.as_view()),
    path('logout/', LogoutView.as_view())
]
