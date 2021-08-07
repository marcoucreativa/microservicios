FROM python:3.9.2-alpine3.13
WORKDIR /app
COPY . .
RUN apk --no-cache add curl
RUN apk --no-cache add bash
RUN pip3 install -r requirements.txt
CMD ["python3", "-m", "flask", "run", "--host", "0.0.0.0", "--port", "2000"]