from rest_framework import status, viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .models import Cart, Product
from .serializers import CartSerializer

class CartViewSet(viewsets.ModelViewSet):
    serializer_class = CartSerializer
    permission_classes = [IsAuthenticated]  # ✅ ensures user must be logged in

    def get_queryset(self):
        # each user can only see their own cart items
        return Cart.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        product = serializer.validated_data.get('product')
        quantity = serializer.validated_data.get('quantity', 1)

        # if product already exists in cart, update quantity instead of creating duplicate
        existing_item = Cart.objects.filter(user=self.request.user, product=product).first()

        if existing_item:
            existing_item.quantity += quantity
            existing_item.save()
            return existing_item
        else:
            # ✅ create new cart item for this user
            serializer.save(
                user=self.request.user,
                price_at_time=product.price
            )
