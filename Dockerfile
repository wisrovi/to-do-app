FROM python:3.8

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install net-tools
RUN apt install iputils-ping -y

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DOCKER 1
ENV DJANGO_ENV DEV

# install dependencies
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

# copy project
COPY . .

CMD ["python", "-m", "gunicorn", "source.app.wsgi:application", "--reload", "--workers 4"]