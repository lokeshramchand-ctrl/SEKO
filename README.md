![Profile Picture](seko/assets/banner.png)


# Seko – Smart Agriculture Marketplace and Inventory System

A modern, AI-augmented agricultural marketplace built with **Flutter**, **Django**, and **PostgreSQL**, supporting product listings, authentication, cart management, and intelligent data processing.

---

## Problem

Farmers, distributors, and retailers often struggle with fragmented agricultural marketplaces. Existing systems have several limitations:

* No centralized platform combining products, inventory, authentication, and consumer access
* Complex systems that are not mobile-friendly
* Lack of automation, analytics, and AI insights
* Unreliable backend systems that cannot scale
* Difficulty integrating image-based product classification or recommendation pipelines

A unified system is needed to solve authentication, marketplace management, inventory tracking, and intelligent recommendations.

---

## Solution

Seko is designed as a complete digital agriculture ecosystem powered by Flutter and Django with PostgreSQL. It provides:

* A cross-platform mobile application for customers and sellers
* Secure authentication and user management
* Product inventory management
* Cart, checkout, and repository-based architecture
* A scalable Django backend with modular apps
* A centralized PostgreSQL database for transactional consistency
* Optional AI microservices for classification, tagging, and recommendation

Seko centralizes the entire agricultural supply chain into a seamless, intelligent platform.

---

## Features

### Core App Features

* User authentication and onboarding
* Product categories (fruits, vegetables, dairy, greens)
* Product detail pages
* Cart management and repository pattern
* Smooth navigation, animations, and UI components
* Secure API communication with backend

### Backend Features

* Django REST framework APIs
* Modular apps: authi, cart, pro
* Admin panel for managing products and categories
* Serializers, views, and URL routing for API exposure
* PostgreSQL database
* Image hosting and serving

### Optional AI Features

* Product recognition from images
* Auto-tagging and classification
* Recommendation system for buyers

### DevOps Features

* Automated CI/CD
* Docker containers for backend services
* Support for scalable deployment in cloud environments

---

## Folder Structure

Below is the combined structure containing both **Backend (Django)** and **Frontend (Flutter)**.

---

### Backend (Django)

```plaintext
Backend
    └── authi
        └── __pycache__
            ├── __init__.cpython-311.pyc
            ├── admin.cpython-311.pyc
            ├── apps.cpython-311.pyc
            ├── models.cpython-311.pyc
            ├── serializers.cpython-311.pyc
            ├── urls.cpython-311.pyc
            ├── views.cpython-311.pyc
        └── migrations
            └── __pycache__
                ├── __init__.cpython-311.pyc
                ├── 0001_initial.cpython-311.pyc
            ├── __init__.py
            ├── 0001_initial.py
        ├── __init__.py
        ├── admin.py
        ├── apps.py
        ├── models.py
        ├── serializers.py
        ├── tests.py
        ├── urls.py
        ├── views.py

    └── cart
        └── __pycache__
            ├── __init__.cpython-311.pyc
            ├── admin.cpython-311.pyc
            ├── apps.cpython-311.pyc
            ├── models.cpython-311.pyc
            ├── serializers.cpython-311.pyc
            ├── urls.cpython-311.pyc
            ├── views.cpython-311.pyc
        └── migrations
            └── __pycache__
                ├── __init__.cpython-311.pyc
                ├── 0001_initial.cpython-311.pyc
            ├── __init__.py
            ├── 0001_initial.py
        ├── __init__.py
        ├── admin.py
        ├── apps.py
        ├── models.py
        ├── serializers.py
        ├── tests.py
        ├── urls.py
        ├── views.py

    └── images
        ├── 13.png
        ├── 15.png
        ├── 17_KhWGoHy.png
        ├── 17_N3ikTGB.png
        ├── 17.png
        ├── 21_as7JzD5.png
        ├── 21_qI25Sp1.png
        ├── 21.png
        ├── 27.png
        ├── 29_EbkZDJm.png
        ├── 29.png
        ├── 33.png
        ├── 36.png
        ├── 42_SXct6Gl.png
        ├── 42.png
        ├── 9.png
        ├── Footer_Image.png
        ├── wall_secondary.png

    └── pro
        └── __pycache__
            ├── __init__.cpython-311.pyc
            ├── admin.cpython-311.pyc
            ├── apps.cpython-311.pyc
            ├── models.cpython-311.pyc
            ├── serializer.cpython-311.pyc
            ├── urls.cpython-311.pyc
            ├── views.cpython-311.pyc
        └── migrations
            └── __pycache__
                ├── __init__.cpython-311.pyc
                ├── 0001_initial.cpython-311.pyc
                ├── 0002_alter_category_options_product_image_and_more.cpython-311.pyc
                ├── 0003_alter_product_image.cpython-311.pyc
            ├── __init__.py
            ├── 0001_initial.py
            ├── 0002_alter_category_options_product_image_and_more.py
            ├── 0003_alter_product_image.py
        ├── __init__.py
        ├── admin.py
        ├── apps.py
        ├── models.py
        ├── serializer.py
        ├── tests.py
        ├── urls.py
        ├── views.py
```

