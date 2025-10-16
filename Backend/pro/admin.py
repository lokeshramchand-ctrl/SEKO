# store/admin.py

from django.contrib import admin
from .models import Category, Product

class ProductInline(admin.TabularInline):  
    model = Product
    extra = 1  


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ("name",)
    inlines = [ProductInline]  


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ("name", "category", "price", )
