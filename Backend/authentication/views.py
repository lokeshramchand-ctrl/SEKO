import requests
import json
from django.http import JsonResponse
from django.contrib.auth import get_user_model, logout
from django.views.decorators.csrf import csrf_exempt
from rest_framework.decorators import api_view
from rest_framework_simplejwt.tokens import RefreshToken

User = get_user_model()


@csrf_exempt
@api_view(['POST'])
def google_auth_view(request):
    """
    Verifies Google ID token sent from Flutter,
    creates/retrieves the user, and returns JWTs.
    """
    try:
        token = request.data.get('token')

        if not token:
            return JsonResponse({'error': 'Token missing'}, status=400)

        # Verify token via Google
        google_response = requests.get(
            f'https://oauth2.googleapis.com/tokeninfo?id_token={token}'
        )

        if google_response.status_code != 200:
            return JsonResponse({'error': 'Invalid Google token'}, status=400)

        google_data = google_response.json()
        email = google_data.get('email')
        name = google_data.get('name', 'User')
        picture = google_data.get('picture', '')

        user, _ = User.objects.get_or_create(email=email, defaults={'username': name})

        # Generate JWT tokens
        refresh = RefreshToken.for_user(user)

        return JsonResponse({
            'tokens': {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            },
            'user': {
                'email': email,
                'name': name,
                'picture': picture,
            }
        })

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


@api_view(['POST'])
def custom_logout(request):
    """
    Optional logout (JWT is stateless, but you can clear tokens client-side).
    """
    logout(request)
    return JsonResponse({'message': 'User logged out successfully'})


@api_view(['GET'])
def check_auth(request):
    """
    Check if JWT-authenticated user is logged in.
    """
    if request.user.is_authenticated:
        return JsonResponse({'authenticated': True})
    else:
        return JsonResponse({'authenticated': False}, status=403)
