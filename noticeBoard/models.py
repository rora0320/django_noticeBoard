from django.db import models


# Create your models here.
class Notice(models.Model):
    title = models.CharField(max_length=100)
    content = models.CharField(max_length=100)
    startDay = models.DateField()
    endDay = models.DateField()

