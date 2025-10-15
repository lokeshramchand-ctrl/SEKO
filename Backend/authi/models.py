from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    flat_no = models.CharField(max_length=20, blank=True, null=True)
