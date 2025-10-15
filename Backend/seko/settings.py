

# =============================================================
# 1️⃣  BASE SETUP & ENVIRONMENT VARIABLES
# =============================================================

from pathlib import Path
import environ

BASE_DIR = Path(__file__).resolve().parent.parent

# Environment management via .env file
env = environ.Env()
environ.Env.read_env(env_file='../.env')  # Keep credentials outside GitHub

# =============================================================
# 2️⃣  SECURITY CONFIGURATION
# =============================================================

SECRET_KEY = 'django-insecure-yu848m2)s!b7ehb_5ocx5v!nbd()---a+0g1#aezniibla0rvg'
DEBUG = True  # ❗ Turn OFF in production
ALLOWED_HOSTS = ['*']  # In production → use your domain or server IP

# =============================================================
# 3️⃣  APPLICATION DEFINITION
# =============================================================

INSTALLED_APPS = [
    # Django Core Apps
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # Third-party Packages
    'corsheaders',                    # Handles cross-origin requests
    'rest_framework',                 # Core API engine
    'rest_framework_simplejwt',       # JWT authentication (stateless)

    # Local Apps
    'authi',                 # Custom app for user model & endpoints
]

# =============================================================
# 4️⃣  MIDDLEWARE PIPELINE
# =============================================================

MIDDLEWARE = [
    # Must come FIRST for CORS to work properly
    'corsheaders.middleware.CorsMiddleware',

    # Security & Session Management
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',

    # Request/Response processing
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',

    # Authentication Layer
    'django.contrib.auth.middleware.AuthenticationMiddleware',

    # Messaging + Clickjacking protection
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'seko.urls'

# =============================================================
# 5️⃣  TEMPLATES CONFIGURATION
# (Not heavily used since Flutter is the frontend)
# =============================================================

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],  # You can add template directories if using internal pages
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'seko.wsgi.application'

# =============================================================
# 6️⃣  DATABASE CONFIGURATION
# PostgreSQL for Production (Docker-friendly)
# =============================================================

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': env('POSTGRES_DB'),
        'USER': env('POSTGRES_USER'),
        'PASSWORD': env('POSTGRES_PASSWORD'),
        'HOST': env('POSTGRES_HOST', default='db'),
        'PORT': env('POSTGRES_PORT', default='5432'),
    }
}

# =============================================================
# 7️⃣  PASSWORD VALIDATION
# Security-first best practices
# =============================================================

AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

# =============================================================
# 8️⃣  INTERNATIONALIZATION
# =============================================================

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# =============================================================
# 9️⃣  STATIC FILES
# =============================================================

STATIC_URL = 'static/'

# =============================================================
# 🔟  DEFAULT FIELD & USER MODEL OVERRIDES
# =============================================================

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
# AUTH_USER_MODEL = 'authi.User'

# =============================================================
# 1️⃣1️⃣  DJANGO REST FRAMEWORK CONFIGURATION
# =============================================================

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.AllowAny',  # Restrict later if needed
    ),
}
# =============================================================
# 1️⃣2️⃣  AUTH_BACKEND CONFIGURATION (AUTHENTICATION ENGINE)
# =============================================================


AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',
]

# =============================================================
# 1️⃣2️⃣  SIMPLEJWT CONFIGURATION (AUTHENTICATION ENGINE)
# =============================================================

from datetime import timedelta

SIMPLE_JWT = {
    # Lifetime of Access Token (short-lived for security)
    'ACCESS_TOKEN_LIFETIME': timedelta(minutes=30),

    # Lifetime of Refresh Token (used to generate new access tokens)
    'REFRESH_TOKEN_LIFETIME': timedelta(days=1),

    # Token rotation & blacklist
    'ROTATE_REFRESH_TOKENS': True,
    'BLACKLIST_AFTER_ROTATION': True,

    # Algorithm & Keys
    'ALGORITHM': 'HS256',
    'SIGNING_KEY': SECRET_KEY,
    'VERIFYING_KEY': None,

    # Token Claims & Customization
    'AUTH_HEADER_TYPES': ('Bearer',),
    'USER_ID_FIELD': 'id',
    'USER_ID_CLAIM': 'user_id',

    # Sliding token support (optional)
    'SLIDING_TOKEN_LIFETIME': timedelta(minutes=30),
    'SLIDING_TOKEN_REFRESH_LIFETIME': timedelta(days=1),
}

# =============================================================
# 1️⃣3️⃣  CORS CONFIGURATION
# =============================================================

# Allow Flutter frontend → Django backend communication
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True

