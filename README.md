# Django 공지 알림 프로젝트

## 📌 개요
이 프로젝트는 Django를 사용하여 공지 알림 시스템을 구축한 것입니다. 데이터베이스로는 **SQLite**를 사용하여 가볍고 빠르게 데이터를 관리합니다.

## 🛠 환경 설정
### 1️⃣ Django 설치
다음 명령어를 실행하여 Django를 설치합니다.
```bash
pip install django djangorestframework
```

### 2️⃣ 프로젝트 생성
```bash
django-admin startproject notifications_project
cd notifications_project
python manage.py startapp notifications
```

## 📂 데이터베이스 모델
SQLite를 사용하여 공지 알림을 저장하는 간단한 모델을 정의합니다.

### 🔹 `models.py`
```python
from django.db import models

# Create your models here.
class Notice(models.Model):
    title = models.CharField(max_length=100)
    content = models.CharField(max_length=100)
    startDay = models.DateField()
    endDay = models.DateField()
```

### 🔹 마이그레이션 실행
```bash
python manage.py makemigrations
python manage.py migrate
```

## 🔀 CORS 설정 (Middleware 적용)
CORS 오류를 방지하기 위해 `settings.py`에서 CORS 미들웨어를 설정합니다.

### 🔹 `middleware.py`
```python
INSTALLED_APPS = [
    ...
    'corsheaders',
    'rest_framework',
    'noticeBoard',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    ...
]

CORS_ALLOW_ALL_ORIGINS = True
```

## 🔍 Serializers 설정
공지 데이터를 JSON 형태로 변환하기 위해 모델 시리얼라이저를 설정합니다.

### 🔹 `serializers.py`
```python
from rest_framework.serializers import ModelSerializer
from .models import Notice

class NoticeDataSerializer(ModelSerializer):
    class Meta:
        model = Notice
        fields = '__all__'
```

## 🔔 공지 알림 API 엔드포인트
Django의 `views.py`에서 API를 통해 공지 알림 데이터를 관리할 수 있도록 합니다.

### 🔹 `views.py`
```python
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Notice
from .serializers import NoticeDataSerializer

@api_view(['GET'])
def notification_list(request):
    notifications = Notice.objects.all()
    serializer = NoticeDataSerializer(notifications, many=True)
    return Response(serializer.data)
```

### 🔹 URL 설정 (`urls.py`)
```python
from django.urls import path
from . import views

app_name = 'noticeBoard'
urlpatterns = [
    path('datas/', views.UserView.as_view()),  # User에 관한 API를 처리하는 view로 Request를 넘김
]
```

## 🚀 실행 방법
1. 개발 서버 실행
    ```bash
    python manage.py runserver
    ```
2. 브라우저에서 `http://127.0.0.1:8000/notifications/` 접속하여 공지 데이터 확인

## 📌 결론
이 프로젝트는 Django와 SQLite를 이용하여 간단한 공지 알림 시스템을 구축하는 방법을 다루었습니다. 확장이 필요하다면 Django REST Framework를 도입하여 더욱 강력한 API를 만들 수 있습니다.

🔗 [Django 공식 문서](https://docs.djangoproject.com/)

