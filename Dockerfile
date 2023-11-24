FROM python:3.11
RUN pip3 install Django djangorestframework

COPY . /djangoProject
WORKDIR /djangoProject
RUN python3 -m venv venv && . venv/bin/activate

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000