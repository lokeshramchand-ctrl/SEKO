# store/admin.py
import os 
from django.contrib import admin
from .models import Category, Product
from django import forms
class ProductInline(admin.TabularInline):  
    model = Product
    extra = 1  

class ProductAdminForm(forms.ModelForm):
    existing_image = forms.ChoiceField(
        choices=[(f'images/{f}', f) for f in os.listdir('./images')],
        required=False
    )
@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ("name",)
    inlines = [ProductInline]  


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ("name", "category", "price" )
