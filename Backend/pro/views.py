from django.shortcuts import render
from rest_framework import generics
from .models import Product
from .serializer import ProductSerializer


class ProductListCreateAPIView(generics.ListCreateAPIView):
  queryset = Product.objects.all()
  serializer_class = ProductSerializer
  
  
