from rest_framework import serializers
from django.contrib.auth import authenticate
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError
from .models import User


# ================================================================
# 🧩 USER SERIALIZER
# Used for serializing User model data (read-only fields)
# ================================================================
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'email', 'name', 'is_active', 'is_staff']
        read_only_fields = ['id', 'is_active', 'is_staff']


# ================================================================
# 📝 REGISTER SERIALIZER
# Handles creation of a new user (signup)
# ================================================================
class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        write_only=True,
        required=True,
        
        
        
        validators=[validate_password],
        style={'input_type': 'password'}
    )
    password2 = serializers.CharField(
        write_only=True,
        required=True,
        style={'input_type': 'password'}
    )

    class Meta:
        model = User
        fields = ['email', 'name', 'password', 'password2']

    def validate(self, attrs):
        # Ensure both passwords match
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Passwords do not match"})
        return attrs

    def create(self, validated_data):
        # Remove password2 as it's not part of the model
        validated_data.pop('password2')
        user = User.objects.create_user(**validated_data)
        return user


# ================================================================
# 🔐 LOGIN SERIALIZER
# Validates user credentials and authenticates login
# ================================================================
class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)
    password = serializers.CharField(write_only=True, required=True)

    def validate(self, attrs):
        email = attrs.get('email')
        password = attrs.get('password')

        from .models import User
        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError("Invalid email or password.")

        if not user.check_password(password):
            raise serializers.ValidationError("Invalid email or password.")

        if not user.is_active:
            raise serializers.ValidationError("Account is inactive.")

        attrs['user'] = user
        return attrs



# ================================================================
# 📧 FORGOT PASSWORD SERIALIZER
# Initiates password reset by sending an email
# ================================================================
class ForgotPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)

    def validate_email(self, value):
        # Verify that a user exists with this email
        if not User.objects.filter(email=value).exists():
            raise serializers.ValidationError("No account found with this email.")
        return value


# ================================================================
# 🔄 RESET PASSWORD SERIALIZER
# Used after clicking the reset link to set a new password
# ================================================================
class ResetPasswordSerializer(serializers.Serializer):
    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Passwords do not match."})
        return attrs

    def save(self, user):
        """
        Takes a user instance (found from the reset token)
        and updates the password securely.
        """
        password = self.validated_data['password']
        user.set_password(password)
        user.save()
        return user
