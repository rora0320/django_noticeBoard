FROM python:3.11

COPY . /djangoProject
WORKDIR /djangoProject
RUN python3 -m venv venv && . venv/bin/activate

WORKDIR /djangoProject/noticeBoard
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000