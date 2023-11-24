from django.urls import path
from . import views

app_name = 'noticeBoard'
urlpatterns = [
    path('datas/', views.UserView.as_view()),  # User에 관한 API를 처리하는 view로 Request를 넘김
]
