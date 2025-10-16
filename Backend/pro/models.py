from django.db import models

# Create your models here.
class Category(models.Model):
  name = models.CharField(max_length=250)
  class Meta:
        verbose_name_plural = "Categories"  # nicer plural name in admin

  def __str__(self):
        return self.name

  
class Product(models.Model):
  name = models.CharField(max_length=250)
  price = models.DecimalField(max_digits=6 , decimal_places=2)
  category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE,
        related_name="products"
    )
  
  def __str__(self):
    return self.name
