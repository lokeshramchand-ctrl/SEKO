# views.py
from django.contrib.auth import get_user_model
from django.contrib.auth import logout
from django.http import JsonResponse
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework_simplejwt.tokens import RefreshToken
import requests

User = get_user_model()


def get_tokens_for_user(user):
    """Utility to generate JWT tokens for a given user"""
    refresh = RefreshToken.for_user(user)
    return {
        'refresh': str(refresh),
        'access': str(refresh.access_token),
    }


@api_view(['POST'])
@permission_classes([AllowAny])
def google_login(request):
    """
    Flutter will send the Google ID token here.
    Django will verify it and return JWT tokens.
    """
    token = request.data.get('token')

    if not token:
        return JsonResponse({'error': 'No token provided'}, status=400)

    # Verify token with Google
    google_resp = requests.get(
        f'https://oauth2.googleapis.com/tokeninfo?id_token={token}'
    )
    if google_resp.status_code != 200:
        return JsonResponse({'error': 'Invalid Google token'}, status=400)

    google_data = google_resp.json()
    email = google_data.get('email')
    name = google_data.get('name')
    picture = google_data.get('picture')
    google_id = google_data.get('sub')

    if not email:
        return JsonResponse({'error': 'Invalid Google response'}, status=400)

    # Create or get the user
    user, created = User.objects.get_or_create(
        email=email,
        defaults={
            'username': email.split('@')[0],
            'first_name': name,
        },
    )

    # Optionally update user info
    user.first_name = name
    user.save()

    # Generate JWT tokens
    tokens = get_tokens_for_user(user)

    return JsonResponse({
        'message': 'Login successful',
        'user': {
            'id': user.id,
            'email': user.email,
            'name': user.first_name,
            'photo': picture,
        },
        'tokens': tokens
    })


@api_view(['POST'])
def custom_logout(request):
    """Invalidate refresh token on logout (optional, JWT stateless by default)"""
    logout(request)
    return JsonResponse({'message': 'User logged out successfully'})


@api_view(['GET'])
def check_auth(request):
    """Check if user is authenticated (JWT-based check)"""
    if request.user.is_authenticated:
        return JsonResponse({'authenticated': True})
    else:
        return JsonResponse({'authenticated': False}, status=403)
