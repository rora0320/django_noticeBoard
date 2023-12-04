from datetime import date

from django.db import models


# Create your models here.
class Notice(models.Model):
    title = models.CharField(max_length=100)
    content = models.CharField(max_length=100)
    create_date = models.DateField(default=date.today)


