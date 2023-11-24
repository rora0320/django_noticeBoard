from rest_framework.serializers import ModelSerializer
from .models import Notice

class NoticeDataSerializer(ModelSerializer):
    class Meta:
        model = Notice
        fields ='__all__'