from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView
from .views import (
    RegisterView,
    LoginView,
    LogoutView,
    ForgotPasswordView,
)

# ================================================================
# 🌐 AUTHENTICATION ROUTES
# These endpoints handle user registration, login, token refresh,
# logout (blacklist refresh token), and password reset.
# ================================================================

urlpatterns = [
    # 🧩 REGISTER
    # POST -> /api/auth/register/
    # Body: { "email": "", "password": "", "name": "" }
    path('register/', RegisterView.as_view(), name='register'),

    # 🔐 LOGIN
    # POST -> /api/auth/login/
    # Body: { "email": "", "password": "" }
    path('login/', LoginView.as_view(), name='login'),

    # 🔁 TOKEN REFRESH
    # POST -> /api/auth/token/refresh/
    # Body: { "refresh": "<refresh_token>" }
    # Returns new access token (without forcing re-login)
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    # 🚪 LOGOUT
    # POST -> /api/auth/logout/
    # Body: { "refresh": "<refresh_token>" }
    # Blacklists refresh token so it can’t be reused
    path('logout/', LogoutView.as_view(), name='logout'),

    # 📧 FORGOT PASSWORD
    # POST -> /api/auth/forgot-password/
    # Body: { "email": "<user_email>" }
    # Sends password reset link to user's email
    path('forgot-password/', ForgotPasswordView.as_view(), name='forgot_password'),
]
