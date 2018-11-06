FROM python:3.7-alpine

ENV TOKEN $TOKEN
ENV PORT $PORT

ADD ./requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt

ADD ./main.py /opt/main.py
WORKDIR /opt

CMD ["python", "main.py"]
