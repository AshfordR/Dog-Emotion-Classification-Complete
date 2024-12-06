FROM python:3.12

WORKDIR /app

RUN apt update
RUN pip install --no-cache-dir --upgrade pip
RUN pip install flask
COPY /requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

COPY . /app/
EXPOSE 5000

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

ENTRYPOINT ["flask", "run"]
CMD []
