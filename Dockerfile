# based on https://code.steph.tools/steph/0x0/src/branch/master/Dockerfile
FROM python:3

WORKDIR /app

RUN pip install uwsgi

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
COPY ./config.py ./instance/config.py

EXPOSE 8080

CMD sleep 5 && FLASK_APP=fhost flask db upgrade && \
	uwsgi --socket 0.0.0.0:8080 --wsgi-file fhost.py --callable app --processes 4 --threads 2
