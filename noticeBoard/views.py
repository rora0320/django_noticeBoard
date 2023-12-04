from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
# from noticeBoard.models import Notice
from .models import Notice
from .seriallizers import NoticeDataSerializer
# Create your views here.
class UserView(APIView):
    def get(self, request):
        notice = Notice.objects.all()
        serializer = NoticeDataSerializer(notice, many=True)

        response = Response(serializer.data)
        response['Access-Control-Allow-Origin'] = '*'
        return response