---

### Frontend (Flutter)

```plaintext
lib
    └── First Sector
        └── Authentication
            ├── intropage.dart
            ├── login.dart
            ├── loginbutton.dart
            ├── signuppage.dart
        ├── animation.dart
        ├── b&sbutton.dart
        ├── Button2.dart
        ├── splash.dart

    └── Main Sector
        └── pages
            ├── dairy.dart
            ├── fruits.dart
            ├── greenies.dart
            ├── vegetables.dart
        └── repository
            ├── cart_repository.dart
            ├── product_repository.dart
        ├── cartwidget.dart
        ├── homepage.dart
        ├── ProductDetailPage.dart

    └── models
        ├── cart.dart
        ├── product.dart

    ├── Cart.dart
    ├── enviroment.dart
    ├── main.dart

test
    ├── widget_test.dart

.gitignore  
.metadata  
analysis_options.yaml  
pubspec.lock  
pubspec.yaml  
README.md  
```

---

## Tech Stack

### Frontend

* Flutter
* Dart
* Repository Pattern
* State management (provider or setState depending on implementation)

### Backend

* Django
* Django REST Framework
* PostgreSQL
* Modular backend (authi, cart, pro)
* Image hosting and static file serving

### DevOps

* Docker (optional)
* CI/CD pipelines (GitHub Actions, Jenkins, or others)

---

## Frontend (Flutter)

The Flutter app focuses on:

### Authentication Layer

* Intro page
* Login and signup UI
* Reusable buttons
* Transitions and splash animations

### Marketplace UI

* Category pages (fruits, dairy, vegetables, greenies)
* Product detail page
* Homepage with grid/list views

### Repository Pattern

* Handles product fetch
* Handles cart operations
* Clean separation between UI and data sources

### Models

* Product model
* Cart model

### App Root

* main.dart initializes routes and environment variables

---

## Backend (Django)

The backend is a modular Django ecosystem.

### authi app

Handles all authentication:

* User model
* Serializers
* Login, signup, token verification
* URL routing
* Tests

### cart app

Handles:

* Cart items
* Add/remove items APIs
* User–cart linkage
* Serializers and views

### pro app

Handles marketplace:

* Product model
* Category model
* Product detail APIs
* Product listing APIs

### Additional Features

* Admin panel for product upload
* Image hosting under /images
* PostgreSQL-powered relational schema

---

## AI & NLP (Optional Microservice)

If enabled, Seko can include:

* Product classification from images
* Text-based search ranking
* Category prediction
* Recommendation engine

This microservice can run separately and communicates via REST or internal queues.

---

## DevOps & Deployment

The system can be deployed using:

* Docker containers for backend
* nginx for static file serving
* Gunicorn + Django for production
* PostgreSQL container
* CI pipeline for testing and deployment

---

## Frontend Architecture

Key layers:

1. UI Layer
2. Authentication workflow
3. Repository-based data access
4. Models for structured data
5. Routing and navigation
6. API communication layer

---

## Backend Architecture

1. REST API Layer (Views + URLs)
2. Serialization Layer
3. Business Logic Layer
4. PostgreSQL ORM models
5. Static and media assets
6. Modular application structure

---

## AI / NLP Microservice

If added, architecture includes:

* Separate Python microservice
* FastAPI or Flask
* ML model for classification
* Exposes an inference endpoint

---

## Event-Driven Sync (RabbitMQ)

If enabled:

* Product updates triggered from backend
* Workers listen for messages
* Cache rebuild and metadata update events
* Real-time classification queue

---

## Database (PostgreSQL)

Schema includes:

* User
* Product
* Category
* Cart
* CartItem
* Authentication tokens
* Product images

---

## Deployment Architecture

```
Flutter App → Django API Gateway → PostgreSQL
                | 
                → Static files / Media files
                → AI Microservice (optional)
```

Or with containers:

```
Frontend (Flutter Web optional)
Backend (Django + Gunicorn)
Nginx Reverse Proxy
PostgreSQL DB
AI Service
```

---

## High-Level Architecture Diagram

```
               +---------------------+
               |     Flutter App     |
               +----------+----------+
                          |
                          v
               +---------------------+
               |   Django REST API   |
               +----------+----------+
                          |
      +-------------------+------------------+
      |                                      |
      v                                      v
+--------------+                     +------------------+
| PostgreSQL   |                     |  AI Microservice |
+--------------+                     +------------------+

Deployment Layer: Docker / CI-CD / Nginx
```

---

## Key Advantages

* Full-stack ecosystem using Flutter + Django + PostgreSQL
* Highly modular backend with clean separation
* Repository pattern ensures maintainable frontend code
* Supports image and product metadata
* Scalable architecture with optional AI microservices
* Works offline-ready for mobile apps
* Ideal for agriculture marketplaces or e-commerce-style platforms
* Ready for enterprise deployment


