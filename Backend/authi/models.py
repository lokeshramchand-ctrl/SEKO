
# Create your models here.
from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager

# ============================================================
# 🧩 USER MANAGER
# Handles user creation logic (email-based login)
# ============================================================

class UserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        """
        Create and return a regular user with an email and password.
        """
        if not email:
            raise ValueError('Users must have an email address')
        
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        """
        Create and return a superuser.
        """
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self.create_user(email, password, **extra_fields)

# ============================================================
# 🧍 CUSTOM USER MODEL
# Replaces Django's default username-based system with email
# ============================================================

class User(AbstractUser):
    username = None  # Remove username field
    email = models.EmailField(unique=True)  # Unique email for login
    name = models.CharField(max_length=255, blank=True, null=True)
    flat_no = models.CharField(max_length=20, blank=True, null=True)  # Example custom field

    # Authentication configuration
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    # Connect custom manager
    objects = UserManager()

    def __str__(self):
        return self.email
