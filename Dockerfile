FROM ubuntu:trusty
MAINTAINER chris@heisel.org

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	python \
	python-dev \
	python-setuptools \
	nginx \
	supervisor \
	python-software-properties

RUN easy_install pip

RUN pip install uwsgi supervisor-stdout
WORKDIR /var/app

ADD requirements.txt /var/app/
RUN pip install -r requirements.txt

# Copy the rest of the code later to take advantage of Dockers cache
ADD . /var/app

#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN rm /etc/nginx/sites-enabled/default
#RUN ln -s /var/app/configs/nginx-app.conf /etc/nginx/sites-enabled/
#RUN ln -s /var/app/configs/supervisor-app.conf /etc/supervisor/conf.d/

EXPOSE 8000
#CMD ["supervisord", "-n"]
CMD ["python", "/var/app/sample/manage.py", "runserver", "0.0.0.0:8000"]